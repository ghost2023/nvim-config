return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
	end,
}

-- -- import gitsigns plugin safely
-- local setup, gitsigns = pcall(require, "gitsigns")
-- if not setup then
--   return
-- end
--
-- -- configure/enable gitsigns
-- gitsigns.setup()
