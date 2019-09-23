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
Plugin 'vim-scripts/taglist.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'vim-airline/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'
Plugin 'vitalk/vim-simple-todo'
Plugin 'yuttie/comfortable-motion.vim'
" Plugin 'tmhedberg/simpylfold'
" Plugin 'ycm-core/YouCompleteMe' 
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
set ts=4
set wildmode=longest,list,full

set runtimepath^=~/.vim/bundle/ctrlp.vim

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" NERDTree
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

" comfortable scrolling
let g:comfortable_motion_scroll_down_key = 'j' 
let g:comfortable_motion_scroll_up_key = 'k'

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif
