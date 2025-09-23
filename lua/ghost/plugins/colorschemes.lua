return {
	{
		"w0ng/vim-hybrid",
		event = "VeryLazy",
	},
	{
		"marko-cerovac/material.nvim",
		config = function()
			vim.cmd("colorscheme material-deep-ocean")
		end,
		lazy = false,
		priority = 1000,
	},
	{
		event = "VeryLazy",
		"Mofiqul/vscode.nvim",
	},
	{
		event = "VeryLazy",
		"catppuccin/nvim",
		as = "catppuccin",
	},
	{
		event = "VeryLazy",
		"nanotech/jellybeans.vim",
	},
	{
		event = "VeryLazy",
		"folke/tokyonight.nvim",
	},
	{
		event = "VeryLazy",
		"rose-pine/neovim",
	},
	{
		event = "VeryLazy",
		"tiagovla/tokyodark.nvim",
	},
	{
		event = "VeryLazy",
		"projekt0n/github-nvim-theme",
	},
	{
		event = "VeryLazy",
		"rebelot/kanagawa.nvim",
	},
	{
		event = "VeryLazy",
		"olimorris/onedarkpro.nvim",
	},
}
