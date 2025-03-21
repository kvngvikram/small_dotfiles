return {

	s({
		trig="#!",
		name="Bash bang",
		dscr="add #!/usr/bin/env python and autor details"
	},
	fmt([[
	#!/usr/bin/env python
	# author: Vikram KVNG
	# email: kvngvikram@sac.gov.in kvngvikram@gmail.com
	# date of creation: {}
	]],
	{f(date, {})}
	)),

	s({
		trig="#",
		name="cell",
		dscr="add # --"
	},
	fmt([[
	# --
	]],
	{}
	)),

	-- s({
	-- 	trig="pd.read",
	-- 	name="pd.read_csv",
	-- 	dscr="help filling the read_csv function"
	-- },
	-- fmt([[
	-- pd.read_csv({},
	-- header={},
	-- ]],
	-- {f(date, {})}
	-- )),
}
