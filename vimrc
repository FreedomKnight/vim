"======================= Plug ==========================

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'schickling/vim-bufonly'
Plug 'Yggdroot/indentLine'

Plug 'storyn26383/emmet-vim'
Plug 'tpope/vim-surround'

Plug 'scrooloose/syntastic'

Plug 'stephpy/vim-php-cs-fixer'
Plug 'StanAngeloff/php.vim'
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' } 
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}

Plug 'vim-vdebug/vdebug'
Plug 'vim-test/vim-test'
Plug 'benmills/vimux'

Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

Plug 'digitaltoad/vim-pug'
Plug 'storyn26383/vim-vue'

Plug 'pangloss/vim-javascript'

Plug 'toyamarinyon/vim-swift'

Plug 'udalov/kotlin-vim'

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

Plug 'godlygeek/tabular'

Plug 'plasticboy/vim-markdown'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'leafgarland/typescript-vim'

Plug 'rhysd/vim-wasm'

Plug 'AndrewRadev/splitjoin.vim'
call plug#end()

"====================== Settings =======================
syntax on

set nu
set incsearch
set ignorecase
set autoread
set nocompatible
set nobackup " no *~ backup files
set noswapfile
set nowritebackup
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set tags+=~/.vim/tags,./tags,tags;
set hidden " leave buffer without save

autocmd FileType make setlocal noexpandtab
autocmd FileType php setlocal omnifunc=phpactor#Complete
autocmd FileType js,vue,css,html,typescript,javascript,yaml setlocal sw=2 sts=2 ts=2

nmap <F2> :ctags -R<CR>
nmap <F4> :w<CR>:make<CR>
nmap <F5> :w<CR>
nmap <F6> :cl<CR>
nmap <F7> :! gdb <CR>
nmap <F8> :Tlist<CR>
nmap <Leader>i :IndentLinesToggle<CR>
nmap <Leader>s :LeadingSpaceToggle<CR>
nmap <Leader>l :IndentLinesToggle<CR>
nmap <Leader>b :Buffer<CR>
nmap <Leader>a :Ag<CR>
nmap <Leader>f :Files<CR>

map <C-n> :NERDTreeToggle<CR>

let g:vim_markdown_folding_disabled = 1

"===================== Ctags ===========================

function! UpdateTags()
  let tags = 'tags'

  if filereadable(tags)
    let file = substitute(expand('%:p'), getcwd() . '/', '', '')

    " remove tags of file and append tags
    call system('sed -ri "/\s+' . escape(file, './') . '/d"' . tags . ' && ctags -a "' . file . '" &')
  endif
endfunction

autocmd BufWritePost *.php,*.cpp,*.cc,*.h,*.c call UpdateTags()
autocmd BufWritePost *.php,*.cpp,*.cc,*.h,*.c %retab!

"======================= Air Line ==========================
let g:airline_theme="tomorrow"
let g:airline_powerline_fonts = 1
" set status line
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1

"========================== PHP ============================
function! PhpSyntaxOverride()
    " Put snippet overrides in this function.
    hi! link phpDocTags phpDefine
    hi! link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

" php cs fixer
let g:php_cs_fixer_level = 'psr2'
let g:php_cs_fixer_enable_default_mapping = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=psr2'


"=========================== indentLine ============================

let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_color_term = 239

let g:indentLine_leadingSpaceChar = '.'
autocmd FileType html,css,php,c,cpp,swift,python,ruby,dart,go :IndentLinesEnable

"=========================== indentLine ============================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"


"========================== Phpactor ==============================
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

"========================== Flutter ==============================

let g:flutter_show_log_on_run = 0
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

"========================== vdebug ==============================

if !exists('g:vdebug_options')
  let g:vdebug_options = {}
endif
let g:vdebug_options.port = 9001

"========================== vimtest =============================

let test#strategy = 'vimux'
let g:test#preserve_screen = 0
let test#php#phpunit#executable = 'XDEBUG_CONFIG="remote_enable=1" ./vendor/bin/phpunit'
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
