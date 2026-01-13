; extends

((link_destination) @injection.content
  (#lua-match? @injection.content "^https://")
  (#set! injection.language "kulala_http"))
