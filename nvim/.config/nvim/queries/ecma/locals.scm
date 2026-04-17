; extends

(variable_declarator
  (array_pattern
    (object_pattern
      (shorthand_property_identifier_pattern) @local.definition.var)))

(variable_declarator
  (array_pattern
    (identifier) @local.definition.var))
