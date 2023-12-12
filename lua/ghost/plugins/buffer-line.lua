return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				offsets = { { filetype = "NvimTree", text = "Files", highlight = "Directory", text_align = "left" } },
				separator_style = "slant",
				diagnostics = "nvim_lsp",
				indicator = {
					style = "underline",
				},

				diagnostics_update_in_insert = true,
				show_buffer_icons = false,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
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
