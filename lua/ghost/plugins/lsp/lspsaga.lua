return {
	{
		"glepnir/lspsaga.nvim",
		event = { "BufReadPre", "BufNewFile" },
		branch = "main",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			-- import lspsaga safely
			local saga = require("lspsaga")

			saga.setup({
				-- keybinds for navigation in lspsaga window
				scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
				-- use enter to open file with definition preview
				definition = {
					edit = "<CR>",
				},

				light_blub = {
					enable = false,
				},
				ui = {
					colors = {
						normal_bg = "#022746",
					},
				},
			})
		end,
	},

	{
		"romus204/referencer.nvim",
		config = function()
			require("referencer").setup({
				enable = true,
			})
		end,
	},
}
