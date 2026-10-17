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

; autocmds with vim cmds
(function_call
  (dot_index_expression
    field: (identifier) @api
    (#eq? @api "nvim_create_autocmd"))
  (arguments
    (table_constructor
      (field
        name: (identifier) @field
        value: (string
          (string_content) @injection.content)
        (#eq? @field "command")
        (#set! injection.language "vim")))))
