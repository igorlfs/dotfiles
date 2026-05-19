; extends

; hyprland
((function_call
  name: (dot_index_expression
    field: (identifier) @sh)
  (#eq? @sh "exec_cmd")
  arguments: (arguments
    (string
      content: (string_content) @injection.content)))
  (#set! injection.language "sh"))
