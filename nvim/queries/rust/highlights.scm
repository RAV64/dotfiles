; extends

((string_literal) @codeblock
((#match? @codeblock "^\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @codeblock 0 1 0 -1)))

((raw_string_literal) @codeblock
((#match? @codeblock "^r#?\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @codeblock 0 2 0 -1)))



((raw_string_literal) @codeblock
((#match? @codeblock "^r#\"\n[\{\[]")
(#offset! @codeblock 0 3 0 -2)))
