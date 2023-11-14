-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
  ]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	-- use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	-- -- colorschemes
	-- use({ "navarasu/onedark.nvim" })
	-- use({ "AlexvZyl/nordic.nvim" })
	-- -- use {"sainnhe/sonokai.nvim"}
	-- use({ "Mofiqul/vscode.nvim" })
	-- use({ "Mofiqul/adwaita.nvim" })
	-- use({ "catppuccin/nvim", as = "catppuccin" })
	-- use("bluz71/vim-nightfly-guicolors")

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	-- use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	-- use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	-- use("numToStr/Comment.nvim")

	-- file explorer
	-- use("nvim-tree/nvim-tree.lua")

	-- vs-code like icons
	-- use("nvim-tree/nvim-web-devicons")

	-- statusline
	-- use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	-- use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	-- use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- -- snippets
	-- use("L3MON4D3/LuaSnip") -- snippet engine
	-- use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	-- use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	-- use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	-- use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	-- use("neovim/nvim-lspconfig") -- easily configure language servers
	-- use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	-- use({
	-- 	"glepnir/lspsaga.nvim",
	-- 	branch = "main",
	-- 	requires = {
	-- 		{ "nvim-tree/nvim-web-devicons" },
	-- 		{ "nvim-treesitter/nvim-treesitter" },
	-- 	},
	-- }) -- enhanced lsp uis
	-- use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	-- use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- -- formatting & linting
	-- use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	-- use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- -- treesitter configuration
	-- use({
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	requires = {
	-- 		"JoosepAlviste/nvim-ts-context-commentstring",
	-- 	},
	-- 	run = function()
	-- 		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
	-- 		ts_update()
	-- 	end,
	-- })

	-- auto closing
	-- use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	-- git integration
	-- use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- codeium
	use({
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<C-i>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
	})

	-- use({
	-- 	"akinsho/toggleterm.nvim",
	-- 	tag = "*",
	-- 	config = function()
	-- 		require("toggleterm").setup()
	-- 	end,
	-- })

	-- use({
	-- 	"folke/which-key.nvim",
	-- 	config = function()
	-- 		vim.o.timeout = true
	-- 		vim.o.timeoutlen = 600
	-- 		require("which-key").setup({
	-- 			-- your configuration comes here
	-- 			-- or leave it empty to use the default settings
	-- 			-- refer to the configuration section below
	-- 		})
	-- 	end,
	-- })

	-- use({
	-- 	"kylechui/nvim-surround",
	-- 	tag = "*", -- Use for stability; omit to use `main` branch for the latest features
	-- 	config = function()
	-- 		require("nvim-surround").setup({
	-- 			-- Configuration here, or leave empty to use defaults
	-- 		})
	-- 	end,
	-- })

	-- use({
	-- 	"f-person/git-blame.nvim",
	-- 	config = function()
	-- 		require("gitblame").setup({
	-- 			enabled = false,
	-- 		})
	-- 	end,
	-- })

	-- use({
	-- 	"folke/trouble.nvim",
	-- 	requires = { { "nvim-tree/nvim-web-devicons" } },
	-- })

	-- use("sindrets/diffview.nvim")

	-- -- flutter_tools
	-- use({
	-- 	"akinsho/flutter-tools.nvim",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"stevearc/dressing.nvim", -- optional for vim.ui.select
	-- 	},
	-- })

	-- use({ "mg979/vim-visual-multi" })
	use({
		"rmagatti/auto-session",
	})
	-- use({ "tpope/vim-fugitive" })

	-- use({
	-- 	"goolord/alpha-nvim",
	-- 	requires = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.startify").config)
	-- 	end,
	-- })

	-- use({
	-- 	"folke/todo-comments.nvim",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("todo-comments").setup({
	-- 			-- Configuration here, or leave empty to use defaults
	-- 		})
	-- 	end,
	-- })

	-- use({
	-- 	"rebelot/kanagawa.nvim",
	-- })

	-- use("edeneast/nightfox.nvim")

	-- use({
	-- 	"NeogitOrg/neogit",
	-- 	config = function()
	-- 		require("neogit").setup()
	-- 	end,
	-- })

	-- use("rcarriga/nvim-notify")
	-- use({
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	config = function()
	-- 		require("ibl").setup()
	-- 	end,
	-- })

	-- use({
	-- 	"romgrk/barbar.nvim",
	-- 	config = function()
	-- 		require("barbar").setup({
	-- 			sidebar_filetypes = {
	-- 				["nvim-tree"] = true,
	-- 			},
	-- 		})
	-- 	end,
	-- })

	use("HiPhish/rainbow-delimiters.nvim")

	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				max_lines = 1,
				multiline_threshold = 1,
			})
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
