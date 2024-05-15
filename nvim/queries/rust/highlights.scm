; extends

((string_content) @codeblock
((#match? @codeblock "^\n?(SELECT|DELETE|UPDATE|INSERT|CREATE|ALTER TABLE|DROP|EXEC)")
))

((string_content) @codeblock
((#match? @codeblock "^\n?[\{\[\<]")
))
