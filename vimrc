syntax enable

" python support
let g:python2_host_prog = system('which python2.7')
let g:python3_host_prog = system('which python3')

" using vim-plug 
call plug#begin('~/.config/nvim/plugged')

" Plugin 'VundleVim/Vundle.vim'
" Plugin 'vim-airline/vim-airline'
" Plug 'grep.vim'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/echodoc.vim'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'ap/vim-buftabline'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'jnurmine/Zenburn'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'psf/black'
Plug 'scrooloose/nerdtree'
Plug 'severin-lemaignan/vim-minimap'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/taglist.vim'
Plug 'vitalk/vim-simple-todo'
Plug 'icymind/NeoSolarized'
" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color schemes
colorscheme NeoSolarized
let g:neosolarized_contrast = 'high'
set termguicolors
set background=light

" Set how many lines vim remembers
set history=1000

filetype plugin on
filetype indent on

set autoread

set hidden
set tags=tags
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set number relativenumber
set showcmd
set cursorline
hi CursorLine term=bold cterm=bold guibg=#ffbf00
set bs=2
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=0 noexpandtab

set runtimepath^=~/.vim/bundle/ctrlp.vim

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>r :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1

" vim-indent-guides
" let g:indent_guides_enable_on_vim_startup = 1

" remappings
inoremap qw <Esc>:w<CR>
inoremap qq <Esc>
inoremap QQ <Esc>
nnoremap <Down> <C-d>M
nnoremap <Up> <C-u>M
nnoremap <S-s> :w<CR>
" nnoremap <Right> $
" nnoremap <Left> ^

" word manipulation
nnoremap o o<Esc>
nnoremap O O<Esc>

" buffers
nnoremap bdd :bd!<CR>
nnoremap <C-W> :bd<CR>
" nnoremap bdd :bp<cr>:bd #<cr>
" nnoremap <C-W> :bd<CR>

" navigation
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>
map <Leader>f :TagbarToggle<CR>
map j gj
map k gk
nnoremap J jz.
nnoremap K kz.
nnoremap <space> z.

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

" search
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
nnoremap <C-_> :TagbarClose<CR>:vimgrep /
autocmd QuickFixCmdPost *grep* cwindow 
"" remap so it's easy to use with one hand
nnoremap m Nz.
nnoremap N :cn<CR>z.
nnoremap M :cp<CR>z.

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" echodoc
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

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
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	call setline(1, 'You entered:  ' . a:cmdline)
	call setline(2, 'Expanded to:  ' . expanded_cmdline)
	call append(line('$'), substitute(getline(2), '.', '=', 'g'))
	silent execute '$read !'. expanded_cmdline
	1
endfunction

command! -range Rshell <line1>,<line2>call s:RunShellCommandRange()
function! s:RunShellCommandRange() range
	let l:cmd = getline(a:firstline)
	for line_number in range(a:firstline+1, a:lastline)
		let l:cmd = join([l:cmd, getline(line_number)], " ")
	endfor
	call s:RunShellCommand(l:cmd)
endfunction

nnoremap `` :.Rshell<CR>
vnoremap `` :'<,'>Rshell<CR>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'filename', 'readonly', 'modified' ] ]
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
