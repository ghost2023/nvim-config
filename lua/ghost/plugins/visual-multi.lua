return {
	"mg979/vim-visual-multi",
	branch = "master",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "visual_multi_start",
			callback = function()
				pcall(vim.keymap.del, "i", "<BS>", { buffer = 0 })
			end,
		})
	end,
}
