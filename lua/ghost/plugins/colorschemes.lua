return {
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "deep",
			})
		end,
	},
	{
		"w0ng/vim-hybrid",
	},
	{ "Mofiqul/vscode.nvim" },
	{ "rafalbromirski/vim-aurora" },
	{ "catppuccin/nvim", as = "catppuccin" },
	{ "nanotech/jellybeans.vim" },
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "rose-pine/neovim" },
	{
		"tiagovla/tokyodark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
	{ "projekt0n/github-nvim-theme" },
}
