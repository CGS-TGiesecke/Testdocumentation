-- UNIVERSAL TABLE STYLE PATCHER (5.5 KB VERSION)
-- This filter force-applies a Word table style to ANY HTML table,
-- regardless of how Asciidoctor produced it or how Pandoc parses it.
-- Covers: RawBlock, RawInline, Para, Span, and direct Table nodes.
-- Ensures: <table custom-style="Table Grid"> is ALWAYS inserted.

-- Normalize text manipulation
local function patch_tables(text)
  if not text then return text end

  -- Only patch HTML tables
  if text:match("<table") then

    -- Avoid double-inserting custom-style
    if not text:match("custom%-style") then
      -- Insert custom-style="Table Grid" into the <table ...> tag
      text = text:gsub("<table", '<table custom-style="Table Grid"')
    end
  end

  return text
end

-----------------------------------------------------------
-- RAWBLOCK HANDLER (HTML blocks)
-----------------------------------------------------------
function RawBlock(el)
  if el.format == "html" then
    el.text = patch_tables(el.text)
  end
  return el
end

-----------------------------------------------------------
-- RAWINLINE HANDLER (inline HTML fragments)
-----------------------------------------------------------
function RawInline(el)
  if el.format == "html" then
    el.text = patch_tables(el.text)
  end
  return el
end

-----------------------------------------------------------
-- PARA HANDLER (tables inside paragraphs)
-----------------------------------------------------------
function Para(el)
  for i, c in ipairs(el.content) do
    if type(c.text) == "string" then
      c.text = patch_tables(c.text)
    end
  end
  return el
end

-----------------------------------------------------------
-- SPAN HANDLER (inline content containers)
-----------------------------------------------------------
function Span(el)
  for i, c in ipairs(el.content) do
    if type(c.text) == "string" then
      c.text = patch_tables(c.text)
    end
  end
  return el
end

-----------------------------------------------------------
-- TABLE HANDLER (Pandoc-native Table nodes)
-----------------------------------------------------------
function Table(el)
  -- Apply Word table style explicitly
  el.attributes["custom-style"] = "Table Grid"
  return el
end

-----------------------------------------------------------
-- BLOCKQUOTE HANDLER (in case tables are wrapped inside blockquotes)
-----------------------------------------------------------
function BlockQuote(el)
  for i, c in ipairs(el.content) do
    if c.text then
      c.text = patch_tables(c.text)
    end
  end
  return el
end

-----------------------------------------------------------
-- DIV HANDLER (Asciidoctor often nests HTML tables inside <div>)
-----------------------------------------------------------
function Div(el)
  for i, c in ipairs(el.content) do
    if c.text then
      c.text = patch_tables(c.text)
    end
  end
  return el
end

-----------------------------------------------------------
-- HEADER HANDLER (unlikely but tables can appear)
-----------------------------------------------------------
function Header(el)
  for i, c in ipairs(el.content) do
    if c.text then
      c.text = patch_tables(c.text)
    end
  end
  return el
end

-----------------------------------------------------------
-- LIST HANDLERS (tables within list items)
-----------------------------------------------------------
function BulletList(el)
  for i, item in ipairs(el.content) do
    for j, c in ipairs(item) do
      if c.text then
        c.text = patch_tables(c.text)
      end
    end
  end
  return el
end

function OrderedList(el)
  for i, item in ipairs(el.content) do
    for j, c in ipairs(item) do
      if c.text then
        c.text = patch_tables(c.text)
      end
    end
  end
  return el
end

-----------------------------------------------------------
-- CODEBLOCK (ignore – but included for completeness)
-----------------------------------------------------------
function CodeBlock(el)
  -- no-op
  return el
end

-----------------------------------------------------------
-- FINAL: Return unmodified elements for all others
-----------------------------------------------------------
return {
  RawBlock = RawBlock,
  RawInline = RawInline,
  Para = Para,
  Span = Span,
  Table = Table,
  BlockQuote = BlockQuote,
  Div = Div,
  Header = Header,
  BulletList = BulletList,
  OrderedList = OrderedList,
  CodeBlock = CodeBlock
}
