return {
	{
		"kevinhwang91/nvim-bqf", -- Better quickfix window,
		ft = "qf",
	},
	{
		"moll/vim-bbye",
		-- 	"famiu/bufdelete.nvim", -- Easily close buffers whilst preserving your window layouts
	},
	{
		"nicwest/vim-http",
	},
	{
		"kassio/neoterm",
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
