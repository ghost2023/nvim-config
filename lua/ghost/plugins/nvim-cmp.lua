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

		local function deprioritize_snippet(entry1, entry2)
			if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return false
			end
			if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return true
			end
		end

		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load({ path = "~/.config/nvim/snippets" })

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
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<S-Tab>"] = cmp.mapping.complete(), -- show completion suggestions
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
				{ name = "nvim_lsp", priority = 9 },
				{ name = "luasnip" }, -- snippets
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
	end,
}
