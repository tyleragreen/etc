" Tyler Green
" .vimrc

"------------------------------------------------------------------------------
" SET LEADER
"------------------------------------------------------------------------------
let mapleader = " "

set wildmenu
set wildmode=longest:full,full

" Syntax highlighting
syntax on
colorscheme desert
" Use new regular expression engine
set re=0

" Replace tabs with spaces
set tabstop=2
set expandtab
set shiftwidth=2

" Backspace config
set backspace=indent,eol,start

" Show line numbers
set nu

" Highlight search results
set hlsearch

" Experiment section from https://github.com/tpope/vim-sensible
set incsearch
set autoread

" Enable auto-indent
set autoindent

" Aliases
:command Q q
:command W w
:command Wq wq
:command Sp set paste
:command Snp set nopaste

" Configure white space characters
" This can be turned on with :set list and turned off with :set nolist
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'vim-airline/vim-airline'
"" Syntax Highlighting
Plug 'udalov/kotlin-vim'
Plug 'derekwyatt/vim-scala'
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'elixir-lang/vim-elixir'
"" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"" let g:coc_global_extensions = [
""   \ 'coc-tsserver'
""   \ ]
call plug#end()

" -----------------------------------------------------------
" Telescope mappings
" ----------------------------------------------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>fd <cmd>Telescope find_files<cr>
" Same command without previewer
nnoremap <leader><leader> <cmd>lua require('telescope.builtin').find_files { previewer = false}<cr>

" Search for string in the current working direcotry
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" Search for string under your curseor
nnoremap <leader>fc <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <Leader>r <cmd>lua require'telescope.builtin'.registers{}<CR>

"---------------------------------------------------------------
" LSP Saga Configuration
"----------------------------------------------------------------
lua << EOF
    local saga = require 'lspsaga'
    saga.init_lsp_saga{
        -- Code acton icond doesn't seem to be working correctly. 
        -- Disabling it for now
        code_action_icon=''
    }
EOF
" others
nnoremap <silent> <leader>t <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR> bash<CR>
tnoremap <silent> <leader>t <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
" rename
nnoremap <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>

"-----------------------------------------------------------------
" LSP Configuration - TypeScript
" For new langs, makes sure add the name to the keybinding config
"----------------------------------------------------------------
lua << EOF
require'lspconfig'.tsserver.setup{
        flags = {
          debounce_text_changes = 150,
        }
    }
EOF

"-----------------------------------------------------------------------
" nvim.cmp configuration
"----------------------------------------------------------------------

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
     ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
     ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
     ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
     ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
     ['<C-f>'] = cmp.mapping.scroll_docs(4),
     ['<C-Space>'] = cmp.mapping.complete(),
     ['<C-e>'] = cmp.mapping.close(),
     ['<CR>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  })
    },
    sources = {
      { name = 'nvim_lsp' },
      -- For vsnip user.
      { name = 'vsnip' },
      -- { name = 'buffer' },
    }
  })
  
    -- Setup lspconfig.
  require('lspconfig')["tsserver"].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

EOF

"------------------------------------------------------------------------------
" airline customizations
"------------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

"------------------------------------------------------------------------------
" Buffers like tabs
"------------------------------------------------------------------------------
nmap <leader>T :enew<CR>

nmap <leader>n :bnext<CR>
nmap <leader>b :bprevious<CR>

nmap <leader>l :ls<CR>

nmap <leader>q :bp <BAR> bd #<cr>

nmap <leader>h <C-W><C-H>
nmap <leader>l <C-W><C-L>

"------------------------------------------------------------------------------
" Toggle paste mode
"------------------------------------------------------------------------------
nmap <leader>p :set paste<CR>
nmap <leader>np :set nopaste<CR>

"------------------------------------------------------------------------------
" Notetime
"------------------------------------------------------------------------------
command NTSourceAdd :r ~/new_source_template.txt
