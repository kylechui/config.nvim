local nl = require("null-ls")

nl.setup({
	sources = {
		nl.builtins.formatting.prettier,
		-- sumneko_lua does not have integrated formatting yet
		nl.builtins.formatting.stylua,
	},
})
