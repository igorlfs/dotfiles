; extends

((comment) @mark
  (#eq? @mark "/*sql*/")
  (template_string
    (string_fragment) @injection.content
    (#set! injection.language "sql")
    (#set! injection.combined)))

((comment) @mark
  (#eq? @mark "/*liquid*/")
  (template_string
    (string_fragment) @injection.content
    (#set! injection.language "liquid")))
