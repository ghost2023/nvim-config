-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- vim.api.nvim_set_keymap("t", "jk", "<ESC>", {'nowait'})

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>tn", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader><Tab>", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader><S-Tab>", ":tabp<CR>") --  go to previous tab

-- buffer keybinding
keymap.set("n", "H", ":bprevious<CR>") -- go to previous buffer
keymap.set("n", "L", ":bnext<CR>") -- go to next buffer
keymap.set("n", "<leader>b", ":b#<CR>") -- go to previous buffer
keymap.set("n", "<leader>x", ":Bwipeout<CR>") -- close buffer

-- windows keybinding
keymap.set("n", "<leader>ww", "<C-w>w")

-- window change
keymap.set("n", "<leader>wr", "<C-w>r")

-- window close
keymap.set("n", "<leader>wx", "<C-w>q")

-- window split
keymap.set("n", "<leader>wv", "<C-w>v")
keymap.set("n", "<leader>ws", "<C-w>s")

----------------------
-- Plugin Keybinds
----------------------

-- undotree
keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

-- telescope
keymap.set("n", "<leader>F", "<cmd>FzfLua<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<cr>") -- find string under cursor in current working directory
keymap.set("n", "<M-f>", "<cmd>FzfLua buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fe", "<cmd>FzfLua resume<cr>") -- resume telescope
keymap.set("n", "<leader>fa", function()
	require("ghost.repo-picker").git_status()
end, { desc = "Git status (pick repo if cwd isn't one)" })
keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<CR>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fq", "<cmd>FzfLua quickfix<CR>", { desc = "Open quickfix" })
keymap.set("n", "<leader>fp", "<cmd>FzfLua commands<CR>", { desc = "Open command palette" })

-- visual selection search with fzf-lua
keymap.set("v", "<leader>fs", function()
	local start = vim.api.nvim_buf_get_mark(0, "<")
	local stop = vim.api.nvim_buf_get_mark(0, ">")
	local lines = vim.api.nvim_buf_get_lines(0, start[1] - 1, stop[1], false)
	if #lines == 0 then
		return
	end
	lines[#lines] = string.sub(lines[#lines], 1, stop[2])
	lines[1] = string.sub(lines[1], start[2] + 1)
	require("fzf-lua").live_grep({ search = table.concat(lines, "\n") })
end, { desc = "Grep for selected text" })

-- visual */# to search selection (built-in, no fzf)
keymap.set("v", "*", [["/y/<C-r>"<CR>]])
keymap.set("v", "#", [["?y/<C-r>"<CR>]])

-- lsp symbols
keymap.set("n", "<leader>ss", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Show LSP symbols" })
keymap.set("n", "<leader>sd", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Show document LSP symbols" })
keymap.set({ "i", "n" }, "<C-t>", "<cmd>Lspsaga finder<CR>", { desc = "Finder" })

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>ls", ":LspRestart<CR>", {
	desc = "restart lsp",
})
keymap.set("n", "<leader>ld", ":Lspsaga peek_definition<CR>", {
	desc = "Lsp peek_definition",
})
keymap.set("n", "<leader>lt", ":Lspsaga peek_type_definition<CR>", {
	desc = "Lsp peek_type_definition",
})
keymap.set("n", "<leader>lf", function()
	local ft = vim.bo.ft
	if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
	-- vim.cmd("TSToolsOrganizeImports")
	else
		vim.lsp.buf.format()
	end
	vim.cmd("silent! write")
end) -- mapping to restart lsp if necessary

--setxkbmap -option caps:swapescape quit
keymap.set("n", "<C-q>", function()
	vim.api.nvim_command("qa")
end, { silent = true })
keymap.set("i", "<C-q>", function()
	vim.api.nvim_command("qa")
end, { silent = true })

keymap.set("n", "<C-s>", "<ESC><cmd>silent w | echo 'saved'<CR>")
keymap.set("i", "<C-s>", "<ESC><cmd>silent w | echo 'saved'<CR>")

opts.desc = "Show LSP references"
keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts) -- show definition, references

opts.desc = "Go to declaration"
keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

opts.desc = "Show LSP definitions"
keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- show lsp definitions

opts.desc = "Show LSP implementations"
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

opts.desc = "Show LSP type definitions"
keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- show lsp type definitions

opts.desc = "See available code actions"
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions

opts.desc = "Smart rename"
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

opts.desc = "Show cursor diagnostics"
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

opts.desc = "Go to previous diagnostic"
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

opts.desc = "Go to next diagnostic"
keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

opts.desc = "Toggle DBUI"
keymap.set("n", "<leader>p", "<cmd>Dbee<CR>", opts) -- show documentation for what is under cursor

opts.desc = "Hover Doc"
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
opts.desc = "Restart LSP"
keymap.set("n", "<leader>ls", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

-- file tree
keymap.set("n", "<M-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<M-S-e>", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file

opts.desc = "Organize Imports"
keymap.set("n", "<leader>oi", function()
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = { vim.fn.expand("%:p") },
	})
end, opts)

keymap.set("n", "<f3>", "<cmd>MaximizerToggle<CR>", opts)
keymap.set("n", "<f9>", "<cmd>ToggleTerm direction=float<CR>", opts)
keymap.set("t", "<f9>", "<cmd>ToggleTerm direction=float<CR>", opts)

vim.api.nvim_set_keymap("i", "<C-d>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-d>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("i", "<C-f>", "<Plug>luasnip-prev-choice", {})
vim.api.nvim_set_keymap("s", "<C-f>", "<Plug>luasnip-prev-choice", {})

opts.desc = "Show Lspsaga outline"
vim.api.nvim_set_keymap("n", "<leader>ol", "<cmd>Lspsaga outline<CR>", {})
