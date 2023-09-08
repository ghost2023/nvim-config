-- import bufferline plugin safely
local setup, bufferline = pcall(require, "bufferline")
if not setup then
  return
end

-- configure/enable bufferline
bufferline.setup({
  options = {
    offsets = {{ filetype = "NvimTree", text = '', padding = 1 }}
  }
})