return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local types = require("cmp.types")

		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load({ path = "~/.config/nvim/snippets" })

		cmp.setup({
			sorting = {
				priority_weight = 0,
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.offset,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        }
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
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
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
				{ name = "nvim_lsp", priority = 51 },
				{ name = "luasnip", priority=50 }, -- snippets
				{ name = "vim-dadbod-completion" }, -- sql
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 30,
					ellipsis_char = "...",
					before = function(_, vim_item)
						vim_item.menu = ""
						-- local limit = 20
						-- local str_len = string.len(vim_item.menu)
						-- if str_len > limit then
						-- 	vim_item.menu = string.sub(vim_item.menu, 1, limit - 3) .. "…"
						-- end
						return vim_item
					end,
				}),
			},
		})

    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    -- local sn = ls.snippet_node
    -- local isn = ls.indent_snippet_node
    -- local f = ls.function_node
    -- local c = ls.choice_node
    -- local d = ls.dynamic_node
    -- local r = ls.restore_node
    -- local events = require("luasnip.util.events")
    -- local ai = require("luasnip.nodes.absolute_indexer")
    -- local extras = require("luasnip.extras")
    -- local l = extras.lambda
    -- local rep = extras.rep
    -- local p = extras.partial
    -- local m = extras.match
    -- local n = extras.nonempty
    -- local dl = extras.dynamic_lambda
    -- local fmt = require("luasnip.extras.fmt").fmt
    -- local fmta = require("luasnip.extras.fmt").fmta
    -- local conds = require("luasnip.extras.expand_conditions")
    -- local postfix = require("luasnip.extras.postfix").postfix
    -- local types = require("luasnip.util.types")
    -- local parse = require("luasnip.util.parser").parse_snippet
    -- local ms = ls.multi_snippet
    -- local k = require("luasnip.nodes.key_indexer").new_key

    -- ls.add_snippets('all', {
    --  s("trig", c(1, {
    --     t("Ugh boring, a text node"),
    --     i(nil, "At least I can edit something now..."),
    --     f(function(args) return "Still only counts as text!!" end, {})
    --  }))
    -- })

    local js_snippets = {
      s("cl", {
       t"console.log(",
        i(1,"\"here\", "),
        i(2),
        t");",
      })
    }

    ls.add_snippets("javascript", js_snippets)

    ls.add_snippets("typescript", js_snippets)

    ls.add_snippets("javascriptreact", js_snippets)

    ls.add_snippets("typescriptreact", js_snippets)

    ls.add_snippets("typescriptreact", {
      s({trig ='tp',  priority = 4000}, {
        t({  "type Props = {", "\t" } ),
        i(1, "children: React.ReactNode;"),
        i(2, ""),
        t({"", "};"})
      })
    })
	end,
}
