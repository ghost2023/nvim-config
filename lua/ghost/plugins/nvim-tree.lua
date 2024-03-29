return {
	-- "nvim-neo-tree/neo-tree.nvim",
	-- branch = "v3.x",
	-- dependencies = {
	-- 	"nvim-lua/plenary.nvim",
	-- 	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 	"MunifTanjim/nui.nvim",
	-- 	-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	-- },
	--
	-- config = function()
	-- 	-- require("")
	-- 	require("neo-tree").setup({
	-- 		source_selector = {
	-- 			winbar = true,
	-- 		},
	--
	-- 		filesystem = {
	-- 			filtered_items = {
	-- 				hide_dotfiles = false,
	-- 				hide_gitignored = false,
	-- 				hide_hidden = false,
	-- 				hide_by_name = {
	-- 					".DS_Store",
	-- 					"thumbs.db",
	-- 					"node_modules",
	-- 				},
	-- 			},
	-- 		},
	-- 	})
	-- 	vim.keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
	-- end,
	--
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	priority = 1000,
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

		-- configure nvim-tree
		nvimtree.setup({
			view = {
				-- width = 32,
				relativenumber = false,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
							-- arrow_closed = "", -- arrow when folder is closed
							-- arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store", "node_modules" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

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

-- -- import nvim-tree plugin safely
-- local setup, nvimtree = pcall(require, "nvim-tree")
-- if not setup then
-- return
-- end
--
-- -- recommended settings from nvim-tree documentation
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
--
-- -- change color for arrows in tree to light blue
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
--
-- -- configure nvim-tree
-- nvimtree.setup({
-- 	-- change folder arrow icons
-- 	-- renderer = {
-- 	-- 	icons = {
-- 	-- 		glyphs = {
-- 	-- 			folder = {
-- 	-- 				arrow_closed = " ", -- arrow when folder is closed
-- 	-- 				arrow_open = " ", -- arrow when folder is open
-- 	-- 			},
-- 	-- 		},
-- 	-- 	},
-- 	-- },
-- 	-- disable window_picker for
-- 	-- explorer to work well with
-- 	-- window splits
-- 	actions = {
-- 		open_file = {
-- 			window_picker = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- 	filters = {
-- 		git_ignored = false,
-- 	},
-- 	diagnostics = {
-- 		enable = false,
-- 		show_on_dirs = false,
-- 	},
-- })
--
-- -- open nvim-tree on setup
--
-- local function open_nvim_tree(data)
-- 	-- buffer is a [No Name]
-- 	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--
-- 	-- buffer is a directory
-- 	local directory = vim.fn.isdirectory(data.file) == 1
--
-- 	if not no_name and not directory then
-- 		return
-- 	end
--
-- 	-- change to the directory
-- 	if directory then
-- 		vim.cmd.cd(data.file)
-- 	end
--
-- 	-- open the tree
-- 	require("nvim-tree.api").tree.open()
-- end
--
