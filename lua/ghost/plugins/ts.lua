return {
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup()
		end,
	},
	{
		-- "pmizio/typescript-tools.nvim",
		-- dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		-- opts = {},
	},
}