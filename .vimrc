syntax on
highlight! link SignColumn LineNr
filetype plugin indent on
set nocompatible
let mapleader=","
set ruler
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set backspace=indent,eol,start
set autowrite
set statusline+=%{gutentags#statusline()}
"set tags=tags;/
set laststatus=2
set noerrorbells visualbell

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

" plug-ins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
"Plug 'vim-scripts/ctags.vim'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'tpope/vim-dispatch'
Plug 'mileszs/ack.vim'
"Plug 'Shougo/neocomplete.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

"autocmd VimEnter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
nnoremap <silent><F6> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache!
let g:ctrlp_use_caching = 0
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:neocomplete#enable_at_startup = 1
"let g:airline#extensions#tabline#enabled = 2
let g:airline_theme = 'base16_colors'

"map arrow keys to split window navigation
"nnoremap <up> <c-w>k
"nnoremap <down> <c-w>j
"nnoremap <left> <c-w>h
"nnoremap <right> <c-w>l

"shorter split window navigation (Control and vim movement keys)
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"map <C-t>k :tabr<cr>
"map <C-t>j :tabl<cr>
"map <C-t>h :tabp<cr>
"map <C-t>l :tabn<cr>

"nnoremap <c-t> <c-^>

"let g:ctrlp_extensions = ['tag', 'buffertag']
nnoremap <leader><leader> :CtrlP<cr>
nnoremap <leader>. :CtrlPTag<cr>
"nnoremap <Leader>ct :!ctags -Ra<cr><cr>

" go language
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
map <Leader>n :cnext<CR>
map <Leader>m :cprevious<CR>
nnoremap <leader>a :cclose<CR>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
"let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
