return {
	-- {
	-- 	"kevinhwang91/nvim-bqf", -- Better quickfix window,
	-- 	event = "VeryLazy",
	-- 	ft = "qf",
	-- },
	-- {
	-- 	"/ThePrimeagen/vim-be-good",
	-- 	event = "VeryLazy",
	-- },
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		event = "VeryLazy",
		"moll/vim-bbye",
		-- 	"famiu/bufdelete.nvim", -- Easily close buffers whilst preserving your window layouts
	},
	-- {
	-- 	"kassio/neoterm",
	-- 	event = "VeryLazy",
	-- },
	{
		"sindrets/diffview.nvim",
	},
	-- {
	-- 	"code-biscuits/nvim-biscuits",
	-- 	cond = not vim.g.vscode,
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("nvim-biscuits").setup({
	-- 			cursor_line_only = true,
	-- 			on_events = {
	-- 				"CursorHold",
	-- 				"CursorHoldI",
	-- 				"InsertLeave",
	-- 			},
	-- 			language_config = {
	-- 				vimdoc = {
	-- 					disabled = true,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"editorconfig/editorconfig-vim",
	},

	-- {
	-- 	"mrcjkb/rustaceanvim",
	-- 	ft = "rust",
	-- 	version = "^4", -- Recommended
	-- 	lazy = false, -- This plugin is already lazy
	-- 	setup = function()
	-- 		local bufnr = vim.api.nvim_get_current_buf()
	-- 		vim.keymap.set("n", "<leader>a", function()
	-- 			vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- 			-- or vim.lsp.buf.codeAction() if you don't want grouping.
	-- 		end, { silent = true, buffer = bufnr })
	-- 	end,
	-- },

	-- {
	--
	-- 	"famiu/bufdelete.nvim", -- Easily close buffers whilst preserving your window layouts
	-- 	cmd = "Bdelete",
	-- 	init = function()
	-- 		require("legendary").keymaps({
	-- 			{ "<C-c>", "<cmd>Bdelete<CR>", hide = true, description = "Close Buffer" }, -- bufdelete.nvim
	-- 			-- { "<Tab>", "<cmd>bnext<CR>", hide = true, description = "Next buffer", opts = { noremap = false } }, -- Heirline.nvim
	-- 			{
	-- 				-- "<S-Tab>",
	-- 				"<cmd>bprev<CR>",
	-- 				hide = true,
	-- 				description = "Previous buffer",
	-- 				opts = { noremap = false },
	-- 			}, -- Heirline.nvim
	-- 		})
	-- 	end,
	-- },
}
