; extends
; jukit
(
  (block_comment) @injection.content
  (#match? @injection.content "°°°")
  (#set! injection.language "markdown")
 )
