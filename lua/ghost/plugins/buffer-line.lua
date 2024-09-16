return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require("bufferline")
    vim.keymap.set("n", "<leader>X", function()
      for _, e in ipairs(bufferline.get_elements().elements) do
        vim.schedule(function()
          vim.cmd("bd " .. e.id)
        end)
      end
    end)

    bufferline.setup({
      options = {
        separator_style = "thick",
        diagnostics = false,
        diagnostics_update_in_insert = false,
        always_show_bufferline = false,
        show_buffer_icons = false,
      },
    })
  end,
}
