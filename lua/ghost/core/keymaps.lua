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

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>tn", ":tabnew<CR>")    -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>")  -- close current tab
keymap.set("n", "<leader><Tab>", ":tabn<CR>")   --  go to next tab
keymap.set("n", "<leader><S-Tab>", ":tabp<CR>") --  go to previous tab

-- buffer keybinding
keymap.set("n", "H", ":bprevious<CR>")        -- go to previous buffer
keymap.set("n", "L", ":bnext<CR>")            -- go to next buffer
keymap.set("n", "<leader>b", ":b#<CR>")       -- go to previous buffer
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

-- telescope
keymap.set("n", "<leader>F", "<cmd>Telescope<cr>")              -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope fd<cr>")          -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")     -- list open buffers in current neovim instance
keymap.set("n", "<leader>fe", "<cmd>Telescope resume<cr>")      -- resume telescope
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Search Marks" })
keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { desc = "Open quickfix" })
keymap.set("n", "<leader>fp", "<cmd>Telescope commands<CR>", { desc = "Open command palette" })
keymap.set("n", "<leader>fh", "<cmd>Telescope command_history<CR>", { desc = "Open history of commands" })
keymap.set("n", "<leader>fy", "<cmd>Telescope search_history<CR>", { desc = "Open history of commands" })
keymap.set("n", "<leader>fg", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "fuzzy find in current file" })
keymap.set("n", "<leader>ft", function()
  require("trouble.sources.telescope").open()
end, { desc = "Open trouble list" })
keymap.set("n", "<leader>fo", function()
  require("telescope.builtin").live_grep({ grep_open_files = true })
end, { desc = "Find string in open files" })

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

--setxkbmap -option caps:swapescape quit
keymap.set("n", "<C-q>", function()
  vim.api.nvim_command("SessionSave")
  vim.api.nvim_command("qa")
end, { silent = true })
keymap.set("i", "<C-q>", function()
  vim.api.nvim_command("SessionSave")
  vim.api.nvim_command("qa")
end, { silent = true })

keymap.set("n", "<C-s>", "<ESC><cmd>silent w | echo 'saved'<CR>")
keymap.set("i", "<C-s>", "<ESC><cmd>silent w | echo 'saved'<CR>")

opts.desc = "Show LSP references"
keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

opts.desc = "Go to declaration"
keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

opts.desc = "Show LSP definitions"
keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

opts.desc = "Show LSP implementations"
keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

opts.desc = "Show LSP type definitions"
keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- show lsp type definitions

opts.desc = "See available code actions"
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions

opts.desc = "Smart rename"
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

opts.desc = "Show buffer diagnostics"
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

opts.desc = "Show line diagnostics"
keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

opts.desc = "Go to previous diagnostic"
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

opts.desc = "Go to next diagnostic"
keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

opts.desc = "Toggle DBUI"
keymap.set("n", "<leader>p", "<cmd>Dbee<CR>", opts) -- show documentation for what is under cursor

opts.desc = "Restart LSP"
keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

opts.desc = "Organize Imports"
keymap.set("n", "<leader>oi", function()
  vim.lsp.buf.execute_command({
    command = "_typescript.organizeImports",
    arguments = { vim.fn.expand("%:p") },
  })
end, opts)

keymap.set("n", "<f3>", "<cmd>MaximizerToggle<CR>", opts)
