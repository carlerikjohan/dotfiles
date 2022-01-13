set nocompatible
filetype on
filetype plugin on
filetype indent on

syntax on

set expandtab
set incsearch
set smartcase
set showmode
set number
set cursorline

nnoremap <Space> <Nop>
let mapleader = "\<space>" " Map leader to space

" https://github.com/Shougo/dein.vim
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/carlerikjohan/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/carlerikjohan/.local/share/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/carlerikjohan/.local/share/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
call dein#add('glacambre/firenvim', { 'hook_post_update': { _ -> firenvim#install(0) } })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
"  call dein#install()
endif

"End dein Scripts-------------------------
