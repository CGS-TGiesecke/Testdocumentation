-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert
-- Was dieser Filter löst:

-- fängt jede Tabelle ab – auch wenn sie aus Asciidoc als Raw‑HTML kommt
-- sorgt dafür, dass wirklich der Word‑Stil „Table Grid“ gesetzt wird
-- ignoriert CSS vollständig (CSS ist Pandoc‑irrelevant in DOCX)
-- funktioniert ohne class="TableGrid" im HTML
-- funktioniert auch mit [.TableGrid] im Asciidoc
-- funktioniert unabhängig davon, wie Asciidoctor Tabellen rendert


-- UNIVERSAL TABLE STYLE PATCHER
-- Fängt jede Art von HTML-Tabelle ab, egal wo Pandoc sie einsortiert.


-- UNIVERSAL TABLE STYLE PATCHER

local function patch_tables(text)
  if not text then return text end
  if text:match("<table") and not text:match("custom%-style") then
    text = text:gsub("<table", '<table custom-style="Table Grid"')
  end
  return text
end

function RawBlock(el)
  if el.format == "html" then
    el.text = patch_tables(el.text)
  end
  return el
end

function RawInline(el)
  if el.format == "html" then
    el.text = patch_tables(el.text)
  end
  return el
end

function Para(el)
  for i,c in ipairs(el.content) do
    if type(c.text) == "string" then
      c.text = patch_tables(c.text)
    end
  end
  return el
end

function Span(el)
  for i,c in ipairs(el.content) do
    if type(c.text) == "string" then
      c.text = patch_tables(c.text)
    end
  end
  return el
end

function Table(el)
  el.attributes["custom-style"] = "Table Grid"
  return el
end





























































































