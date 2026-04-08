return {
	{
		"nvim-lualine/lualine.nvim",
		event = "UIEnter",
		dependencies = {
			"nvim-lua/lsp-status.nvim",
		},
		config = function()
			local lualine = require("lualine")

			local colors = {
				blue = "#65D1FF",
				green = "#3EFFDC",
				violet = "#C792EA",
				yellow = "#FFDA7B",
				red = "#FF4A4A",
				fg = "#c3ccdc",
				bg = "transparent",
				inactive_bg = "#2c3043",
			}

			local my_lualine_theme = {
				normal = {
					a = { bg = colors.blue, fg = "black", gui = "bold" },
					b = { fg = colors.fg },
					c = { fg = colors.fg },
				},
				insert = {
					a = { bg = colors.yellow, fg = "black", gui = "bold" },
					b = { fg = colors.fg },
					c = { fg = colors.fg },
				},
				visual = {
					a = { bg = colors.violet, fg = "black", gui = "bold" },
					b = { fg = colors.fg },
					c = { fg = colors.fg },
				},
				command = {
					a = { bg = colors.yellow, fg = "black", gui = "bold" },
					b = { fg = colors.fg },
					c = { fg = colors.fg },
				},
				replace = {
					a = { bg = colors.red, fg = "black", gui = "bold" },
					b = { fg = colors.fg },
					c = { bg = colors.bg, fg = colors.fg },
				},
				inactive = {
					a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
					b = { bg = colors.inactive_bg, fg = colors.semilightgray },
					c = { bg = colors.inactive_bg, fg = colors.semilightgray },
				},
			}

			-- configure lualine with modified theme
			lualine.setup({
				options = {
					theme = my_lualine_theme,
					disabled_filetypes = {
						"NvimTree",
						"alpha",
						"avante",
					},
				},
				sections = {
					lualine_a = {
						"mode",
					},

					lualine_b = {
						{
							function()
								local reg = vim.fn.reg_recording()
								-- If a macro is being recorded, show "Recording @<register>"
								if reg ~= "" then
									return "Rec @" .. reg
								else
									return ""
								end
							end,
							color = { bg = colors.violet, fg = "black", gui = "bold" },
							separator = { right = "" },
						},
						{
							"filename",
							file_status = true,
							path = 1,
							hide_filename_extension = true,
						},
					},
					lualine_c = {
						"diagnostics",
					},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {
						"tabs",
					},
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {
						{
							"filename",
							file_status = true,
							path = 1,
							hide_filename_extension = true,
						},
					},

					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
