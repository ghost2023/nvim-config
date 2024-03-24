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
	{ "rockyzhang24/arctic.nvim" },
	{
		"marko-cerovac/material.nvim",
		config = function()
			vim.cmd("colorscheme material-deep-ocean")
		end,
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{ "sainnhe/edge" },
	{ "ray-x/starry.nvim" },
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
	},
	{ "projekt0n/github-nvim-theme" },
}
