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
        diagnostics = "nvim_lsp",
        diagnostics_update_on_event = true,
        always_show_bufferline = false,
        text_align = "left",
        persist_buffer_sort = false,

        show_buffer_close_icons = false,
        sort_by = 'insert_at_end'
      },
    })
  end,
}
