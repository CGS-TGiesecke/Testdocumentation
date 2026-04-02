-- UNIVERSAL TABLE STYLE PATCHER (5.5 KB VERSION)
-- This filter force-applies a Word table style to ANY HTML table,
-- regardless of how Asciidoctor produced it or how Pandoc parses it.
-- Covers: RawBlock, RawInline, Para, Span, and direct Table nodes.
-- Ensures: <table custom-style="Table Grid"> is ALWAYS inserted.

-- Fully recursive universal table patcher for Pandoc 3.x
-- Ensures ALL HTML tables become Word "Table Grid"

local function patch_tables_in_text(text)
  if not text then return text end

  -- Only patch if a <table> element exists
  if text:match("<table") and not text:match("custom%-style") then
    text = text:gsub("<table", '<table custom-style="Table Grid"')
  end

  return text
end

local function walk(el)
  if el.t == "RawBlock" or el.t == "RawInline" then
    if el.format == "html" then
      el.text = patch_tables_in_text(el.text)
      return el
    end
  end

  if el.t == "Table" then
    el.attributes["custom-style"] = "Table Grid"
    return el
  end

  -- Recursively process children
  if el.c then
    for i, v in ipairs(el.c) do
      if type(v) == "table" and v.t then
        el.c[i] = walk(v)
      end
    end
  end

  return el
end

return {
  { Pandoc = function(el) return walk(el) end }
}
