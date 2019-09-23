filetype plugin indent on
syntax enable
colorscheme zenburn

" VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'vim-airline/vim-airline'
Plugin 'dense-analysis/ale'
Plugin 'grep.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'psf/black'
Plugin 'scrooloose/nerdtree'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vitalk/vim-simple-todo'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set tags=tags
set showmatch
set hlsearch
set incsearch
set number relativenumber
set showcmd
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
set bs=2
set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab

set runtimepath^=~/.vim/bundle/ctrlp.vim

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" NERDTree
nnoremap <Leader>t :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1

" vim-indent-guides
" let g:indent_guides_enable_on_vim_startup = 1

" remappings
inoremap qq <Esc>
inoremap QQ <Esc>
nnoremap <Down> 20j
nnoremap <Up> 20k
nnoremap <Right> $
nnoremap <Left> ^
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap f<Tab> :b#<CR>
nnoremap fw :bd<CR>
map <Leader>f :TagbarToggle<CR>
map j gj
map k gk

" pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" indentation
set breakindent
set breakindentopt=shift:2,min:40,sbr
set showbreak=...

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif
