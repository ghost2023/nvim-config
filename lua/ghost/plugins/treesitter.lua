return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- `main` does not support lazy-loading
		build = ":TSUpdate",
		dependencies = { "windwp/nvim-ts-autotag" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = { enable_close_on_slash = true },
			})

			local ts = require("nvim-treesitter")

			local function attach(buf, lang)
				if not pcall(vim.treesitter.start, buf, lang) then
					return false
				end
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				return true
			end

			-- `main` dropped the highlight/indent/auto_install modules, so wire them here.
			local tried = {} -- ponytail: in-memory, so a failed install retries next session
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if not lang or attach(ev.buf, lang) then
						return
					end
					if tried[lang] or not vim.tbl_contains(ts.get_available(), lang) then
						return
					end
					tried[lang] = true
					ts.install(lang):await(function()
						vim.schedule(function()
							if vim.api.nvim_buf_is_valid(ev.buf) then
								attach(ev.buf, lang)
							end
						end)
					end)
				end,
			})

			-- Replaces the old `incremental_selection` module with Nvim 0.12's built-in
			-- node selection. Calls the function directly because the `an` textobject
			-- in treesitter-text-objs.lua shadows the built-in `v_an` mapping.
			-- ponytail: vim.treesitter._select is private; swap to `an`/`in` if it moves.
			local function select_node(dir)
				return function()
					if vim.treesitter.get_parser(nil, nil, { error = false }) then
						local sel = require("vim.treesitter._select")
						local fn = dir > 0 and sel.select_parent or sel.select_child
						fn(vim.v.count1)
					else
						vim.lsp.buf.selection_range(dir * vim.v.count1)
					end
				end
			end

			vim.keymap.set("n", "<C-space>", "v<C-space>", { remap = true, desc = "Select node" })
			vim.keymap.set("x", "<C-space>", select_node(1), { desc = "Expand to parent node" })
			vim.keymap.set("x", "<BS>", select_node(-1), { desc = "Shrink to child node" })
		end,
	},
}
