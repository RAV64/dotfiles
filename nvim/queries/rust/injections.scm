(call_expression
 (field_expression
  field: (field_identifier) @_field (#eq? @_field "query"))

 (arguments
  (raw_string_literal) @sql)
  (#offset! @sql 0 1 0 -1))
