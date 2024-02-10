return {
	{
		"bluz71/vim-nightfly-guicolors",
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "deep",
			})
		end,
	},
	{ "AlexvZyl/nordic.nvim" },
	{ "Mofiqul/vscode.nvim" },
	{ "Mofiqul/adwaita.nvim" },
	{ "catppuccin/nvim", as = "catppuccin" },
	{ "bluz71/vim-nightfly-guicolors" },
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{
		"rose-pine/neovim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[colorscheme rose-pine-main]])
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
	},
	{ "projekt0n/github-nvim-theme" },
}
