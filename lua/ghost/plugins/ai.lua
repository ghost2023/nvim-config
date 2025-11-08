return {
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-c>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-b>",
				},
				condition = function()
					return false
				end,
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
			init = function()
				vim.g.copilot_nes_debounce = 500
			end,
		},
		cmd = "Copilot",
		event = "InsertEnter",
    enabled = false,
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = false,
				},
				nes = {
					enabled = true,
					keymap = {
						accept_and_goto = "<C-c>",
						accept = false,
						dismiss = "<Esc>",
					},
				},
			})
		end,
	},
	-- {
	--   "zbirenbaum/copilot.lua",
	--   cmd = "Copilot",
	--   event = "InsertEnter",
	--   config = function()
	--     require("copilot").setup({
	--       suggestion = {
	--         enabled = true,
	--         auto_trigger = true,
	--         hide_during_completion = true,
	--         debounce = 75,
	--         keymap = {
	--           accept = "<C-c>",
	--           accept_word = "<C-b>",
	--           accept_line = "<C-v>",
	--           next = "<M-]>",
	--           prev = "<M-[>",
	--           dismiss = "<C-]>",
	--         },
	--       },
	--       copilot_model = "gemini-2.0-flash", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
	--       root_dir = function()
	--         return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
	--       end,
	--     })
	--   end,
	-- },
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({
	-- 			-- Optionally disable cmp source if using virtual text only
	-- 			enable_cmp_source = false,
	-- 			virtual_text = {
	-- 				enabled = true,
	--
	-- 				-- These are the defaults
	--
	-- 				-- Set to true if you never want completions to be shown automatically.
	-- 				manual = false,
	-- 				-- A mapping of filetype to true or false, to enable virtual text.
	-- 				filetypes = {},
	-- 				-- Whether to enable virtual text of not for filetypes not specifically listed above.
	-- 				default_filetype_enabled = true,
	-- 				-- How long to wait (in ms) before requesting completions after typing stops.
	-- 				idle_delay = 75,
	-- 				-- Priority of the virtual text. This usually ensures that the completions appear on top of
	-- 				-- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
	-- 				-- desired.
	-- 				virtual_text_priority = 65535,
	-- 				-- Set to false to disable all key bindings for managing completions.
	-- 				map_keys = true,
	-- 				-- The key to press when hitting the accept keybinding but no completion is showing.
	-- 				-- Defaults to \t normally or <c-n> when a popup is showing.
	-- 				accept_fallback = nil,
	-- 				-- Key bindings for managing completions in virtual text mode.
	-- 				key_bindings = {
	-- 					-- Accept the current completion.
	-- 					accept = "<C-c>",
	-- 					-- Accept the next word.
	-- 					accept_word = "<C-]>",
	-- 					-- Accept the next line.
	-- 					accept_line = false,
	-- 					-- Clear the virtual text.
	-- 					clear = false,
	-- 					-- Cycle to the next completion.
	-- 					next = "<M-]>",
	-- 					-- Cycle to the previous completion.
	-- 					prev = "<M-[>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- "Exafunction/codeium.vim",
	-- config = function()
	-- 	vim.keymap.set("i", "<C-i>", function()
	-- 		return vim.fn["codeium#Accept"]()
	-- 	end, { expr = true })
	-- end,
}
