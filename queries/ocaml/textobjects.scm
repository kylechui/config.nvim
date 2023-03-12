; Swappable items
(_) @node

(list_expression (_) @swappable)
(record_expression (_) @swappable)
(infix_expression left: (_) @swappable (infix_operator) right: (_))
(infix_expression left: (_) (infix_operator) right: (_) @swappable)
(let_binding (parameter) @swappable)
argument: (_) @swappable
