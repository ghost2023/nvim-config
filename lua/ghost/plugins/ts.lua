return {
	{
		"marilari88/twoslash-queries.nvim",
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			require("lspconfig")["tsserver"].setup({
				capabilities = cmp_nvim_lsp.default_capabilities(),
				on_attach = function(client, bufnr)
					require("twoslash-queries").attach(client, bufnr)
				end,
			})
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup()
		end,
	},
}
