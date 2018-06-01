" Tyler Green
" .vimrc


function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

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
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
" Syntax Highlighting
Plug 'derekwyatt/vim-scala'
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'elixir-lang/vim-elixir'
call plug#end()
