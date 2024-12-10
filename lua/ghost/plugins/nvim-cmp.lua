return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      {
        "L3MON4D3/LuaSnip", -- snippet engine
        event = "InsertEnter",
      },
      "saadparwaiz1/cmp_luasnip",  -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim",      -- vs-code like pictograms
      "hrsh7th/cmp-cmdline",
      {
        "MattiasMTS/cmp-dbee",
        dependencies = {
          { "kndndrj/nvim-dbee" },
        },
        ft = "sql", -- optional but good to have
        opts = {}, -- needed
      },
    },
    config = function()
      local cmp = require("cmp")

      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
        completion = {
          completeopt = "menu,noselect,noinsert",
        },
      })

      cmp.setup.cmdline(":", {

        completion = {
          completeopt = "menu,noselect,noinsert",
        },

        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
          },
        }),
      })

      cmp.setup({
        sorting = {
          priority_weight = 0,
        },

        completion = {
          completeopt = "menu,menuone,noinsert",
        },

        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(),   -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            priority = 51,
          },
          { name = "cmp-dbee", priority = 51 },
          { name = "luasnip",  priority = 50 }, -- snippets
          { name = "buffer" },            -- text within current buffer
          { name = "path" },              -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 30,
            ellipsis_char = "...",
            before = function(_, vim_item)
              vim_item.menu = ""
              return vim_item
            end,
          }),
        },
      })

      require("ghost.core.snippets")
    end,
  },
}
