

-- Apply to real Pandoc tables
function Table(el)
  el.attributes['custom-style'] = 'Table Grid'
  return el
end

-- Apply to raw HTML <table> ... </table>
function RawBlock(el)
  if el.format == "html" and el.text:match("<table") then
    -- inject custom-style="Table Grid"
    local patched = el.text:gsub("<table", '<table custom-style="Table Grid"')
    el.text = patched
  end
  return el
end


