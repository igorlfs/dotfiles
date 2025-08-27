; extends

((comment) @mark
  (#eq? @mark "/*sql*/")
  (template_string
    (string_fragment) @injection.content
    (#set! injection.language "sql")
    (#set! injection.combined)))
