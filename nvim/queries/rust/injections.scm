; extends

((string_content) @injection.content
  (#match? @injection.content "^\\_s*(SELECT|DELETE|UPDATE|INSERT|CREATE|ALTER|DROP|EXEC)")
  (#set! injection.language "sql"))

((string_content) @injection.content
  (#match? @injection.content "^\\_s*[\\<]\\_.*[\\>]\\_s*$")
  (#set! injection.language "xml"))

((string_content) @injection.content
  (#match? @injection.content "^\\_s*[\\{]\\_.*[\\}]\\_s*$")
  (#set! injection.language "json"))

((string_content) @injection.content
  (#match? @injection.content "^\\_s*[\\[]\\_.*[\\]]\\_s*$")
  (#set! injection.language "json"))
