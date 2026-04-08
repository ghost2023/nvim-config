return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			local fzf = require("fzf-lua")
			local utils = require("fzf-lua.utils")
			fzf.setup({
				fzf_opts = { ["--cycle"] = true },
				winopts = {
					width = 0.90,
					on_create = function(win)
						vim.keymap.set("t", "jk", "<ESC>", {
							buffer = win.bufnr,
						})
					end,
				},
				file_ignore_patterns = {
					"%.png",
					"%.webp",
					"%.jpg",
					"%.jpeg",
					"%.ttf",
					"%.otf",
					"%.otf",
					"%.svg",
					"%.zip",
					"yarn.lock",
					"pnpm-lock.yaml",
					"lazy-lock.json",
					"pubspec.lock",
					"package-lock.json",
					"tsconfig.tsbuildinfo",
				},
				grep = {},
				files = {
					prompt = " ",
					cwd_prompt = false,
				},
				commands = {
					sort_lastused = true,
					actions = {
						["enter"] = require("fzf-lua.actions").command,
					},
				},
				command_history = {
					sort_lastused = true,
					actions = {
						["enter"] = require("fzf-lua.actions").command,
					},
				},
			})
		end,
	},
}
