" ~/.vimrc — my Vim configuration (as of 2026-10-22)
" Vim reads this file on every start. Comments start with "
" Comments always sit on their own line here: after a mapping (nmap/inoremap)
" a " would otherwise be read as part of the mapping.

" Vim mode instead of compatibility with old vi (otherwise many Vim features are missing)
set nocompatible

" Detect the file type (.py, .R, .md …) and load matching plugin settings for it
filetype plugin on

" Turn on syntax highlighting (colored code)
syntax on

" Show line numbers on the left
set number

" Relative line numbers (distance to cursor line, handy for 5j, 3dd …) — off
" set relativenumber

" Always show the status bar at the bottom (2 = always, even with a single window)
set laststatus=2

" Vim's default register = Mac clipboard: y copies straight to Cmd+V, p pastes Cmd+C text
set clipboard=unnamed

" A tab character is displayed 4 columns wide
set tabstop=4

" Mouse active in all modes: click moves the cursor, drag selects, scrolling works
set mouse=a

" Wrap long lines at the window edge (display only, the file is unchanged)
set wrap

" When typing a closing bracket, briefly flash the matching opening one
set showmatch

" Highlight the line the cursor is on (easier to find the cursor after n/N)
set cursorline

" Highlight all search matches (clear with :noh)
set hlsearch

" Jump to the first match while still typing /pattern
set incsearch

" (duplicate, see above) tab width 4 columns
set tabstop=4

" Insert mode: typing kj quickly = Esc (back to normal mode without stretching fingers)
inoremap kj <esc>

" Normal mode: K moves the current line up one (:m = move, -2 = above the previous line)
nmap K :m -2<CR>
" Normal mode: J moves the current line down one (replaces Vim's J = join lines)
nmap J :m +1<CR>

" Cursor shape: vertical bar in insert mode (t_SI = Start Insert, \e[6 q = bar)
let &t_SI = "\e[6 q"
" Cursor shape: back to block when leaving insert mode (t_EI = End Insert, \e[1 q = blinking block)
let &t_EI = "\e[1 q"

" Color scheme retrobox (ships with Vim 9.0 and later)
" background FIRST: retrobox has a light and a dark variant; without this line
" Vim guesses from the terminal (sometimes "light" -> cream background)
set background=dark
colorscheme retrobox
