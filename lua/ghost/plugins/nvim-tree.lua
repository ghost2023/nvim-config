return {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	priority = 1000,
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- configure nvim-tree
		nvimtree.setup({
			view = {
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						height = vim.api.nvim_list_uis()[1].height - 4,
						width = 45,
						col = vim.api.nvim_list_uis()[1].width - 45,
					},
				},
				-- side = "right",
				-- width = 45,
			},
			-- change folder arrow icons
			renderer = {
				root_folder_label = ":~:s?$?",
				indent_markers = {
					enable = true,
				},
				icons = {
					git_placement = "signcolumn",
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store", "node_modules" },
				dotfiles = true,
				-- git_ignored = true
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<M-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<M-S-e>", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file

		local function open_nvim_tree(data)
			-- buffer is a [No Name]
			local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

			-- buffer is a directory
			local directory = vim.fn.isdirectory(data.file) == 1
			--
			if not no_name and not directory then
				return
			end
			--
			-- change to the directory
			if directory then
				vim.cmd.cd(data.file)
			end
			require("nvim-tree.api").tree.open()
		end

		vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	end,
}
