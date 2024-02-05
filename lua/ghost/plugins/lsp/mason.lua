return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				-- "svelte",
				"lua_ls",
				-- "graphql",
				-- "emmet_ls",
				"prismals",
				"pyright",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				-- "pylint", -- python linter
				"eslint_d", -- js linter
			},
		})
	end,
}

-- -- import mason plugin safely
-- local mason_status, mason = pcall(require, "mason")
-- if not mason_status then
--   return
-- end
--
-- -- import mason-lspconfig plugin safely
-- local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
-- if not mason_lspconfig_status then
--   return
-- end
--
-- -- import mason-null-ls plugin safely
-- local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
-- if not mason_null_ls_status then
--   return
-- end
--
-- -- enable mason
-- mason.setup()
--
-- mason_lspconfig.setup({
--   -- list of servers for mason to install
--   ensure_installed = {
--     "tsserver",
--     "html",
--     "cssls",
--     "tailwindcss",
--     "lua_ls",
--     "emmet_ls",
--   },
--   -- auto-install configured servers (with lspconfig)
--   automatic_installation = true, -- not the same as ensure_installed
-- })
--
-- mason_null_ls.setup({
--   -- list of formatters & linters for mason to install
--   ensure_installed = {
--     "prettier", -- ts/js formatter
--     "stylua", -- lua formatter
--     "eslint_d", -- ts/js linter
--   },
--   update_in_insert = true,
--   -- auto-install configured formatters & linters (with null-ls)
--   automatic_installation = true,
-- })
