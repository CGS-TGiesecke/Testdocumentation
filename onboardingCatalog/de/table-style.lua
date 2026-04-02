-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert


-- 1) Für echte Pandoc-Tabellen (falls Pandoc doch mal eine erkennt)
function Table(el)
  el.attributes['custom-style'] = 'Table Grid'
  return el
end

-- 2) Für HTML-Tabellen in RawBlock
function RawBlock(el)
  if el.format == "html" then
    if el.text:match("<table") then
      el.text = el.text:gsub("<table", '<table custom-style="Table Grid"')
    end
  end
  return el
end

-- 3) Für Inline-HTML Tabellen
function RawInline(el)
  if el.format == "html" then
    if el.text:match("<table") then
      el.text = el.text:gsub("<table", '<table custom-style="Table Grid"')
    end
  end
  return el
end






