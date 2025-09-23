return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      local autotag = require("nvim-ts-autotag")

      autotag.setup({
        opts = {
          enable_close_on_slash = true,
        },
      })

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        -- autotag = {
        --   enable = true,
        -- },
        -- ensure these language parsers are installed
        auto_install = true,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}

-- -- import nvim-treesitter plugin safely
-- local status, treesitter = pcall(require, "nvim-treesitter.configs")
-- if not status then
--   return
-- end
--
-- -- configure treesitter
-- treesitter.setup({
--   -- enable syntax highlighting
--   highlight = {
--     enable = true,
--   },
--   -- enable indentation
--   indent = { enable = true },
--   -- enable autotagging (w/ nvim-ts-autotag plugin)
--   autotag = { enable = true },
--   -- ensure these language parsers are installed
--   ensure_installed = {
--     "json",
--     "javascript",
--     "typescript",
--     "tsx",
--     "yaml",
--     "html",
--     "css",
--     "markdown",
--     "markdown_inline",
--     "svelte",
--     "graphql",
--     "bash",
--     "lua",
--     "vim",
--     "dockerfile",
--     "gitignore",
--   },
--   -- auto install above language parsers
--   auto_install = true,
-- })
