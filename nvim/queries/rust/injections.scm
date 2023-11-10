; extends

((string_literal) @sql
((#match? @sql "^\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @sql 0 1 0 -1)))

((raw_string_literal) @sql
((#match? @sql "^r\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @sql 0 2 0 -1)))

((raw_string_literal) @sql
((#match? @sql "^r#\"\n(SELECT|DELETE|UPDATE|INSERT INTO|CREATE|ALTER TABLE|DROP)")
(#offset! @sql 0 3 0 -2)))


((raw_string_literal) @json
((#match? @json "^r#\"\n[\{\[]")
(#offset! @json 0 3 0 -2)))
