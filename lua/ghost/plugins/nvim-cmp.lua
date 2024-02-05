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
		require("luasnip.loaders.from_vscode").lazy_load()

		-- 	completion = { completeopt = "menu,menuone,noinsert" },
		cmp.setup({

			-- sorting = {
			-- 	priority_weight = 2,
			-- 	comparators = {
			-- 		deprioritize_snippet,
			-- 		-- the rest of the comparators are pretty much the defaults
			-- 		cmp.config.compare.offset,
			-- 		cmp.config.compare.exact,
			-- 		cmp.config.compare.scopes,
			-- 		cmp.config.compare.score,
			-- 		cmp.config.compare.recently_used,
			-- 		cmp.config.compare.locality,
			-- 		cmp.config.compare.kind,
			-- 		cmp.config.compare.sort_text,
			-- 		cmp.config.compare.length,
			-- 		cmp.config.compare.order,
			-- 	},
			-- },

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
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}

-- -- import nvim-cmp plugin safely
-- local cmp_status, cmp = pcall(require, "cmp")
-- if not cmp_status then
-- 	return
-- end
--
-- -- import luasnip plugin safely
-- local luasnip_status, luasnip = pcall(require, "luasnip")
-- if not luasnip_status then
-- 	return
-- end
--
-- -- import lspkind plugin safely
-- local lspkind_status, lspkind = pcall(require, "lspkind")
-- if not lspkind_status then
-- 	return
-- end
--
-- -- load vs-code like snippets from plugins (e.g. friendly-snippets)
-- -- require("luasnip/loaders/from_vscode").lazy_load()
-- -- require("luasnip/loaders/from_vscode").lazy_load({ "../snippets" })
--
-- vim.opt.completeopt = "menu,menuone,noselect"
--
-- cmp.setup({
-- 	completion = { completeopt = "menu,menuone,noinsert" },
-- 	snippet = {
-- 		expand = function(args)
-- 			luasnip.lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		-- ["Tab"] = false,
-- 		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
-- 		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
-- 		["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
-- 		["<C-e>"] = cmp.mapping.abort(), -- close completion window
-- 		["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 	}),
-- 	-- sources for autocompletion
-- 	sources = cmp.config.sources({
-- 		{ name = "nvim_lsp" }, -- lsp
-- 		{ name = "luasnip" }, -- snippets
-- 		{ name = "buffer" }, -- text within current buffer
-- 		{ name = "path" }, -- file system paths
-- 	}),
-- 	-- configure lspkind for vs-code like icons
-- 	formatting = {
-- 		format = lspkind.cmp_format({
-- 			maxwidth = 50,
-- 			ellipsis_char = "...",
-- 		}),
-- 	},
-- })
