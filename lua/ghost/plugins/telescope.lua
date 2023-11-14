return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					-- ".git",
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
	end,
}

-- import telescope plugin safely
-- local telescope_setup, telescope = pcall(require, "telescope")
-- if not telescope_setup then
-- 	return
-- end
--
-- -- import telescope actions safely
-- local actions_setup, actions = pcall(require, "telescope.actions")
-- if not actions_setup then
-- 	return
-- end
--
-- -- configure telescope
-- telescope.setup({
-- 	-- configure custom mappings
-- 	defaults = {
-- 		mappings = {
-- 			i = {
-- 				["<C-k>"] = actions.move_selection_previous, -- move to prev result
-- 				["<C-j>"] = actions.move_selection_next, -- move to next result
-- 				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
-- 			},
-- 		},
-- 		file_ignore_patterns = {
-- 			"node_modules",
-- 			-- ".git",
-- 		},
-- 	},
-- 	pickers = {
-- 		find_files = {
-- 			find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
-- 			-- hidden = true,
-- 		},
-- 	},
-- })
--
-- telescope.load_extension("fzf")
