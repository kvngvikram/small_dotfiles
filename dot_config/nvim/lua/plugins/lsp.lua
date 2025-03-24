return {

	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
			'SmiteshP/nvim-navic'
		},
		config = function()

			-- use :Mason to check the available servers
			-- and use LspInstall, LspUnsinstall etc to install them. And add then to the servers list below
			require('mason').setup()
			require('mason-lspconfig').setup()


			local on_attach = function(client, bufnr)

				-- buffer based keymaps as each buffer can be of different language
				local keymap_opts = { noremap = true, silent = true }
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keymap_opts)


				vim.diagnostic.config({  -- borders config seperately
					virtual_text = false,
					update_in_insert = true,
					severity_sort=true,
					float={border = "rounded"}
				})

				--set up diagnostic symbols on the left of numbers
				local signs = { Error = '❌', Warn = '⚠️', Hint = '💡', Info = 'ℹ️' }
				for type, icon in pairs(signs) do
					local hl = 'DiagnosticSign' .. type
					vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
				end

				--show diagnostic message while hovering
				-- You will likely want to reduce updatetime which affects CursorHold
				-- note: this setting is global and should be set only once
				-- vim.opt.updatetime = 2000  -- updatetime is set in init.lua !!
				vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


				-----  highlight references
				-- Along with CursorMoved and CursorMovedI, CursorHold and CursorHoldI are also present
				if client.server_capabilities.documentHighlightProvider then  -- check if the server has this feature
					vim.api.nvim_create_augroup('lsp_document_highlight', {})
					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI'}, {
						group = 'lsp_document_highlight',
						buffer = 0,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
						group = 'lsp_document_highlight',
						buffer = 0,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- sets up navic with lsp
				if client.server_capabilities.documentSymbolProvider then
					local navic = require("nvim-navic")
					navic.setup{highlight=true}
					navic.attach(client, bufnr)
				end
			end


			-- pylsp , jedi_language_server , lua_ls and ltex configuration is seperately written again below
			-- Fortls and julials still not working
			local all_servers = {'pylsp', 'jedi_language_server'}
			require('mason-lspconfig').setup({ ensure_installed = all_servers, automatic_installation = true })

			-- only for python LSP
			-- so using jedi just for documentHighlightProvider and pylsp for the rest because pylsp is better but slow with documentHighlightProvider
			-- diagnostics had to be disabled in a different way
			-- check https://www.reddit.com/r/neovim/comments/yv4t5o/why_doesnt_any_python_lsp_work_for_me/
			require('lspconfig').jedi_language_server.setup {
				on_attach = function(client, bufnr)
								client.server_capabilities.codeActionProvider = false
								client.server_capabilities.completionProvider = false
								client.server_capabilities.resolveProvider = false
								client.server_capabilities.definitionProvider = false
								client.server_capabilities.documentHighlightProvider = true
								client.server_capabilities.renameProvider = false
								client.server_capabilities.documentSymbolProvider = false
								client.server_capabilities.executeCommandProvider = false
								client.server_capabilities.hoverProvider = false
								client.server_capabilities.referencesProvider = false
								client.server_capabilities.signatureHelpProvider = false
								-- client.server_capabilities.textDocumentSync = false
								client.server_capabilities.typeDefinitionProvider = false
								client.server_capabilities.workspace = false
								client.server_capabilities.workspaceProvider = false
								client.server_capabilities.workspaceSymbolProvider = false

								on_attach(client, bufnr)

							end,
				handlers = {
					["textDocument/publishDiagnostics"] =  function()
						return nil
					end
				}
			}


			-- pylsp but disable the documentHighlightProvider
			require('lspconfig').pylsp.setup {
				on_attach = function(client, bufnr)
								client.server_capabilities.documentHighlightProvider = false
								-- client.server_capabilities.renameProvider = false
								on_attach(client, bufnr)
							end
			}

			-- Setting some styles and looks
			-- Use a sharp border with `FloatBorder` highlights
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
				vim.lsp.handlers.hover, { border = "double" })


		end

	},

}
