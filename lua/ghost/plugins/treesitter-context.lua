return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup({
			max_lines = 1,
			multiline_threshold = 1,
		})
	end,
}
