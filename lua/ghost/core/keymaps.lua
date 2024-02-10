-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>") -- see available code actions
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>") -- smart rename

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- buffer keybinding
keymap.set("n", "<leader>bn", ":bnext<CR>") -- go to next buffer
keymap.set("n", "<leader>bp", ":bprevious<CR>") -- go to previous buffer
keymap.set("n", "<leader>bb", ":b#<CR>") -- go to previous buffer
keymap.set("n", "<leader>bx", ":bdelete<CR>") -- close buffer

-- windows keybinding
keymap.set("n", "<leader>ww", "<C-w>w")

-- windows move
keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")

-- window change
keymap.set("n", "<leader>wr", "<C-w>r")

-- window close
keymap.set("n", "<leader>wx", "<C-w>q")

-- window split
keymap.set("n", "<leader>wv", "<C-w>v")
keymap.set("n", "<leader>ws", "<C-w>s")

-- window maximization
keymap.set("n", "<leader>wmh", "<C-w>_")
keymap.set("n", "<leader>wmw", "<C-w>|")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- force quit
keymap.set("n", "<C-q>", ":qa<CR>")
keymap.set("i", "<C-q>", "<cmd>qa<CR>")

-- save
-- keymap.set("i", "/ss", "<ESC><cmd>w<CR>")
keymap.set("n", "<leader>ss", "<cmd>w<CR>")
keymap.set("v", "<leader>ss", "<cmd>w<CR>")
keymap.set("n", "<C-s>", "<ESC><cmd>w<CR>")
keymap.set("v", "<C-s>", "<ESC><cmd>w<CR>")
keymap.set("i", "<C-s>", "<ESC><cmd>w<CR>")

-- toggle terminal
keymap.set("n", "<f8>", ":ToggleTerm<CR>")
keymap.set("i", "<f8>", "<ESC><cmd>ToggleTerm<CR>")
keymap.set("t", "<f8>", "<cmd>ToggleTerm<CR>")

-- control backspace
-- keymap.set("i", "<C-BS>", "<C-w>", { noremap = false, silent = true })

-- vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })

-- Enable Ctrl + Backspace to delete a word in insert mode
-- vim.api.nvim_set_keymap('i', '<C-W>', '<C-w>', { noremap = true, silent = true })

-- -- git
-- keymap.set("n", "gd", "<cmd>DiffviewOpen<CR>")
-- keymap.set("n", "gv", "<cmd>Git<CR>")
-- keymap.set("n", "gp", "<cmd>:Git push<CR>")

-- trouble
keymap.set("n", "<f7>", "<cmd>TroubleToggle<CR>")
keymap.set("i", "<f7>", "<cmd>TroubleToggle<CR>")

keymap.set("i", "jk", "<ESC>")
-- keymap.set("v", "jk", "<ESC>")
