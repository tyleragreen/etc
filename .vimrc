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
Plug 'vim-airline/vim-airline'
"" Syntax Highlighting
Plug 'derekwyatt/vim-scala'
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'elixir-lang/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
call plug#end()

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
