return {
	s({
		trig="date",
		name="date",
		dscr="add date in dd-mm-yyyy format"
	},
	fmt([[
	date: {}
	]],
	{f(date, {})}
	))
}
