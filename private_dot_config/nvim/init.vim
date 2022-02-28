""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS - vim-plug (https://github.com/junegunn/vim-plug)
"

" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

filetype off

call plug#begin('~/.config/nvim/plugged')

" --- Go
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" --- Git
Plug 'tpope/vim-fugitive'                                         " Git plugin with commands 'G<command>'
Plug 'Xuyuanp/nerdtree-git-plugin'                                " Show git status in NERD Tree

" --- Navigation
Plug 'farmergreg/vim-lastplace'                                   " Move cursor to last edit location when reopening files
"Plug 'cskeeters/vim-smooth-scroll'                                " Smooth scroll animation instead of jump
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy file++ searching
Plug 'junegunn/fzf.vim'                                           " Asynchronous file/tags searcher

" --- Visual
Plug 'bluz71/vim-moonfly-colors'                                  " Moonfly colorscheme
Plug 'vim-airline/vim-airline'                                    " Airline status/tabline
Plug 'vim-airline/vim-airline-themes'                             " Airline themes
Plug 'airblade/vim-gitgutter'                                     " Shows a git diff in the sign column
Plug 'majutsushi/tagbar'                                          " Open tag navigation split with :Tagbar
Plug 'sheerun/vim-polyglot'                                       " Add syntax highlighting for a large range of filetypes
Plug 'Yggdroot/indentLine'                                        " Display thin lines for code indented with spaces
Plug 'jiangmiao/auto-pairs'                                       " Insert or delete brackets, parens, quotes in pair

" --- Behaviour/tools
Plug 'tpope/vim-sensible'                                         " Sensible vim defaults
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }             " NERD Tree - tree explorer

" --- Autocompletion
Plug 'ludovicchabant/vim-gutentags'                               " Automatically generate ctags on write
Plug 'neoclide/coc.nvim', {'branch': 'release'}                   " Coc.vim
Plug 'vim-syntastic/syntastic'                                    " Syntax checking (golangci_lint f.ex)

" Fuzzy file, buffer, mru, tag, etc finder
" ctrlp.vim
" https://github.com/ctrlpvim/ctrlp.vim
"Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" INITIAL SETTINGS
"

" Stuff enabled by vim-sensible:
"  syntax enable                                - Color highlighting
"  filetype plugin indent on                    - Filetype detection and correct indentation
"  wildmenu                                     - Show autocomplete in vim command mode
"  encoding=utf-8                               - Encode as UTF-8
"  autoread                                     - Autoread file changes (undoable by u)
"  incsearch                                    - Start searching before pressing enter
"  <C>-L keybinding                             - For removing search highlight
"  laststatus=2                                 - Show statusline at all times
"  scrolloff=1                                  - Always show at least one line above/below the cursor
"  load matchit.vim                             - Jump between matching tags with %
"  backspace=2                                  - Delete over newlines, etc.
"  ruler                                        - Enable line and column display

set title
set showmatch
set matchpairs+=<:>
set vb t_vb=                                    " Disable beep / flash
set expandtab                                   " Convert tabs into spaces
set tabstop=4                                   " Visualize tabs as 4 spaces
set softtabstop=4                               " Tab and backspace whitespace
set shiftwidth=4                                " Indentation level for autoindent
set list                                        " Display tabs and white spaces
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.  " Characters to show for the above, below fillchars for space indents
set fillchars+=vert:\ 
set number relativenumber                       " Set relative line numbering - toggle with ';n'
set nowrap                                      " Disable line wrapping - toggle with ';w'
set noshowmode                                  " Disable showmode since using vim-airline
set scrolloff=7                                 " Always show at least 7 lines above/below the cursor
set sidescrolloff=7                             " Always show at least 7 chars left/right of the cursor
set hidden                                      " Allow switching between buffers - http://vim.wikia.com/wiki/Easier_buffer_switching
set confirm                                     " Confirm before leaving unsaved buffer
set autowriteall                                " Write buffers before it is hidden
set splitright                                  " Split to the right
set splitbelow                                  " Split below
set nofoldenable                                " Disable folding
set ignorecase                                  " Search case insensitive...
set smartcase                                   " ... but not when it begins with upper case
set clipboard=unnamedplus                       " Use system clipboard
set undofile                                    " Keep undo history between sessions
set undodir=~/.config/nvim/undodir              " Undo directory
set noswapfile                                  " Turn off swapfile
"set lazyredraw                                  " Do not redraw screens during macros, etc.
set spellfile=~/.config/nvim/spell/en.utf-8.add " Save valid words to file (used with :set spell)
set termguicolors                               " Make sure that 256 colors are used
set bg=dark                                     " Set dark background
set signcolumn=number                           " Recently vim can merge signcolumn with number column into one (gitgutter and coc.vim)
set complete+=kspell                            " Use word completion when spelling is enabled
colorscheme moonfly                             " Moonfly theme

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*/.git/*,*/.svn/*,*.DS_Store
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*

" highlight whitespaces
match MoonflyRed /\s\+$/

" coc.nvim specific settings
set formatexpr=CocActionAsync('formatSelected')
set jumpoptions=stack                           " have jumplist behave like tagstack or like a browser
set tagfunc=CocTagFunc                          " fuction to use for tag searches
set pumheight=20                                " nr items to show in popup menu
set nobackup                                    " some servers have issues with backup files, see #649
set nowritebackup                               " same as above...
set cmdheight=2                                 " give more space for displaying messages
set updatetime=100                              " less updatetime for better user experience (default is 4000 ms = 4 s)
set shortmess+=c                                " Don't pass messages to |ins-completion-menu|

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOMATIC COMMANDS
augroup common
  autocmd!
  " Shift focus to previous window when starting up
  autocmd VimEnter * wincmd p

  " Auto start NERD tree when opening a directory
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif
  " Auto start NERD tree if no files are specified
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif
  " Let quit work as expected if after entering :q the only window left open is NERD Tree itself
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  autocmd TermOpen * startinsert " Start terminal in insert mode

  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline " Hightlight current line
  autocmd WinLeave * setlocal nocursorline

  autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4
  autocmd FileType lua,ruby,html,javascript,typescript,css,json,vue,vim,yaml setlocal shiftwidth=2 tabstop=2
  autocmd FileType gitcommit setlocal spell spelllang=en_us
  autocmd BufNewFile,BufRead *.md,*.rst,*.txt setlocal spell spelllang=en_us

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  autocmd BufWritePre *.go silent! :call CocAction('runCommand', 'editor.action.organizeImport')

  " set up default omnifunc
  autocmd FileType *
    \ if &omnifunc == "" |
    \    setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
augroup end
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS

command! -nargs=0 Format                :call CocAction('format')
command! -nargs=? Fold                  :call CocAction('fold', <f-args>)
command! -nargs=0 OR                    :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --line-number --no-heading --fixed-strings --smart-case --hidden --follow --glob "!{.git/*,tags}" --color=always '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 2..'}, 'right:50%'),
  \   <bang>0
  \ )

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBINDINGS
"

" Set leader key
let mapleader=";"

" Edit/source config
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" Buffer commands
nnoremap <silent> <leader>bb <C-^>      " toggle buffer (switch between current and last buffer)"
nnoremap <silent> <leader>bn :bn<CR>    " next buffer
nnoremap <silent> gb :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>    " previous buffer
nnoremap <silent> gB :bp<CR>
nnoremap <silent> <leader>bd :bd<CR>    " close buffer
nnoremap <silent> <leader>bk :bd!<CR>   " kill buffer
nnoremap <silent> <leader>bh :new<CR>   " horizontal split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>  " vertical split with new buffer

" use double-Esc to completely clear the search buffer
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>

" improved keyboard support for navigation (especially terminal)
" https://neovim.io/doc/user/nvim_terminal_emulator.html
"tnoremap <Esc> <C-\><C-n>
"tnoremap <A-h> <C-\><C-n><C-w>h
"tnoremap <A-j> <C-\><C-n><C-w>j
"tnoremap <A-k> <C-\><C-n><C-w>k
"tnoremap <A-l> <C-\><C-n><C-w>l
"inoremap <A-h> <C-\><C-n><C-w>h
"inoremap <A-j> <C-\><C-n><C-w>j
"inoremap <A-k> <C-\><C-n><C-w>k
"inoremap <A-l> <C-\><C-n><C-w>l
"nnoremap <A-h> <C-w>h
"nnoremap <A-j> <C-w>j
"nnoremap <A-k> <C-w>k
"nnoremap <A-l> <C-w>l

" Alt+arrow Navigation
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Terminal shortcuts
"nnoremap <silent> <leader>tt :terminal<CR>
"nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
"nnoremap <silent> <leader>th :new<CR>:terminal<CR>
"tnoremap <C-x> <C-\><C-n><C-w>q

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYBINDINGS for PLUGINS

" Toggle NERDTree
nnoremap <C-Space> :NERDTreeToggle<CR>

" toggle tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" :GFiles
"nnoremap <C-p> :GFiles<CR>

" :Buffers
nnoremap <silent> <leader>bl :Buffers<CR>

"" All files in project
"nnoremap <silent> <leader><space> :Files<CR>
"
"" All tags in current buffer
"nnoremap <silent> <leader>T :BTags<CR>
"
"" All tags in project
"nnoremap <silent> <leader>t :Tags<CR>
"
"" Command
"nnoremap <silent> <leader>: :Commands<CR>
"
"" All git commits
"nnoremap <silent> <leader>gl :Commits<CR>
"
"" All git commits in current buffer
"nnoremap <silent> <leader>gL :Commits<CR>

" Grep content of all files
nnoremap <silent> <leader>/ :Find<CR>

"" Search normal mode mappings
"nnoremap <silent> <leader><Esc> :Maps<CR>
"
"" Search helptags
"nnoremap <silent> <leader>hh :Helptags<CR>

""" Coc.nvim settings

" GoTo code navigation.
nmap <silent> gd :call <SID>GoToDefinition()<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references-used)
nmap <silent> gn <Plug>(coc-rename)              " Symbol renaming.
nmap <silent> gA <Plug>(coc-codeaction)          " Remap keys for applying codeAction to the current buffer.
nmap <silent> gl <Plug>(coc-codeaction-line)
nmap <silent> ga <Plug>(coc-codeaction-cursor)
nmap <silent> gk <Plug>(coc-fix-current)         " Apply AutoFix to problem on the current line.

" multiple cursors
nmap <silent> <expr> <C-d>  <SID>select_current_word()
nmap <silent> <C-c>         <Plug>(coc-cursors-position)
xmap <silent> <C-d>         <Plug>(coc-cursors-range)

" format
nmap <leader>x              <Plug>(coc-cursors-operator)
nmap <leader>rf             <Plug>(coc-refactor)
xmap <leader>f              <Plug>(coc-format-selected)
nmap <leader>f              <Plug>(coc-format-selected)

" codeaction
xmap <leader>a              <Plug>(coc-codeaction-selected) " codeaction to selected region ex: `<leader>aap`"
nmap <leader>a              <Plug>(coc-codeaction-selected)

" function select
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
vnoremap <silent> K       <cmd>call CocActionAsync('doHover')<CR>

" Mappings for CoCList
nnoremap <silent><nowait> <space>o  :<C-u>CocList -A outline -kind<CR>                        " find symbol of current document
nnoremap <silent><nowait> <space>l  :<C-u>CocList lines<CR>                                   " search lines by regex pattern
nnoremap <silent><nowait> <space>q  :<C-u>CocList quickfix<CR>                                " quickfix
nnoremap <silent><nowait> <space>m  :<C-u>CocList -A -N mru<CR>                               " most recent used files
nnoremap <silent><nowait> <space>w  :<C-u>CocList -I -N symbols<CR>                           " search workspace symbols
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<CR>                        " yank history
nnoremap <silent><nowait> <space>b  :<C-u>CocList -A -N --normal buffers<CR>                  " current buffer list
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>                                         " Do default action for next item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>                                         " Do default action for previous item.
nnoremap <silent><nowait> <space>S  :exe 'CocList -A --normal grep '.expand('<cword>').''<CR> " grep(rg) for word"
nnoremap <silent><nowait> <space>d  :call CocActionAsync('jumpDefinition', v:false)<CR>       " jump to to  Definition

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS

" used with 'gd' mapping
function! s:GoToDefinition()
  if CocActionAsync('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error" || ret =~ "错误"
    call searchdecl(expand('<cword>'))
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
endif

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
"
"""" coc.nvim
let g:coc_global_extensions = [
      \'coc-go',
      \'coc-json',
      \'coc-lists',
      \'coc-marketplace',
      \'coc-pyright',
      \'coc-sh',
      \'coc-yank'
      \]

"""" vim-airline status
let g:airline_theme='moonfly'
let g:airline_powerline_fonts = 1
" show buffers (if only one tab)
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1

"""" indentline - color and char - note: indentline sets conceallevel=2
let g:indentLine_defaultGroup = 'Whitespace'
let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = ['json', 'markdown']

"""" vim-gitgutter - use nerd fonts icons as signs
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

"""" ctrlp.vim
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlPTag'
"let g:ctrlp_working_path_mode = ''

" vim-gutentags - the path to store tags files, instead of in the project root
"let g:gutentags_cache_dir = stdpath('cache') . '/ctags'
set tags=./.tags;,.tags
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
let g:gutentags_ctags_exclude = ['*.md', '*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor', '.idea']
"let g:gutentags_ctags_exclude = ['*.md', '*.html', '*.json', '*.toml', '*.css', '*.js', '*.xml', '@.gitignore']

"""" vim-go
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" jump to existing buffer for :GoDef and :GoDefType
let g:go_def_reuse_buffer = 1

" disable godoc for words under the cursor with K
let g:go_doc_keywordprg_enabled = 0

" automatically highlight variable your cursor is on
" note: disabled, too disruptive for me
"let g:go_auto_sameids = 0

" Hightlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" vim-syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['golangci_lint']

""""""""""""""""""""""""""""""""""""""""""""""""""

