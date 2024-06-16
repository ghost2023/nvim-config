return {
	"akinsho/bufferline.nvim",
	version = "*",
	-- event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		vim.keymap.set("n", "<leader>bg", "<cmd>BufferLinePick<CR>") -- smart rename
		vim.keymap.set("n", "<leader>X", function()
			for _, e in ipairs(bufferline.get_elements().elements) do
				vim.schedule(function()
					vim.cmd("bd " .. e.id)
				end)
			end
		end)

		bufferline.setup({
			options = {
				-- offsets = {
				-- 	{
				-- 		filetype = "NvimTree",
				-- 		text = "Files",
				-- 		highlight = "Directory",
				-- 		text_align = "left",
				-- 		separator = true,
				-- 	},
				-- },
				separator_style = "slant",
				diagnostics = "nvim_lsp",
				indicator = {
					style = "underline",
				},

				diagnostics_update_in_insert = true,
				show_buffer_icons = false,
			},
		})
	end,
}
