return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		config = function()
			local conform = require("conform")
			local ecma = { "oxfmt", "prettierd", "prettier" }
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					javascript = ecma,
					typescript = ecma,
					javascriptreact = ecma,
					typescriptreact = ecma,
				},

				format_on_save = {
					timeout_ms = 250,
					lsp_format = "fallback",
				},
			})
		end,
	},
}
