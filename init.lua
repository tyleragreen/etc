vim.opt.colorcolumn = "100"

-- These must be setup in this order:
-- 1. mason
-- 2. mason-lspconfig
-- 3. lspconfig
require("mason").setup()
require("mason-lspconfig").setup {
    -- This prevents us from needing to run: rustup component add rust-analyzer
    -- To confirm it is installed, run: rustup component list
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "pyright",
      "clangd",
    },
}

-- Enable the autocompletion library, which we will later connect to the LSP.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  })
})

-- The connection between cmp and the LSP. When then pass this into each LSP such as rust-analyzer
-- and pyright below.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require'lspconfig'.pyright.setup {
  capabilities = capabilities,
}
require'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = {"c_stdlib"}
      }
    }
  }
}
require'lspconfig'.clangd.setup {}

-- These are the main LSP keymappings.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  end,
})

-- Autocommand to show diagnostics on hover. To support hover even while in insert mode,
-- you can add CursorHoldI. I found this annoying so I disabled it.
vim.api.nvim_create_autocmd({"CursorHold"}, {
  pattern = "*",
  callback = function()
    local opts = {
      focusable = false,
      close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
      border = 'none',
      source = false,
      prefix = ' '
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- You can adjust the delay for CursorHold event
vim.o.updatetime = 200  -- Time in milliseconds

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,  -- Enable syntax highlighting
  },
  indent = {
    enable = true,  -- Enable indenting
  },
  incremental_selection = {
    enable = true,  -- Enable incremental selection
  },
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "gomod",
    "html",
    "java",
    "javascript",
    "json",
    "jsonc",
    "kotlin",
    "lua",
    "python",
    "regex",
    "rust",
    "toml",
    "typescript",
    "yaml",
  },
}

require("noice").setup({
  lsp = {
    -- override markdown rendering so that cmp and other plugins use Treesitter
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})


require('lualine').setup {
  options = {
    theme = 'everforest',
  }
}

require("bufferline").setup{}

-- NOTE: This python virtualenv must have debugpy installed
require('dap-python').setup('~/.env/python/bin/python')
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
vim.keymap.set('n', '<leader>dc', function()
    dap.continue()
end, opts)
vim.keymap.set('n', '<leader>db', function()
    dap.toggle_breakpoint()
end, opts)
vim.keymap.set('n', '<leader>dt', function()
    dap.terminate()
end, opts)
vim.keymap.set('n', '<leader>ds', function()
    dap.step_over()
end, opts)
vim.keymap.set('n', '<leader>di', function()
    dap.step_into()
end, opts)
vim.keymap.set('n', '<leader>dr', function()
    dap.repl.open()
end, opts)
vim.keymap.set('n', '<leader>do', function()
    dapui.toggle()
end, opts)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local file = "~/Documents/repos/kotlin-debug-adapter/adapter/build/install/adapter/bin/kotlin-debug-adapter"
dap.configurations.kotlin = {
  {
      type = 'kotlin';
      request = 'launch';
      mainClass = '{}Kt';
      projectRoot = "${workspaceFolder}";
      name = "Launch file";
  },
}
dap.adapters.kotlin = {
  type = 'executable';
  command = file;
  options = {
    source_filetype = 'kotlin',
  }
}
dap.set_log_level("DEBUG")
