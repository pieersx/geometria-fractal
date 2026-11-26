-- Filtro de pandoc: figuras, tablas y ecuaciones con formato APA 7.
--  * Figura: "Figura N.k" (negrita), título corto en cursiva, imagen y "Nota." al pie.
--    Sintaxis en el .md:  ![Título corto](ruta.png){width=80% nota="Texto de la nota."}
--  * Tabla: "Tabla N.k" (negrita) y título en cursiva ENCIMA de la tabla.
--    Sintaxis en el .md:  una línea ": Título corto" después de la tabla.
--  * Ecuación en bloque: se numera como (N.k) a la derecha.
-- Además escribe en ENTRIES_TSV la lista de encabezados, figuras y tablas, y marca cada uno con
-- una ficha invisible para que el script de compilación sepa en qué página cayó.

local chapter = nil
local figc, tabc, eqc, tok = 0, 0, 0, 0
local entries = {}

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

local function next_token()
  tok = tok + 1
  return tok, '<span class="tok">QQT' .. tok .. 'QQ</span>'
end

local function numlabel(counter)
  if chapter then return chapter .. "." .. counter end
  return tostring(counter)
end

function Header(h)
  if h.level > 2 then return nil end
  local first = h.content[1]
  if first and first.t == "RawInline" and first.text:find("QQT", 1, true) then return nil end
  local text = pandoc.utils.stringify(h)
  if h.level == 1 then
    local n = text:match("^Cap.-tulo (%d+)%.")
    if n then
      chapter = tonumber(n)
      figc, tabc, eqc = 0, 0, 0
    elseif text:match("^Anexo") then
      chapter = "A"
      figc, tabc, eqc = 0, 0, 0
    else
      chapter = nil
    end
  end
  local t, html = next_token()
  table.insert(entries, { "h", tostring(h.level), "", tostring(t), text })
  table.insert(h.content, 1, pandoc.RawInline("html", html))
  return h
end

function Figure(fig)
  local img
  pandoc.walk_block(fig, { Image = function(i) img = img or i end })
  if not img then return nil end
  figc = figc + 1
  local num = numlabel(figc)
  local title = pandoc.utils.stringify(fig.caption.long)
  if title == "" then title = pandoc.utils.stringify(img.caption) end
  local t, tokhtml = next_token()
  table.insert(entries, { "f", "", num, tostring(t), title })

  local width = img.attributes["width"] or "80%"
  local nota = img.attributes["nota"]
  local notahtml = ""
  if nota and nota ~= "" then
    local doc = pandoc.read(nota, "markdown+smart")
    local inl = {}
    for _, b in ipairs(doc.blocks) do
      if b.content then for _, x in ipairs(b.content) do table.insert(inl, x) end end
    end
    local rendered = pandoc.write(pandoc.Pandoc({ pandoc.Plain(inl) }), "html"):gsub("\n$", "")
    notahtml = '<p class="nota"><em>Nota.</em> ' .. rendered .. "</p>"
  end
  local html = '<figure class="apa" id="fig-' .. num:gsub("%.", "-") .. '">' .. tokhtml ..
    '<p class="fnum">Figura ' .. num .. '</p><p class="ftit">' .. esc(title) .. "</p>" ..
    '<img src="' .. esc(img.src) .. '" alt="' .. esc(title) .. '" style="width:' .. width .. '">' ..
    notahtml .. "</figure>"
  return pandoc.RawBlock("html", html)
end

function Table(tbl)
  local title = pandoc.utils.stringify(tbl.caption.long)
  if title == "" then return nil end
  tabc = tabc + 1
  local num = numlabel(tabc)
  local t, tokhtml = next_token()
  table.insert(entries, { "t", "", num, tostring(t), title })
  tbl.caption.long = pandoc.Blocks({})
  tbl.caption.short = nil
  local head = pandoc.RawBlock("html", '<div class="tabcap">' .. tokhtml ..
    '<p class="tnum">Tabla ' .. num .. '</p><p class="ttit">' .. esc(title) .. "</p></div>")
  return { head, tbl }
end

function Para(p)
  if #p.content == 1 and p.content[1].t == "Math" and p.content[1].mathtype == "DisplayMath" then
    eqc = eqc + 1
    return pandoc.Div({
      pandoc.Div({ pandoc.Plain({ p.content[1] }) }, pandoc.Attr("", { "eqm" })),
      pandoc.Div({ pandoc.Plain({ pandoc.Str("(" .. numlabel(eqc) .. ")") }) }, pandoc.Attr("", { "eqn" })),
    }, pandoc.Attr("", { "eq" }))
  end
  return nil
end

function Pandoc(doc)
  local path = os.getenv("ENTRIES_TSV")
  if path then
    local f = io.open(path, "w")
    for _, e in ipairs(entries) do f:write(table.concat(e, "\t"), "\n") end
    f:close()
  end
  return nil
end

-- Orden de ejecución: encabezados y figuras antes que tablas y párrafos, en una sola pasada por documento
return {
  { traverse = "topdown", Header = Header, Figure = Figure, Table = Table, Para = Para },
  { Pandoc = Pandoc },
}
