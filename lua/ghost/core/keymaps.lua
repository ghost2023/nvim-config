-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")
keymap.set("t", "jk", "<C-\\><C-n>")

keymap.set("i", "kj", "<ESC><cmd>silent w | echo 'saved'<CR>")
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>") -- see available code actions
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>") -- smart rename

keymap.set("n", "<leader>tn", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tj", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tk", ":tabp<CR>") --  go to previous tab

-- buffer keybinding
keymap.set("n", "<leader>k", ":bprevious<CR>") -- go to previous buffer
keymap.set("n", "<leader>j", ":bnext<CR>") -- go to next buffer
keymap.set("n", "<leader>bb", ":b#<CR>") -- go to previous buffer
keymap.set("n", "<leader>x", ":Bwipeout<CR>") -- close buffer

-- windows keybinding
keymap.set("n", "<leader>ww", "<C-w>w")

-- windows move
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")

keymap.set("t", "<C-j>", "<C-w>j", { noremap = true })
keymap.set("t", "<C-k>", "<C-w>k", { noremap = true })
keymap.set("t", "<C-h>", "<C-w>h")
keymap.set("t", "<C-l>", "<C-w>l")

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

-- git
keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>")
keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<cr>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fe", "<cmd>Telescope resume<cr>") -- resume telescope

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- force quit
keymap.set("n", "<C-q>", ":qa<CR>")
keymap.set("i", "<C-q>", "<cmd>qa<CR>")

-- save keymap.set("n", "<leader>s", "<cmd>silent w | echo 'saved'<CR>")
keymap.set("n", "<C-s>", "<ESC><cmd>silent w | echo 'saved'<CR>")
keymap.set("i", "<C-s>", "<ESC><cmd>silent w | echo 'saved'<CR>")

-- toggle terminal
keymap.set("n", "<f8>", ":ToggleTerm<CR>")
keymap.set("i", "<f8>", "<ESC><cmd>ToggleTerm<CR>")
keymap.set("t", "<f8>", "<cmd>ToggleTerm<CR>")

-- set keybinds
opts.desc = "Show LSP references"
keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

opts.desc = "Go to declaration"
keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

opts.desc = "Show LSP definitions"
keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- show lsp definitions

opts.desc = "Show LSP implementations"
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

opts.desc = "Show LSP type definitions"
keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

opts.desc = "See available code actions"
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

opts.desc = "Smart rename"
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

opts.desc = "Show buffer diagnostics"
keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

opts.desc = "Show line diagnostics"
keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

opts.desc = "Go to previous diagnostic"
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

opts.desc = "Go to next diagnostic"
keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

opts.desc = "Show documentation for what is under cursor"
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

opts.desc = "Toggle DBUI"
keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", opts) -- show documentation for what is under cursor

opts.desc = "Restart LSP"
keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

keymap.set("n", "<leader>oi", function()
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = { vim.fn.expand("%:p") },
	})
end, opts)

keymap.set("n", "zk", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		-- choose one of coc.nvim and nvim lsp
		vim.fn.CocActionAsync("definitionHover") -- coc.nvim
		vim.lsp.buf.hover()
	end
end)
