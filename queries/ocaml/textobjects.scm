;; extends
; Swappable items
(_) @node

(list_expression (_) @swappable)
(record_expression (_) @swappable)
(infix_expression left: (_) @swappable (rel_operator) right: (_))
(infix_expression left: (_) (rel_operator) right: (_) @swappable)
(let_binding (parameter) @swappable)
argument: (_) @swappable
