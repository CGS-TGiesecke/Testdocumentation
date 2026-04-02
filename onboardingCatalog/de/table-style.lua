-- UNIVERSAL TABLE STYLE PATCHER (GitHub-safe + Pandoc-correct)

local function patch(text)
  if not text then return text end

  -- MATCH NORMAL <table>, NOT escaped!
  if text:match("<table") and not text:match("custom%-style") then

    -- BUT gsub MUST escape <table so GitHub does NOT eat it
    text = text:gsub("\\<table", '<table custom-style="Table Grid"')
  end

  return text
end

local function walk(el)
  if el.t == "RawBlock" or el.t == "RawInline" then
    if el.format == "html" then
      el.text = patch(el.text)
    end
    return el
  end

  if el.t == "Table" then
    el.attributes["custom-style"] = "Table Grid"
    return el
  end

  if el.c then
    for i,v in ipairs(el.c) do
      if type(v)=="table" and v.t then
        el.c[i] = walk(v)
      end
    end
  end

  return el
end

return {
  { Pandoc = function(doc) return walk(doc) end }
}
