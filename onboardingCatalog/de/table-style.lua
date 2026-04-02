-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert

-- Apply style to HTML tables that Pandoc does NOT parse as Table objects
function RawBlock(el)
  if el.format == "html" then
    -- Jede Art von <table> wird ersetzt, egal wie Asciidoctor sie erzeugt
    if el.text:match("<table") then
      el.text = el.text:gsub("<table", '<table custom-style="Table Grid"')
    end
  end
  return el
end

function RawInline(el)
  if el.format == "html" then
    if el.text:match("<table") then
      el.text = el.text:gsub("<table", '<table custom-style="Table Grid"')
    end
  end
  return el
end

-- Apply style to real Pandoc Table elements
function Table(el)
  el.attributes['custom-style'] = 'Table Grid'
  return el
end





