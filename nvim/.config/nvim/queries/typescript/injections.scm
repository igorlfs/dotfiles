; extends

((comment) @injection.language
  (template_string
    (string_fragment) @injection.content
    (#set! injection.combined))
  (#gsub! @injection.language "/%*%s*([%w%p]+)%s*%*/" "%1"))
