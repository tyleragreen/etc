set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Load the nvim-treesitter plugin
lua << EOF
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
EOF
