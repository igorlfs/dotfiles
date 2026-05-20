; extends

(variable_declarator
  (array_pattern
    (object_pattern
      (shorthand_property_identifier_pattern) @local.definition.var)))

(variable_declarator
  (array_pattern
    (identifier) @local.definition.var))

; (reference) Svelte injections
; These are not really useful, the mostly contain gibberish when inspecting with virtual text
; ($inspect is the prefered way of debugging)
; {@const foo = ...}
; (assignment_expression
;   (identifier) @local.definition)
; {each ... as foo, bar}
; (sequence_expression
;   (identifier) @local.definition)
