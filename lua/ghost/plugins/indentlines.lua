vim.opt.list = true

local setup, indentlines = pcall(require, "indent_blankline")
if not setup then
  return
end


indentlines.setup {
    show_end_of_line = true,
}