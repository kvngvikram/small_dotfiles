return {
	s({
		trig="\\",
		name="generic {}",
		dscr="make a generic \\command{}"
	},
	fmt([[
	\<>{<>}<>
	]],
	{ i(1, "command"), i(2, "arguments"), i(0) },
	{ delimiters = "<>" }
	)),

	s({
		trig="frac",
		name="fraction",
		dscr="\frac{}{}"
	},
	fmt([[
	\frac{<>}{<>}<>
	]],
	{ i(1, "nominator"), i(2, "denominator"), i(0) },
	{ delimiters = "<>" }
	)),

	s({
		trig="it",
		name="Italics",
		dscr="\\textit{}"
	},
	fmt([[
	\textit{<><>}
	]],
	{f(function(_, snip) return snip.env.TM_SELECTED_TEXT[1] or {} end), i(0)},
	{ delimiters = "<>" }
	)),

	s({
		trig="bl",
		name="Bold",
		dscr="\\textbf{}"
	},
	fmt([[
	\textbf{<>}
	]],
	{f(function(_, snip) return snip.env.TM_SELECTED_TEXT[1] or {} end)},
	{ delimiters = "<>" }
	)),

	s({
		trig="lab",
		name="Label",
		dscr="\\label{}"
	},
	fmt([[
	\label{<>}
	]],
	{i(0)},
	{ delimiters = "<>" }
	)),

	s({
		trig="beg",
		name="begin-end",
		dscr="begin end block"
	},
	fmt([[
	\begin{<>}
		<>
	\end{<>}
	]],
	{ i(1, "block name"), i(0, "%content"), rep(1) },
	{ delimiters = "<>" }
	)),

	s({
		trig="itm",
		name="bullet item",
		dscr=""
	},
	fmt([[
	\item <>
	]],
	{ i(0, "")},
	{ delimiters = "<>" }
	)),
}
