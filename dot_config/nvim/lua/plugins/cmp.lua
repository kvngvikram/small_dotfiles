return {

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{

				'L3MON4D3/LuaSnip',
				dependencies = { 'rafamadriz/friendly-snippets' },
			},
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-emoji',
		},
		event = 'InsertEnter',
		config = function()

			-- setting up nvim-cmp
			-- symbols to use in completion menu
			local kind_icons = { Text = '', Method = '', Function = '',
				Constructor = '', Field = '', Variable = '', Class = 'ﴯ', Interface = '',
				Module = '', Property = 'ﰠ', Unit = '', Value = '', Enum = '',
				Keyword = '', Snippet = '', Color = '', File = '', Reference = '',
				Folder = '', EnumMember = '', Constant = '', Struct = '', Event = '',
				Operator = '', TypeParameter = ''
			}


			local cmp = require('cmp')
			local luasnip = require('luasnip')
			require('luasnip.loaders.from_vscode').lazy_load()

			 -- function to be used for tab completion to check if tab should trigger completion or insert tab
			local has_words_before = function()
				local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line -1, line, true)[1]:sub(col, col):match('%s') == nil
			end

			cmp.setup({  -- generic setup

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-- mappings for insert mode completion
				mapping = cmp.mapping.preset.insert({

					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { 'i', 's' }),

					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),

					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),


				-- different sources from which completion menu is populated
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'emoji' },
				}),


				-- How the entries in the completion menu are formatted
				formatting = {
					format = function(entry, vim_item)
						-- Kind icons
						vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
						-- Show some identifier from which source an entry came from
						vim_item.menu = ({
							buffer = '[Buffer]',
							nvim_lsp = '[LSP]',
							luasnip = '[LuaSnip]',
							nvim_lua = '[Lua]',
							latex_symbols = '[LaTeX]',
							mkdnflow = '[MkdnFlow]',
						})[entry.source.name]
						return vim_item
					end
				},

				window = { documentation = cmp.config.window.bordered() },
			})

			cmp.setup.cmdline('/', {  -- for searchs only use contents in buffer
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {  -- for cmdline both file/folders and cmdline stuff
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' },
					{ name = 'cmdline'},
				})
			})


			-- LuaSnip
			-- Please look at complete mapping tips in luasnip webpage
			local ls = require('luasnip')
			-- imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-j>'
			-- vim.keymap.set('i', '<C-j>',
			-- function()
			-- 	if ls.expandable() then
			-- 		ls.expand()
			-- 	elseif ls.jumpable() then
			-- 		ls.jump(1)
			-- 	else
			-- 		print('going for cj')
			-- 		return '<C-j>'
			-- 	end
			-- end,
			-- {remap=true}
			-- )
			vim.keymap.set({'i', 's'}, '<C-l>', function() ls.jump( 1) end, {silent = true})
			vim.keymap.set({'i', 's'}, '<C-k>', function() ls.jump(-1) end, {silent = true})

		end,
	},

}
