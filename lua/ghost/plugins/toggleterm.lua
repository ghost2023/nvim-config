return {
	"akinsho/toggleterm.nvim",
	config = function()
		local setup, toggleterm = pcall(require, "toggleterm")
		if not setup then
			return
		end

		-- configure/enable toggleterm
		toggleterm.setup({
			direction = "float",
			float_opts = {
				direction = "curved",
				width = 115,
				height = 26,
			},
		})
	end,
}
