return {
	{
		"echasnovski/mini.pairs",
		version = "*",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
	},
	{
		"moll/vim-bbye",
		cmd = { "Bwipeout", "Bdelete" },
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
	},

	{
		"kndndrj/nvim-dbee",
		event = "VeryLazy",
		cmd = "Dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup({
				drawer = {
					window_options = {
						winheight = 18,
					},
				},
				editor = {
					window_options = {
						winheight = 18,
					},
				},
			})

			vim.api.nvim_create_user_command("Dbee", function()
				require("dbee").toggle()
			end, { force = true })
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			--
			vim.g.db_ui_tmp_query_location = "~/queries"
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = "ToggleTerm",
		-- opts = {
		-- },
		config = function()
			require("toggleterm").setup({
				float_opts = {

					width = vim.o.columns - 2,
					height = vim.o.lines - 3,
				},
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		opts = {
			easing = "quadratic",
			duration_multiplier = 0.8,
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "http")
			end,
		},
		config = function()
			vim.bo.formatexpr = ""
			vim.bo.formatprg = "jq"
			vim.g.rest_nvim = {
				_log_level = vim.log.levels.DEBUG,
				request = {
					hooks = {
						encode_url = false,
					},
				},
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "vnd.api+json",
				callback = function(ev)
					vim.bo[ev.buf].filetype = "json"
				end,
			})
		end,
	},
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			processor = "magick_cli",
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1
		end,
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"marilari88/neotest-vitest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vitest"),
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({
				dev_log = {
					enabled = true,
					filter = nil, -- optional callback to filter the log
					-- takes a log_line as string argument; returns a boolean or nil;
					-- the log_line is only added to the output if the function returns true
					notify_errors = false, -- if there is an error whilst running then notify the user
					open_cmd = "vsplit", -- command to use to open the log buffer
					focus_on_open = true, -- focus on the newly opened log window
				},
			})

			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	filetype = "log", -- filetype
			-- 	callback = function()
			-- 		vim.keymap.set("n", "q", "<cmd>FlutterLogToggle<CR>", {
			-- 			buffer = true,
			-- 			silent = true,
			-- 		})
			-- 	end,
			-- })
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	filetype = "log", -- filetype
			-- 	callback = function()
			-- 		vim.keymap.set("n", "c", "<cmd>FlutterLogClear<CR>", {
			-- 			buffer = true,
			-- 			silent = true,
			-- 		})
			-- 	end,
			-- })
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}
