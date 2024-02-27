local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Mapleader must be set before lazy is loaded or else some mappings will be incorrect
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.re = 0
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.colorcolumn = "100"

-- Aliases
vim.cmd('command Q qall')
vim.cmd('command W w')
vim.cmd('command Wq wqall')

-- Key remaps
vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>echo expand("%:p")<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>wc', ':let @+=expand("%:p")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>x', '<cmd>lua Close()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>lua ToggleLineNumbers()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>only<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>O', '<cmd>Oil --float<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Neogit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gm', '<cmd>DiffviewOpen origin/main..HEAD<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gl', '<cmd>execute "DiffviewFileHistory" expand("%:p")<CR>', { noremap = true })

-- Functions

-- Close in this order:
-- - tab
-- - horizontal/vertical split
-- - buffer
-- - Vim itself
Close = function()
  -- Close a tab if we have a second one. Plugins such as diffview and neogit use this model
  local num_tabs = vim.fn.tabpagenr('$')
  if num_tabs > 1 then
    vim.cmd('tabclose')
    return
  end

  -- Close a split if we have one
  -- There may be a way to do this with vim.fn.winnr('$'), but I wasn't able to get it to work.
  -- Using pcall here is conceptually similar to a try-catch
  local success, _ = pcall(function()
    vim.cmd('close')
    return "This will be the result if no error occurs"
  end)
  -- We closed a split!
  if success then
    return
  end

  -- Close a buffer if we have a second one.
  local num_buffers = vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)'))
  if num_buffers > 1 then
    vim.cmd('bdelete')
    return
  end

  vim.cmd('qall')
end

ToggleLineNumbers = function()
  if vim.wo.number then
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end


local plugins = {
  "folke/neodev.nvim",
  "Pocco81/auto-save.nvim",
  'nvim-lualine/lualine.nvim',
  'akinsho/bufferline.nvim',
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'sainnhe/edge',
  'folke/noice.nvim',
  'MunifTanjim/nui.nvim',
  'rcarriga/nvim-notify',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-vsnip',
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'mfussenegger/nvim-dap-python',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'numToStr/Comment.nvim',
  'nvim-treesitter/nvim-treesitter',
  'sindrets/diffview.nvim',
  'stevearc/oil.nvim',
  'NeogitOrg/neogit',
}


require("lazy").setup(plugins, {
  checker = {
    -- automatically check for plugin updates
    eabled = true,
  },
})

-- This references a plugin, so it must come after we call setup on lazy.
vim.cmd('colorscheme edge')

-- This must come before lspconfig
require("neodev").setup {
  pathStrict = false,
}

-- These must be setup in this order:
-- 1. mason
-- 2. mason-lspconfig
-- 3. lspconfig
require("mason").setup {}
require("mason-lspconfig").setup {
  -- This prevents us from needing to run: rustup component add rust-analyzer
  -- To confirm it is installed, run: rustup component list
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "pyright",
    "clangd",
    "taplo",
  },
}

-- Enable the autocompletion library, which we will later connect to the LSP.
local cmp = require 'cmp'
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

require 'lspconfig'.pyright.setup {
  capabilities = capabilities,
}
require 'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = { "c_stdlib" }
      }
    }
  }
}
require 'lspconfig'.clangd.setup {}
require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
}
require 'lspconfig'.taplo.setup {}

-- These are the main LSP keymappings.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function()
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
  end,
})

-- Autocommand to show diagnostics on hover. To support hover even while in insert mode,
-- you can add CursorHoldI. I found this annoying so I disabled it.
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'none',
      source = false,
      prefix = ' '
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- You can adjust the delay for CursorHold event
vim.o.updatetime = 200 -- Time in milliseconds

-- Useful commands for adding comments:
-- gcc: single line
-- gc: multiple line in visual mode
-- gb: multiple line block comment in visual mode
-- gcO: single line comment on line above
-- gco: single line comment on line below
-- gcA: single line comment at end of line
require('Comment').setup()

require("auto-save").setup {
  execution_message = {
    message = function() -- message to print on save
      return ("Saved at " .. vim.fn.strftime("%H:%M:%S"))
    end,
  },
}

require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true, -- Enable syntax highlighting
  },
  indent = {
    enable = true, -- Enable indenting
  },
  incremental_selection = {
    enable = true, -- Enable incremental selection
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
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})


require('lualine').setup {
  options = {
    theme = 'everforest',
  },
}

require("bufferline").setup {}

-- NOTE: This python virtualenv must have debugpy installed
require('dap-python').setup('~/.env/python/bin/python')
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
vim.keymap.set('n', '<leader>dc', function()
  dap.continue()
end)
vim.keymap.set('n', '<leader>db', function()
  dap.toggle_breakpoint()
end)
vim.keymap.set('n', '<leader>dt', function()
  dap.terminate()
end)
vim.keymap.set('n', '<leader>ds', function()
  dap.step_over()
end)
vim.keymap.set('n', '<leader>di', function()
  dap.step_into()
end)
vim.keymap.set('n', '<leader>dr', function()
  dap.repl.open()
end)
vim.keymap.set('n', '<leader>do', function()
  dapui.toggle()
end)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
dap.set_log_level("DEBUG")

require("oil").setup {
  view_options = {
    show_hidden = true,
  }
}
require("neogit").setup {}
