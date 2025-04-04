require('johnston.remap')
require('johnston.lazy')

-- relative number and absolute number
vim.cmd.set('relativenumber number')

vim.cmd.set('tabstop=4 shiftwidth=4 expandtab')

vim.api.nvim_create_autocmd('InsertEnter', {
	command = 'set norelativenumber'
})
vim.api.nvim_create_autocmd('InsertLeave', {
	command = 'set relativenumber'
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
        "clangd",
        "basedpyright",
        "eslint",
        "tailwindcss",
    },
})
require'lspconfig'.basedpyright.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.rust_analyzer.setup{}

require'lspconfig'.cmake.setup{}
require'lspconfig'.clangd.setup{}

require'lspconfig'.jdtls.setup{}

require'lspconfig'.eslint.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.ts_ls.setup{}
require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.cssmodules_ls.setup{}
require'lspconfig'.mdx_analyzer.setup{}
require'lspconfig'.css_variables.setup{}

require'lspconfig'.sqlls.setup{}

require'lspconfig'.dockerls.setup{}
require'lspconfig'.docker_compose_language_service.setup{}

require'lspconfig'.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}

-- vim.lsp.enable({
-- 'eslint',
--     'lua-language-server',
--     'rust-analyzer',
--     'typescript-language-server',
--     'clangd',
--     'gopls',
--     'pyright',
--     'jdtls',
-- 'html-lsp',
-- 'css-lsp',
-- })

-- vim.opt.completeopt = "menu,menuone,noinsert"

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client:supports_method('textDocument/completion') then
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })
vim.diagnostic.config({ virtual_text = true })

print("Loaded johnston/init.lua")
