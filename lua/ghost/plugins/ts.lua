return {
	-- {
	-- 	"marilari88/twoslash-queries.nvim",
	--    event = "VeryLazy",
	-- 	config = function()
	-- 		local cmp_nvim_lsp = require("cmp_nvim_lsp")
	-- 		require("lspconfig")["tsserver"].setup({
	-- 			capabilities = cmp_nvim_lsp.default_capabilities(),
	-- 			on_attach = function(client, bufnr)
	-- 				require("twoslash-queries").attach(client, bufnr)
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	{
		"dmmulroy/tsc.nvim",
		cmd = "TSC",
		config = function()
			require("tsc").setup()
		end,
	},
	{
		"OlegGulevskyy/better-ts-errors.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		ft = { "typescript", "typescriptreact" },
		cmd = { "BetterTSErrors" },
		config = {
			keymaps = {
				toggle = nil,
				go_to_definition = nil,
			},
		},
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		settings = {
	-- 			separate_diagnostic_server = false,
	-- 			publish_diagnostic_on = "change",
	-- 		},
	-- 	},
	-- },
}
