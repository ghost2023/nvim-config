return {
	{
		"w0ng/vim-hybrid",
	},
	{
		"marko-cerovac/material.nvim",
		config = function()
			vim.cmd("colorscheme material-deep-ocean")
		end,
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{ "Mofiqul/vscode.nvim" },
	{ "catppuccin/nvim", as = "catppuccin" },
	{ "nanotech/jellybeans.vim" },
	{ "folke/tokyonight.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "rose-pine/neovim" },
	{ "tiagovla/tokyodark.nvim", },
	{ "projekt0n/github-nvim-theme" },
}
