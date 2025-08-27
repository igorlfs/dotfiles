; extends

((literal) @injection.content
  (#match? @injection.content "'''")
  (#offset! @injection.content 0 3 0 -3)
  (#set! injection.language "json"))
