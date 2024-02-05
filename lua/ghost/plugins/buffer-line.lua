return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		vim.keymap.set("n", "<leader>bg", "<cmd>BufferLinePick<CR>") -- smart rename
		vim.keymap.set("n", "<leader>bX", function()
			for _, e in ipairs(bufferline.get_elements().elements) do
				vim.schedule(function()
					vim.cmd("bd " .. e.id)
				end)
			end
		end)

		bufferline.setup({
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "Files",
						highlight = "Directory",
						text_align = "left",
						separator = true,
					},
				},
				always_show_bufferline = false,
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
	-- "romgrk/barbar.nvim",
	-- config = function()
	-- 	require("barbar").setup({
	-- 		sidebar_filetypes = {
	-- 			["nvim-tree"] = true,
	-- 		},
	-- 	})
	-- end,
}
