local opt = vim.opt -- for conciseness

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.opt.fillchars = { eob = " " }
vim.opt.laststatus = 3
-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.smoothscroll = true -- smooth scrolling

opt.backup = false
opt.backupcopy = "yes"
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.modeline = false -- don't show modelines

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

vim.opt.updatetime = 450

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- On a headless box (remote VPS: no Wayland/X, so no wl-copy/xclip) there is
-- nothing for "unnamedplus" to talk to and yanks silently go nowhere. Route the
-- + register through OSC 52 so the *terminal* does the copying — herdr forwards
-- OSC 52 from a pane to the local client's clipboard.
-- Neovim only auto-enables this when $SSH_TTY is set, which herdr panes don't inherit.
if vim.env.WAYLAND_DISPLAY == nil and vim.env.DISPLAY == nil then
	local osc52 = require("vim.ui.clipboard.osc52")
	-- Most terminals refuse OSC 52 *reads*, so paste from the last yank rather
	-- than querying the terminal (which would stall and return nothing).
	local function paste()
		return vim.split(vim.fn.getreg("") or "", "\n")
	end
	vim.g.clipboard = {
		name = "OSC 52",
		copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("+") },
		paste = { ["+"] = paste, ["*"] = paste },
	}
end

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- opt.iskeyword:append("-") -- consider string-string as whole word
vim.diagnostic.config({
	virtual_text = true,
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

vim.bo.formatprg = "jq"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	command = "wincmd L", -- move the help/man window to the far right
})

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"
