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

" Replace tabs with spaces
set tabstop=2
set expandtab
set shiftwidth=2

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
:command Sp set paste
:command Snp set nopaste

" Configure white space characters
" This can be turned on with :set list and turned off with :set nolist
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Update time was lowered to help airblade/vim-gutter reload more often
" https://github.com/airblade/vim-gitgutter#getting-started
set updatetime=100

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
"Plug 'w0rp/ale' " this is another syntax checker, but it requires vim8 (and
"is asynchronous!)
Plug 'vim-syntastic/syntastic'
" Syntax Highlighting
Plug 'derekwyatt/vim-scala'
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'elixir-lang/vim-elixir'
call plug#end()

"------------------------------------------------------------------------------
" Syntastic customizations
"------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

"------------------------------------------------------------------------------
" ctrlp customizations
"------------------------------------------------------------------------------
let g:ctrlp_show_hidden = 1

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
