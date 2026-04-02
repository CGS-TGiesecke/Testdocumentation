-- FINAL: Pandoc-native table style assignment
-- Works reliably with Pandoc 3.x and Asciidoctor HTML

function Table(el)
  el.attributes["custom-style"] = "Table Grid"
  return el
end
