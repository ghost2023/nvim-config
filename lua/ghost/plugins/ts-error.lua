return {
	"OlegGulevskyy/better-ts-errors.nvim",
    event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = {
		keymaps = {
			toggle = "<leader>dt", -- default '<leader>dd'
			go_to_definition = "<leader>dx", -- default '<leader>dx'
		},
	},
}
