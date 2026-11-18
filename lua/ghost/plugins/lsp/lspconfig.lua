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
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "css", "sass", "scss", "less" },
			showSuggestionsAsSnippets = false,
		})
		vim.lsp.config("qmlls", {
			cmd = { "/usr/lib/qt6/bin/qmlls", "-I", "/usr/lib/qt6/qml" },
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
			settings = {
				typescript = {
					-- The project ships its own oRPC declaration contract (.gen/api),
					-- so scanning package.json exports and auto-installing @types is
					-- pure background work.
					disableAutomaticTypeAcquisition = true,
					preferences = {
						includePackageJsonAutoImports = "off",
					},
					tsserver = {
						maxTsServerMemory = 8192,
						watchOptions = {
							excludeDirectories = {
								"**/.gen/**",
								"**/dist/**",
								"**/drizzle/**",
								"**/test-results/**",
								"**/.fallow/**",
							},
						},
					},
				},
				javascript = {
					disableAutomaticTypeAcquisition = true,
					preferences = {
						includePackageJsonAutoImports = "off",
					},
				},
			},
		})

		if vim.fn.executable("oxlint") == 1 then
			vim.lsp.enable("oxlint")
		end
		-- vim.lsp.config("tailwindcss", {
		-- 	filetypes = { "html", "css", "scss", "tsx", "jsx" },
		-- })
	end,
}
