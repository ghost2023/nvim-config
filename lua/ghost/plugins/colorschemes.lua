return {
	{
		"bluz71/vim-nightfly-guicolors",
	},
	{ "navarasu/onedark.nvim" },
	{ "AlexvZyl/nordic.nvim" },
	{ "sainnhe/sonokai" },
	{ "Mofiqul/vscode.nvim" },
	{ "Mofiqul/adwaita.nvim" },
	{ "catppuccin/nvim", as = "catppuccin" },
	{ "bluz71/vim-nightfly-guicolors" },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },
  {'jacoborus/tender.vim'},
  {'EdenEast/nightfox.nvim'
	  },
  {'rose-pine/neovim'},
  {'tiagovla/tokyodark.nvim',
	priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyodark]])
		end,
  },
  {'vigoux/oak'},
  {'sainnhe/edge'},
  {'ellisonleao/gruvbox.nvim'}
}
