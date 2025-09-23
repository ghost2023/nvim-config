-- to view large command texts within neovim
vim.api.nvim_create_user_command("Pager", function(args)
	vim.cmd("vnew")

	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_win_set_buf(0, buf)
	vim.bo[buf].bt = "nofile"
	vim.bo[buf].ft = "man"
	vim.bo[buf].swapfile = false
	local content = vim.fn.systemlist(args.args)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.keymap.set("n", "q", "<cmd>bdelete<CR>", { buffer = buf })
	vim.bo[buf].modifiable = false
end, { nargs = "*" })

-- a way to quickly write a discardable notes in a new tab using the markdown
vim.api.nvim_create_user_command("Scribe", function(args)
	vim.cmd("tabnew")

	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_win_set_buf(0, buf)
	vim.bo[buf].bt = "nofile"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "markdown"

	local content = vim.fn.systemlist(args.args)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
end, { nargs = "*" })

-- a way to use node repl within neovim
vim.api.nvim_create_user_command("Node", function(args)
	vim.cmd("tabnew")

	local editor_buf = vim.api.nvim_get_current_buf()
	local editor_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(0, editor_buf)

	vim.bo[editor_buf].swapfile = false
	vim.bo[editor_buf].filetype = "javascript"
	vim.bo[editor_buf].bt = "nofile"
	vim.bo[editor_buf].bl = false
	vim.api.nvim_buf_set_name(editor_buf, "node")

	vim.cmd("vnew")
	local output_buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_win_set_buf(0, output_buf)

	vim.bo[output_buf].swapfile = false
	vim.bo[output_buf].filetype = "text"
	vim.bo[output_buf].bt = "nofile"
	vim.bo[output_buf].bl = false

	vim.api.nvim_set_current_win(editor_win)

	vim.keymap.set({ "n", "i" }, "<C-s>", function()
		vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, {})
		local code = vim.api.nvim_buf_get_lines(editor_buf, 0, -1, false)

		local job_id = vim.fn.jobstart({ "node" }, {
			stdout_buffered = true,
			on_stdout = function(_, data)
				if data and #data > 0 then
					-- Remove empty trailing lines
					while #data > 0 and data[#data] == "" do
						table.remove(data, #data)
					end
					vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, data)
				end
			end,
			on_stderr = function(_, data)
				if data and #data > 0 then
					-- Remove empty trailing lines
					while #data > 0 and data[#data] == "" do
						table.remove(data, #data)
					end
					vim.print(data)
					vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, data)
				end
			end,
			on_exit = function() end,
		})

		vim.fn.chansend(job_id, table.concat(code, "\n") .. "\n")
		vim.fn.chanclose(job_id, "stdin")
	end, { buffer = editor_buf })
end, { nargs = "*" })
