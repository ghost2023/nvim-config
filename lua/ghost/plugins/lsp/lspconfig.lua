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

		local lspconfig = require("lspconfig")

		local servers = vim.lsp.get_clients()

		for _, config in ipairs(servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[config.name].setup(config)
		end

		-- vim.lsp.config("ts_ls", {
		-- 	-- cmd = { "tsgo", "--lsp", "--stdio" },
		-- 	settings = {
		-- 		["js/ts"] = {
		-- 			hover = {
		-- 				maximumLength = 500,
		-- 			},
		-- 		},
		-- 	},
		--
		-- 	init_options = {
		-- 		preferences = {
		-- 			includeInlayParameterNameHints = "all",
		-- 			includeInlayPropertyDeclarationTypeHints = true,
		-- 			includeInlayFunctionLikeReturnTypeHints = true,
		-- 			includeInlayVariableTypeHints = true,
		-- 		},
		-- 	},
		-- })

		vim.lsp.config("tsgo", {
			-- cmd = { "tsgo", "--lsp", "--stdio" },
			cmd_env = {
				GOMEMLIMIT = "1.5GiB",
			},
		})

		-- vim.lsp.config("tailwindcss", {
		-- 	filetypes = { "html", "css", "scss", "tsx", "jsx" },
		-- })
	end,
}
