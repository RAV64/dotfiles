; extends

((string_content) @injection.content
((#match? @injection.content "^\n?(SELECT|DELETE|UPDATE|INSERT|CREATE|ALTER|DROP|EXEC)")
(#set! injection.language "sql")))

((string_content) @injection.content
((#match? @injection.content "^\n?[\{][\s\S]*}\n?$")
(#set! injection.language "json")))

((string_content) @injection.content
((#match? @injection.content "^\n?[\[][\s\S]*]\n?$")
(#set! injection.language "json")))

; ((string_content) @injection.content
; ((#match? @injection.content "^\n?[\{\[].*[\}\]]\n?$")
; (#set! injection.language "json")))

((string_content) @injection.content
((#match? @injection.content "^\n?<[\s\S]*>\n?$")
(#set! injection.language "html")))
