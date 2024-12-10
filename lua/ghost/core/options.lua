local opt = vim.opt -- for conciseness

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.fillchars = { eob = " " }

-- line numbers
opt.relativenumber = true -- show relative line numbers

opt.backup = false
opt.backupcopy = "yes"
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- tabs & indentation
opt.tabstop = 2       -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

vim.opt.updatetime = 450

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- opt.iskeyword:append("-") -- consider string-string as whole word
vim.diagnostic.config({
  virtual_text = true,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- delay update diagnostics
  update_in_insert = true,
})

opt.whichwrap:append("<,>,[,],h,l")

opt.scrolloff = 8

opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor25",
  "a:blinkwait700-blinkoff400-blinkon250",
}

local function check_if_modified()
  local current_buf = vim.api.nvim_get_current_buf()
  local original_content = vim.fn.systemlist("cat " .. vim.fn.expand("%"))
  local current_content = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)

  if vim.deep_equal(original_content, current_content) then
    vim.api.nvim_set_option_value("modified", false, { buf = 0 })
  end
end

-- Run the check on every BufWritePost and TextChanged event
vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
  pattern = "*",
  callback = check_if_modified,
})
