call plug#begin("~/.vim/plugged")
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'mhinz/vim-startify'
Plug 'qpkorr/vim-bufkill'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

" Default Color scheme
let mapleader = " "

"Questionable mappings
imap jk <Esc>
nnoremap <silent> ; :

" J is for Join, K is for KRAC!
nnoremap K i<Enter><Esc>
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>


" buffer
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-S-n> :bprevious<CR>

"windows
set splitright
set splitbelow
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>R :source $MYVIMRC<CR>:PlugInstall<CR>:source $MYVIMRC<CR>
nnoremap <leader>' :call fzf#run(fzf#wrap({'sink': 'vsplit'}))<CR>
nnoremap <leader>/ :call fzf#run(fzf#wrap({'sink': 'split'}))<CR>

" movement
noremap <silent> <leader>j :call smooth_scroll#down(30, 10, 2)<CR>
noremap <silent> <leader>k :call smooth_scroll#up(30, 10, 2)<CR>

" opening new windows
nnoremap <silent> <leader>Q :close<CR>
nnoremap <silent> <leader>q :BD<CR>
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" colorschemes
" nnoremap <silent> <leader>c1 :colo deus          <CR>:AirlineTheme deus   <CR>
" nnoremap <silent> <leader>c2 :colo seoul256-light<CR>:AirlineTheme zenburn<CR>
" nnoremap <silent> <leader>c3 :colo true          <CR>:AirlineTheme true   <CR>

" FZF
nnoremap <silent> <leader><Space> :Files<CR>
nnoremap <silent> <leader>b       :Buffers<CR>

" deoplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

map <silent> <f5> :call ToggleSpell()<CR>
map <silent> <f9> :make<CR>
map <f10> :!~/.scripts/show_md.sh %<CR>

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set so=10
set ruler
set ignorecase
set noerrorbells

syntax on
set encoding=utf8

set expandtab
set shiftwidth=2
set tabstop=2
set number
set foldmethod=manual
set autowrite
set nofoldenable

" don't create .netrwhist
let g:netrw_dirhistmax = 0

func! PreviewMarkdown()
  :call CompileMarkdown()<CR><CR>
  execute "! zathura /tmp/op.pdf &"
endfu
nnoremap <leader>p :call PreviewMarkdown()<CR>

func! CompileMarkdown()
  let extension = expand('%:e')
  if extension == "md"
    execute "! pandoc % -s -o /tmp/op.pdf"
  endif
endfu

func ToggleSpell()
  if &spell
    set nospell
  else
    set spell
  endif 
endfu
