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
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		telescope.setup({

			defaults = {
				path_display = { "tuncate" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["jk"] = actions.close,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					-- ".git",
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
					-- hidden = true,
				},
				mappings = {
					i = {
						["<c-x>"] = actions.delete_buffer + actions.move_to_top,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		local telescope_last = 0
		function telescope_resume()
			if telescope_last == 0 then
				telescope_last = 1
				builtin.live_grep()
			else
				builtin.resume()
			end
		end

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope registers<cr>", { desc = "registers" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", telescope_resume, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = " string under cursor in cwd" })
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
