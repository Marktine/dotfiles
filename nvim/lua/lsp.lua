vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    float = { border = "single" },
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

  local active_clients = vim.lsp.get_active_clients()
  if client.name == 'denols' then
    for _, client_ in pairs(active_clients) do
      -- stop tsserver if denols is already active
      if client_.name == 'tsserver' then
        client_.stop()
      end
    end
  elseif client.name == 'tsserver' then
    for _, client_ in pairs(active_clients) do
      -- prevent tsserver from starting if denols is already active
      if client_.name == 'denols' then
        client.stop()
      end
    end
  end
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lspconfig = require'lspconfig'

lspconfig['tsserver'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
  root_dir = lspconfig.util.root_pattern("package.json"),
}

lspconfig['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

lspconfig['denols'].setup{
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

