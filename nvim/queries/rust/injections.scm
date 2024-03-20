; extends

((string_literal) @injection.content
((#match? @injection.content "^\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @injection.content 0 1 0 -1)
(#set! injection.language "sql")))

((raw_string_literal) @injection.content
((#match? @injection.content "^r\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @injection.content 0 2 0 -1)
(#set! injection.language "sql")))

((raw_string_literal) @injection.content
((#match? @injection.content "^r#\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @injection.content 0 3 0 -2)
(#set! injection.language "sql")))


((raw_string_literal) @injection.content
((#match? @injection.content "^r#\"\n[\{\[]")
(#offset! @injection.content 0 3 0 -2)
(#set! injection.language "json")))

((raw_string_literal) @injection.content
((#match? @injection.content "^r#\"\n\<")
(#offset! @injection.content 0 3 0 -2)
(#set! injection.language "html")))

