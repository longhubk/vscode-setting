
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.

" show git
Plug 'tpope/vim-fugitive'

" Enhanced statusline
Plug 'itchyny/lightline.vim'

" file manager
Plug 'preservim/nerdtree'

" git for file manager
Plug 'Xuyuanp/nerdtree-git-plugin'

"color schemes
"Plug 'jdsimcoe/hyper.vim'
Plug 'crusoexia/vim-monokai'
"Plug 'blueshirts/darcula'

"float term"
Plug 'voldikss/vim-floaterm'

" language server"
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf file seaching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" file icon noworing
"Plug 'ryanoasis/vim-devicons' 
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" auto bracket
Plug 'Raimondi/delimitMate'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif


" Line numbering
" Toggle set to ';n' in key map section
set number

" change the leader key from "\" to ";" ("," is also popular)
let mapleader=";"

"" Set tabs and indents (for go)
set ts=2
set shiftwidth=2
set ai sw=2

" replace tab with spaces
set expandtab

" Disable line wrapping
" Toggle set to ';w' in key map section
" set wrap

" enable line and column display
set ruler

" file type recognition
filetype on
filetype plugin on
filetype indent on

" syntax highlighting
syntax on

" improved keyboard navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" disable ctrl z -> u
noremap <C-Z> u

" colorscheme hyper
" colorscheme dracula
colorscheme monokai

" Float term"
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>


" coc.vim config
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

nmap <Leader>f :Format <CR>

" shift + K => hover show document
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" highlight word in cusor
autocmd CursorHold * silent call CocActionAsync('highlight')

" NERD tree configuration
noremap <C-d> :NERDTreeToggle<CR>
noremap <C-i> :NERDTreeFind<CR>

let NERDTreeShowHidden=1

" Lightline
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }


" Map phím tắt Ctrl + P
nnoremap <silent> <C-p> :Files<CR>

"" Tìm file trong project, nhưng bỏ mấy thư mục như node_modules ra, để tìm nhẹ hơn.
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"" Map phím "\f" để tìm nội dung, tương tự như "Ctrl + Shift + F" trên VSCode nhé
nnoremap <silent> <C-f> :Rg<CR>

" file icon "no need in neovim
"set encoding=UTF-8

" reload neovim

nnoremap <leader>r :source $MYVIMRC<CR>
