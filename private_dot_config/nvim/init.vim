""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins - vim-plug (https://github.com/junegunn/vim-plug)

filetype off

call plug#begin('~/.config/nvim/plugged')

" --- Git
Plug 'tpope/vim-fugitive'                                         " Git plugin with commands 'G<command>'
Plug 'Xuyuanp/nerdtree-git-plugin'                                " Show git status in NERD Tree

" --- Navigation
Plug 'farmergreg/vim-lastplace'                                   " Move cursor to last edit location when reopening files
Plug 'cskeeters/vim-smooth-scroll'                                " Smooth scroll animation instead of jump
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

" --- Behaviour/tools
Plug 'tpope/vim-sensible'                                         " Sensible vim defaults
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }             " NERD Tree - tree explorer

" --- Autocompletion
Plug 'ludovicchabant/vim-gutentags'                               " Automatically generate ctags on write

" Fuzzy file, buffer, mru, tag, etc finder
" ctrlp.vim
" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" Initial settings

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
set lazyredraw                                  " Do not redraw screens during macros, etc.
set spellfile=~/.config/nvim/spell/en.utf-8.add " Save valid words to file (used with :set spell)
set termguicolors                               " Make sure that 256 colors are used
set bg=dark                                     " Set dark background
set signcolumn=yes                              " Always show sign column since we use vim-gitgutter
colorscheme moonfly                             " Moonfly theme

""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings

" vim-airline status
let g:airline_theme='moonfly'
let g:airline_powerline_fonts = 1
" show buffers (if only one tab)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" indentline - color and char - note: indentline sets conceallevel=2
let g:indentLine_defaultGroup = 'Whitespace'
let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = ['json', 'markdown']

" vim-gitgutter - use nerd fonts icons as signs
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPTag'
let g:ctrlp_working_path_mode = ''

" vim-gutentags - the path to store tags files, instead of in the project root
let g:gutentags_cache_dir = stdpath('cache') . '/ctags'
let g:gutentags_ctags_exclude = ['*.md', '*.html', '*.json', '*.toml', '*.css', '*.js', '*.xml',]

" Use Ag (the silver searcher) instack of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =====================================
" key map
" Understand mapping modes:
" http://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping#answer-3776182
" http://stackoverflow.com/questions/22849386/difference-between-nnoremap-and-inoremap#answer-22849425
" =====================================

" change the leader key from "\" to ";" ("," is also popular)
let mapleader=";"
"let mapleader=","

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" use ;; for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ;; <Esc>

" Auto complete these
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Surround the visual selection in parenthesis/brackets/etc
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a`<esc>`<i`<esc>

" Map auto complete of (, ", ', [
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i

" Toggle NERDTree
" Can't get <C-Space> by itself to work, so this works as Ctrl - space - space
" https://github.com/neovim/neovim/issues/3101
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim#answer-24550772
nnoremap <C-Space> :NERDTreeToggle<CR>
"nmap <C-@> <C-Space>
""nnoremap <silent> <Space> :NERDTreeToggle<CR>

" toggle tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>

" toggle line numbers
nnoremap <silent> <leader>n :set number! number?<CR>

" toggle line wrap
nnoremap <silent> <leader>w :set wrap! wrap?<CR>

" toggle buffer (switch between current and last buffer)
nnoremap <silent> <leader>bb <C-^>

" go to next buffer
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <C-l> :bn<CR>

" go to previous buffer
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <C-h> :bp<CR>

" close buffer
nnoremap <silent> <leader>bd :bd<CR>

" kill buffer
nnoremap <silent> <leader>bk :bd!<CR>

" list buffers
nnoremap <silent> <leader>bl :ls<CR>
" list and select buffer
nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

" horizontal split with new buffer
nnoremap <silent> <leader>bh :new<CR>

" vertical split with new buffer
nnoremap <silent> <leader>bv :vnew<CR>

" redraw screan and clear search highlighted items
"http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#answer-25569434
"nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" use double-Esc to completely clear the search buffer
nnoremap <silent> <Esc><Esc> :let @/ = ""<CR>
" use space to retain the search buffer and toggle highlighting off/on
"nnoremap <silent> <Space> :set hlsearch!<CR>

"" vimux
"" https://raw.githubusercontent.com/benmills/vimux/master/doc/vimux.txt
"nnoremap <leader>vc :VimuxPromptCommand<CR>
"nnoremap <leader>vl :VimuxRunLastCommand<CR>
"nnoremap <leader>vq :VimuxCloseRunner<CR>
"nnoremap <leader>vx: VimuxInterruptRunner<CR>

" improved keyboard navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" improved keyboard support for navigation (especially terminal)
" https://neovim.io/doc/user/nvim_terminal_emulator.html
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Alt+arrow Navigation
" https://vim.fandom.com/wiki/Switch_between_Vim_window_splits_easily
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <silent> <leader>tt :terminal<CR>
nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
nnoremap <silent> <leader>th :new<CR>:terminal<CR>
tnoremap <C-x> <C-\><C-n><C-w>q

" Grep content of all files
nnoremap <silent> <leader>/ :Find<CR>

" =====================================
" Go
" https://github.com/fatih/vim-go
" =====================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" go-def is automatically by default to plain "gd" (no leader required)
au FileType go nnoremap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gp <Plug>(go-def-pop)

au FileType go nnoremap <Leader>gv <Plug>(go-doc-vertical)
" or open in a browser...
au FileType go nnoremap <Leader>gb <Plug>(go-doc-browser)

au FileType go nnoremap <Leader>s <Plug>(go-implements)
au FileType go nnoremap <Leader>i <Plug>(go-info)
au FileType go nnoremap <Leader>gl <Plug>(go-metalinter)
au FileType go nnoremap <Leader>gc <Plug>(go-callers)

" https://github.com/fatih/vim-go-tutorial/blob/master/vimrc
augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" =====================================
" Custom find
" =====================================
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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" =====================================
" Custom styling
" =====================================

" http://vim.wikia.com/wiki/Highlight_current_line
" http://stackoverflow.com/questions/8750792/vim-highlight-the-whole-current-line
" http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-events
autocmd BufEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline
autocmd WinLeave * setlocal nocursorline

" Set conceallevel=0 to show all - note: this is overridden by indentline
" plugin
"autocmd BufEnter * set conceallevel=0
"autocmd BufEnter * set concealcursor=n

" tagbar autopen
"autocmd VimEnter * nested :call tagbar#autoopen(1)
"autocmd FileType * nested :call tagbar#autoopen(0)
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" =====================================
" auto completion
" =====================================
set completeopt+=noinsert
set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#use_cache = 1

" Enable spellchecking in natural language files
augroup NaturalLanguage
    autocmd!
    autocmd BufRead,BufNewFile *.md,*.rst,*.txt setlocal spell spelllang=en_us
    autocmd FileType gitcommit setlocal spell spelllang=en_us
augroup END

" Use word completion when spelling is enabled
set complete+=kspell

" =====================================
" Init
" =====================================
"autocmd BufEnter * call gitgutter#highlight#linenr_enable()
autocmd VimEnter * call gitgutter#highlight#linenr_enable()
autocmd VimEnter * wincmd p
