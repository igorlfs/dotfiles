; extends

((comment) @injection.language
  . ; force nodes to be adjacent, to prevent injections on multiple siblings (aka foo(/*bar*/`fizz`,`buzz`))
  (template_string
    (string_fragment) @injection.content
    (#set! injection.combined))
  (#gsub! @injection.language "/%*%s*([%w%p]+)%s*%*/" "%1"))

; foo.sql<type>`...`
(call_expression
  function: (non_null_expression
    (instantiation_expression
      (member_expression
        property: (property_identifier) @injection.language)))
  arguments: (template_string) @injection.content
  (#eq? @injection.language "sql")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

; foo.querySelector<type>(`...`)
((call_expression
  (member_expression
    (property_identifier) @prop)
  (arguments
    (string
      (string_fragment) @injection.content)))
  (#any-of? @prop "querySelector" "locator")
  (#set! injection.language "css"))
