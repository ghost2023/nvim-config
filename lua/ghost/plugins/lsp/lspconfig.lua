return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local ensure_installed = {
			-- "ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"gopls",
			"emmet_ls",
			"prismals",
		}

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = ensure_installed,
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "css", "sass", "scss", "less" },
			showSuggestionsAsSnippets = false,
		})

		vim.diagnostic.config({
			float = { border = "single" },
		})
		-- vim.lsp.config("vtsls", {
		-- 	cmd = { "tsgo", "--lsp", "--stdio" },
		-- settings = {
		-- 	["js/ts"] = {
		-- 		hover = {
		-- 			maximumLength = 500,
		-- 		},
		-- 	},
		-- },
		--
		-- init_options = {
		-- 	preferences = {
		-- 		includeInlayParameterNameHints = "all",
		-- 		includeInlayPropertyDeclarationTypeHints = true,
		-- 		includeInlayFunctionLikeReturnTypeHints = true,
		-- 		includeInlayVariableTypeHints = true,
		-- 	},
		-- },
		-- })

		vim.lsp.config("ts_ls", {
			cmd = { "tsc", "--lsp", "--stdio" },
			cmd_env = { GOMEMLIMIT = "3GiB", GOGC = "50" },
			-- cmd_env = {
			-- 	GOMEMLIMIT = "1.5GiB",
			-- },
			-- settings = {
			-- 	["js/ts"] = {
			-- 		hover = {
			-- 			maximumLength = 500,
			-- 		},
			-- 	},
			-- },
			--
			-- init_options = {
			-- 	preferences = {
			-- 		includeInlayParameterNameHints = "all",
			-- 		includeInlayPropertyDeclarationTypeHints = true,
			-- 		includeInlayFunctionLikeReturnTypeHints = true,
			-- 		includeInlayVariableTypeHints = true,
			-- 	},
			-- },
		})

		if vim.fn.executable("oxlint") == 1 then
			vim.lsp.enable("oxlint")
		end
		-- vim.lsp.config("tailwindcss", {
		-- 	filetypes = { "html", "css", "scss", "tsx", "jsx" },
		-- })
	end,
}
