return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			local fzf = require("fzf-lua")
			local utils = require("fzf-lua.utils")
			fzf.setup({
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
			local function custom_commands_picker()
				local entries = {}
				local seen = {}

				-- Formatting helpers
				-- We use a non-breaking space or a specific delimiter to separate metadata
				local history_icon = utils.ansi_codes.yellow("⌛ ")
				local cmd_icon = utils.ansi_codes.magenta(">  ")

				-- 1. Get History (Newest first)
				local history_string = vim.fn.execute("history cmd")
				local history_list = vim.split(history_string, "\n")

				for i = #history_list, 1, -1 do
					-- Parse: "  123  write" -> "write"
					local cmd = history_list[i]:match("^%s*>?%s*%d+%s+(.+)$")
					if cmd and not seen[cmd] then
						table.insert(entries, history_icon .. cmd)
						seen[cmd] = true
					end
				end

				-- 2. Get All Commands
				local all_commands = vim.fn.getcompletion("", "command")
				for _, cmd in ipairs(all_commands) do
					if not seen[cmd] then
						table.insert(entries, cmd_icon .. cmd)
						seen[cmd] = true
					end
				end

				-- 3. Run Fzf
				fzf.fzf_exec(entries, {
					prompt = "Cmds> ",
					fzf_opts = {
						-- Prefer the order of the input (History first) when scores are equal
						["--tiebreak"] = "index",
						-- Enable ANSI color codes
						["--ansi"] = "",
						-- "2.." means: Ignore the 1st "word" (the icon) when searching
						-- Search starts from the command name itself
						["--nth"] = "2..",
					},
					actions = {
						["default"] = function(selected)
							-- Strip the icon/color before executing
							-- Match: anything up to the first space, then capture the rest
							local cmd = selected[1]:match("^.*?%s(.*)$")
							if cmd then
								vim.cmd(cmd)
							end
						end,
						["ctrl-e"] = function(selected)
							local cmd = selected[1]:match("^.*?%s(.*)$")
							if cmd then
								vim.api.nvim_feedkeys(":" .. cmd, "n", true)
							end
						end,
					},
				})
			end
			vim.keymap.set({ "n", "i" }, "<leader><leader>", custom_commands_picker, { desc = "Open commands history " })
		end,
	},
}
