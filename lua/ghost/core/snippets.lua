local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local f = ls.function_node
local c = ls.choice_node
-- local r = ls.restore_node
-- local ms = ls.multi_snippet
-- local isn = ls.indent_snippet_node
--
local fmt = require("luasnip.extras.fmt").fmt

-- local m = extras.match
-- local rep = extras.rep
-- local l = extras.lambda
-- local p = extras.partial
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local extras = require("luasnip.extras")
-- local types = require("luasnip.util.types")
-- local events = require("luasnip.util.events")
-- local fmta = require("luasnip.extras.fmt").fmta
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local k = require("luasnip.nodes.key_indexer").new_key
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local parse = require("luasnip.util.parser").parse_snippet

local cl = s(
	"cl",
	fmt("console.log({})", {
		i(1, '"here", '),
	})
)

ls.add_snippets("javascript", { cl })
ls.add_snippets("typescript", { cl })

local jsx_snippets = {
	cl,
	s(
		"ust",
		fmt("const [{}, {}] = useState({})", {
			i(1, "state"),
			f(function(args)
				--- @type string
				local state = args[1][1]
				return "set" .. string.sub(state, 1, 1):upper() .. string.sub(state, 2)
			end, { 1 }),
			i(2, "initialState"),
		})
	),
	s(
		"uef",
		fmt(
			[[
    useEffect(() => {{
      {}
    }}, [{}]);
    ]],
			{
				i(1),
				i(2),
			}
		)
	),

	s(
		"rac",
		fmt(
			[[
        const {} = ({}) => {{
          {}
          return (
            <div>{}</div>
          );
        }}

        export default {};
        ]],
			{
				d(1, function()
					return sn(nil, {
						i(1, vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r")),
					})
				end),
				i(2, "props"),
				i(0),
				i(3),
				d(4, function(args)
					return sn(nil, {
						t(args[1]),
					})
				end, { 1 }),
			}
		)
	),

	s(
		"rfc",
		fmt(
			[[
        export default function {}({}) {{
          {}
          return (
            <div>{}</div>
          );
        }}
        ]],
			{
				d(1, function()
					return sn(nil, {
						-- jump-indices are local to each snippetNode, so restart at 1.
						i(1, vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r")),
					})
				end),
				i(2, "props"),
				i(0),
				i(3),
			}
		)
	),
}

ls.add_snippets("javascriptreact", vim.tbl_extend("force", jsx_snippets, {}))

local proptype = s(
	{ trig = "tp", priority = 4000 },
	fmt(
		[[
      type Props = {{
        {}{}
      }};
]],
		{
			i(1, "children: React.ReactNode;"),
			i(2, ""),
		}
	)
)

ls.add_snippets(
	"typescriptreact",
	vim.tbl_extend("keep", jsx_snippets, {
		proptype,
		cl,
		s(
			"trfc",
			fmt(
				[[
      type Props = {{
        {}
      }};

      export default function {}(props: Props) {{
        {}
        return (
          <div>{}</div>
        );
      }};
]],
				{
					i(3, "children: React.ReactNode;"),
					d(1, function()
						return sn(nil, {
							-- jump-indices are local to each snippetNode, so restart at 1.
							i(1, vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r")),
						})
					end, { 1 }),
					i(0),
					i(2),
				}
			)
		),
	})
)

--  C#
ls.add_snippets("cs", {
	s("cw", {
		t("Console.Write("),
		i(1),
		t(");"),
	}),
	s("cwl", {
		t("Console.WriteLine("),
		i(1),
		t(");"),
	}),
	s("cr", {
		t("Console.Read();"),
	}),
	s("crk", {
		t("Console.ReadKey();"),
	}),
	s("crl", {
		t("Console.ReadLine();"),
	}),
})
