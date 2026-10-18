return {
	{
		"marko-cerovac/material.nvim",
		config = function()
			vim.cmd("colorscheme material-deep-ocean")
		end,
		lazy = false,
		priority = 1000,
	},
	{
		lazy = true,
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{
		lazy = true,
		"nanotech/jellybeans.vim",
	},
	{
		lazy = true,
		"folke/tokyonight.nvim",
	},
	{
		lazy = true,
		"rose-pine/neovim",
	},
	{
		lazy = true,
		"tiagovla/tokyodark.nvim",
	},
	{
		lazy = true,
		"projekt0n/github-nvim-theme",
	},
	{
		lazy = true,
		"olimorris/onedarkpro.nvim",
	},
}
