return {
	"akinsho/flutter-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
}

-- local setup, flutter_tools = pcall(require, "flutter-tools")
-- if not setup then
-- 	return
-- end
--
-- flutter_tools.setup({})
