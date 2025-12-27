return {

  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      "mikavilpas/blink-ripgrep.nvim",
      "onsails/lspkind.nvim", -- vs-code like pictograms
      "rafamadriz/friendly-snippets",


{ 'MattiasMTS/cmp-dbee', opts = {} },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",

        config = function()
          require("ghost.core.snippets")
        end,
      },
    },

    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function()
        if vim.bo.filetype == "DressingInput" then
          return false
        end
        if vim.bo.filetype == "prompt" then
          return false
        end
        return not vim.tbl_contains({
          "NvimTree",
          "Telescope",
          "TelescopePrompt",
        }, vim.bo.filetype) and vim.b.completion ~= false
      end,

      cmdline = {
        completion = {
          list = { selection = { preselect = false, auto_insert = true } },
          ghost_text = { enabled = true },
          menu = { auto_show = true },
        },
      },
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-u>"] = {
          function(cmp)
            cmp.scroll_documentation_up(4)
          end,
          "fallback",
        },
        ["<C-d>"] = {
          function(cmp)
            cmp.scroll_documentation_down(4)
          end,
          "fallback",
        },

        ["<C-Space>"] = { "show" },

        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-n>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        keyword = { range = "full" },
        list = { selection = { preselect = true, auto_insert = true } },
        documentation = { auto_show = true },
        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label",    "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {

        default = {
          "lsp",
          "snippets",
          "path",
          "avante",
          "buffer",
          "ripgrep",
          "lazydev",
          "nvim_lsp_signature_help",
        },
        per_filetype = {
          sql = { "lsp", "snippets", "dadbod", "dbee", "buffer" },
        },
        providers = {
          avante = {
            name = "Avante",
            module = "blink-cmp-avante",
          },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              pattern = "rg",
            },
          },
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          dbee = {name = 'cmp-dbee', module = 'blink.compat.source'},
          lsp = {
            score_offset = 1,
          },
          ["nvim_lsp_signature_help"] = {
            name = "nvim_lsp_signature_help",

            module = "blink.compat.source",
          },

          lazydev = {
            name = "lazydev",

            module = "blink.compat.source",
          },
        },
      },
      fuzzy = { implementation = "rust" },
    },
  },
}
