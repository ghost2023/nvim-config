return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				layout_config = {
					height = 0.95,
					width = 0.95,
					preview_cutoff = 90,
					horizontal = {
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
				},
				path_display = { "trunicate" },
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
					".git",
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden" },
					hidden = true,
				},
				mappings = {
					i = {
						["<c-x>"] = actions.delete_buffer + actions.move_to_top,
					},
				},
			},
		})

		telescope.load_extension("live_grep_args")
		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope registers<cr>", { desc = "registers" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles only_cwd=true<cr>", { desc = "Fuzzy find recent files" })
		keymap.set(
			"n",
			"<leader>fs",
			"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			{ desc = "Find string in cwd" }
		)
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = " string under cursor in cwd" })
	end,
}
