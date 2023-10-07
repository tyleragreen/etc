set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
-- I had to run this command to install rust-analyzer to my current toolchain,
-- which is nightly-aarch64-apple-darwin.
--
-- rustup component add rust-analyzer
--
-- To confirm it is installed, run this:
--
-- rustup component list
--
-- KEEPING THIS DISABLED AS OF 2023-09-24 BECAUSE IT IS SLOWER THAN USING
-- coc-rust-analyzer.
-- require'lspconfig'.rust_analyzer.setup({})
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--   callback = function(ev)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set('n', '<leader>f', function()
--       vim.lsp.buf.format { async = true }
--     end, opts)
--   end,
-- })

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
    tabline = {
      lualine_a = {'buffers'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
    }
  }
}

require("bufferline").setup{}

-- NOTE: This python virtual must have debugpy installed
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
EOF
