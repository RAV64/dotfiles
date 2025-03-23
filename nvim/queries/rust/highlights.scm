; extends

(
 (string_content) @codeblock
 (#match? @codeblock "^\\s*(SELECT|DELETE|UPDATE|INSERT|CREATE|ALTER TABLE|DROP|EXEC)")
)

(
  (string_content) @codeblock
  (#match? @codeblock "^\\_s*[(]\\_.*[)]\\_s*$")
)
(
  (string_content) @codeblock
  (#match? @codeblock "^\\_s*[{]\\_.*[}]\\_s*$")
)
(
  (string_content) @codeblock
  (#match? @codeblock "^\\_s*[[]\\_.*[]]\\_s*$")
)
(
  (string_content) @codeblock
  (#match? @codeblock "^\\_s*[<]\\_.*[>]\\_s*$")
)
