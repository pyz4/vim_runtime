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
Plugin 'ap/vim-buftabline'
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set how many lines vim remembers
set history=500

filetype plugin on
filetype indent on

set autoread

set hidden
set tags=tags
set showmatch
set hlsearch
set incsearch
set smartcase
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
inoremap qw <Esc>:w<CR>
nnoremap <Down> 20j
nnoremap <Up> 20k
" nnoremap <Right> $
" nnoremap <Left> ^
"
" word manipulation
nnoremap o o<Esc>
nnoremap O O<Esc>
nnoremap dw diw

" buffers
nnoremap bdd :bd!<CR>

" navigation
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>
map <Leader>f :TagbarToggle<CR>
map j gj
map k gk

" pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-W> :bd<CR>
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

" Commenting
nnoremap <C-/> gcc
vnoremap <C-/> gc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Executing Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline) 
	let isfirst = 1
	let words = []
	let expanded_cmdline = a:cmdline
	" for word in split(a:cmdline)

	"   if isfirst
	"     let isfirst = 0  " don't change first word (shell command)
	"   else
	"     if word[0] =~ '\v[%#<]'
	"       let word = expand(word)
	"     endif
	"     let word = shellescape(word, 1)
	"   endif
	"   call add(words, word)
	" endfor
	" let expanded_cmdline = join(words)
	botright vnew
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	call setline(1, 'You entered:  ' . a:cmdline)
	call setline(2, 'Expanded to:  ' . expanded_cmdline)
	call append(line('$'), substitute(getline(2), '.', '=', 'g'))
	silent execute '$read !'. expanded_cmdline
	1
endfunction

command! -range Rshell '<,'>call s:RunShellCommandRange()
function! s:RunShellCommandRange() range
	let l:cmd = getline(a:firstline)
	for line_number in range(a:firstline+1, a:lastline)
		let l:cmd = join([l:cmd, getline(line_number)], " ")
	endfor
	call s:RunShellCommand(l:cmd)
endfunction

vnoremap `` :'<,'>Rshell<CR>
nnoremap `` :.Rshell<CR>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
