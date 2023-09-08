local setup, toggleterm = pcall(require, "toggleterm")
if not setup then
  return
end

-- configure/enable toggleterm
toggleterm.setup({
  direction = "float"
})