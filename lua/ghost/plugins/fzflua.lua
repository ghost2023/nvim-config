return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			local fzf = require("fzf-lua")
			fzf.setup({
				winopts = {

        preview = {
          layout         = "vertical",          -- horizontal|vertical|flex
          },
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
					"package-lock.json",
					"tsconfig.tsbuildinfo",
				},
        grep = {
           
        },
				files = {
					prompt = " ",
					cwd_prompt = false,
				},
			})
			-- fzf.files({ cwd_prompt = false, prompt = ' ' })
		end,
	},
}
