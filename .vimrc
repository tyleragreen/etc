" Tyler Green
" .vimrc

"------------------------------------------------------------------------------
" SET LEADER
"------------------------------------------------------------------------------
let mapleader = " "

set wildmenu
set wildmode=longest:full,full

" Use new regular expression engine
set re=0

" Replace tabs with spaces
set tabstop=2
set expandtab
set shiftwidth=2

" Backspace config
set backspace=indent,eol,start

" Show line numbers
set relativenumber
set number

" Highlight search results
set hlsearch

" Aliases
:command Ga !git add %
:command Q qall
:command W w
:command Wq wqall

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Airline for prettier status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Dependency for telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }

Plug 'tpope/vim-sensible'
"Plug 'github/copilot.vim'
Plug 'sainnhe/edge'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-rust-analyzer',
  \ 'coc-pyright',
  \ 'coc-kotlin'
  \ ]
call plug#end()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Syntax highlighting
colorscheme edge

" Enable Treesitter Folding
" (the rest of the configuration is in ~/.config/nvim/init.vim)
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufWinEnter * normal! zR

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme = 'tomorrow'
let g:airline#extensions#branch#enabled = 1

" Markdown Previouw
nnoremap <leader>mp <Plug>MarkdownPreviewToggle
