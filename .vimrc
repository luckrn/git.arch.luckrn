" -------------------------------
" dim. 27 mai 2012 21:25:26 CEST
" ~/.vimrc
" viper@luke
" -------------------------------
"       _
"__   _(_)_ __   ___ _ __
"\ \ / / | '_ \ / _ \ '__|
" \ V /| | |_) |  __/ |
"  \_/ |_| .__/ \___|_|
"        |_|
"
"
" Init {{{
" Powerline
"let g:Powerline_symbols = 'fancy'
let g:Powerline_symbols = 'unicode'
" mouse ok for VimOrganizer
set mouse=a
" wrapping
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"   autocmd BufEnter * match OverLength /\%74v.*/
" augroup END
" set tw=72
" set fo=cqt
" set wm=0 " automatic wrapping at col 72

" fr qu'on cause ici…
:language fr_FR.UTF8
:language mes fr_FR.UTF8
:language cty fr_FR.UTF8
:language tim fr_FR.UTF8
" volet exploration Section, label,...
nnoremap <silent> <F8> :TlistToggle<CR>
source /home/luke/.vimrc.bepo
set nocompatible
set bs=2
" tabulation = espace
" set smartindent
" set expandtab
" set tabstop=4
" set shiftwidth=4
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
" end tabulation

" latex-suite
" filetype plugin on " to enable latex-suite when a tex file is loaded
" filetype indent off " for latex-suite
"set shellslash

" redefinir leader to ,
let mapleader = ","
" localleader ??
let maplocalleader=","
set incsearch
set ignorecase
set smartcase
set t_Co=256
let g:zenburn_high_Contrast = 1
:colo zenburn 
syntax enable
set bufhidden=hide

" Indentation (visual mode blockwise indent)
vmap > >gv
vmap < <gv
let timestamp_regexp = '\v\C%(<Last %([cC]hanged?|[Mm]odified):\s+)@<=.*$' 
" plugin timestamp
" }}}
"0 vimrc édition {{{
map ,v :sp /home/luke/.vimrc<cr> " edit my .vimrc file in a split
map ,e :e /home/luke/.vimrc<cr>      " edit my .vimrc file
map ,u :source /home/luke/.vimrc<cr> " update the system settings from my vimrc file
" }}}
" date mode insertion {{{
:iab <expr> dts strftime("%c")
" date anywhere/anytime
:nnoremap <F9> "=strftime("%c")<CR>P
" spell on/off F10
" source: http://vim.wikia.com/wiki/Toggle_spellcheck_with_function_keys
:" Spell Check
let b:myLang=0
let g:myLangList=["nospell","fr"]
function! ToggleSpell()
  let b:myLang=b:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction

nmap <silent> <F10> :call ToggleSpell()<CR>

"
" }}}
"Général {{{
" afficher caractères invisibles
set list "show tabs
set listchars=nbsp:¤,tab:>-,trail:¤,extends:>,precedes:<,eol:¶,trail:·
"{{{ Spell
" non, fonction toggle ! setlocal spell spelllang=fr
" next misspelled: ]s
" back misspelled: [s
" add good word: zg
" mark bad word: zG
" suggest good word: z=
" remplace all done by z= in the current window: :spellr[epall]



"}}}
set backup " make backup files
set backupdir=/home/luke/.vim/backup
set directory=/home/luke/.vim/tmp
set laststatus=2
set encoding=utf-8 "powerline
set cursorcolumn " highlight the current column
set cursorline " highlight the current line
set incsearch " but do highlight as you type search phrase
set linespace=0 " don't insert any extra pixel lines betweens rows
set number " turn on line numbers
set numberwidth=5
set report=0 " tell us when anything is changed via :...
set ruler " Always show current positions along the bottom
set scrolloff=5 " Keep 5 lines (top/bottom) for scope
set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
set showcmd " show the command being typed
set showmatch " show marching brackets
set sidescrolloff=5 " Keep 5 lines at the size
set title " show the current file name in the title bar
"}}}
" Folding {{{
set foldcolumn=5 " dans la marge, nombre de colonne pour les replis (5 = 5 sous-niveaux
set foldenable " Turn on folding
set foldmarker={{{,}}} " fold C style code (only use this as default if you use a high foldlevel
set foldmethod=marker " fold on the marker
" set foldlevel=100
set foldlevel=0 " tous les folds fermés à l'ouverture ? ben voui !
"set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
" pour info {
" Open all / Close all
" zR : decreases the foldlevel to zero -- all folds will be open
" zM : closes all open folds
" Go next, Go previous
" zj : moves the cursor to the next fold
" zk : moves the cursor the the previous fold
" Open
" zo : opens a fold at the cursor
" zO : opens all folds at the cursor
" Close
" zc : close 
" zC : close all ? Oui avec un visuel sur tout (gg V G et zC)
" Pareil pour tout fermer : gg G V et zo
" se rendre au Début / Fin du fold
" [z : move to start of open fold
" ]z : move to end of open fold
" }}}
" tabs {{{
set showtabline=2 " toujours voir les tabs
"help tabs: vim -p file1 file2 file3 = ouverts dans 3 tabs 
"help tabs: :tabnew<CR> =  Open new tab
"help tabs: :tabm n = move tab vers positon n (compte à partir de 0)tabdo
"%s/foo/bar/g = remplace bar par foo dans TOUS les onglets
"help tabs: :tabdo %s/foo/bar/g = remplace bar par foo dans TOUS les onglets
noremap <C-S-Tab> :tabprevious<CR>
noremap <C-Tab> :tabnext<CR>
noremap <C-t> :tabnew<CR>
noremap <C-w> :tabclose<CR>
" }}}
" Mapbpings {{{
" space /shift-space croll in normal mode
set backspace=2
noremap <backspace> <C-b>
noremap <space> <C-f>
"}}}
" Plugins usage {{{
"
" EasyMotion : aller à ... (comme pentadactyl dans FF)
  " commande <,w> (leader + w) puis la lettre highlighté pour se rendre au mot
  " commande <,fo> puis la lettre highlighté pour se rendre à la lettre demandée " (dans l'exemple : le o)
" Surround : entouré de...
  " Faire une sélection visual (vww par exemple) puis iws (InnerWordSurroun) et taper le texte correspondant à ce que l'on veut
" Tcomment : met/enlève les commentaires en s'adaptant au language utilisé
  " commande C_ C_ Sans rien faire, il prend la ligne. Visuel sur plusieurs " lignes et C_ C_ pour commenter/décommenter.
"
" Tips : adding a help file
" pour intégréer la doc de ~/.vim/doc, faire: :helptags ~/.vimdoc  puis  :help " easymotion par ex
"
" }}}
" " Marks usage {{{
" 
" function! SignFixme()
"   execute(":sign place ".line(".")." line=".line(".")." name=fixme file=".expand("%:p"))
" endfunction
" map <F5> :call SignFixme()<CR>
" map <C-F5> :sign unplace<CR>
" " }}}
" latex-suite {{{
set grepprg=grep\ -nH\ $*
set runtimepath+=/usr/share/vim/addons
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
set sw=2
set iskeyword+=:
" Tips http://linuxwisdom.blogspot.fr/2007/07/vim-latexsuite-xpdf-for-latex-editing.html 
" Run latex, then dvipdf, then refresh the xpdf window.
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi; xpdf -remote 127.0.0.1 -reload -raise'
let g:Tex_ViewRule_pdf = 'xpdf -remote 127.0.0.1'
let g:Tex_DefaultTargetFormat = 'pdf'
" Set the target format to pdf.

" Set the warning messages to ignore.
let g:Tex_IgnoredWarnings =
\"Underfull\n".
\"Overfull\n".
\"specifier changed to\n".
\"You have requested\n".
\"Missing number, treated as zero.\n".
\"There were undefined references\n".
\"Citation %.%# undefined\n".
\'LaTeX Font Warning:'"
" This number N says that latex-suite should ignore the first N of the above.
let g:Tex_IgnoreLevel = 8

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press Ctrl-N you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:
" }}}
" vimcommander {{{
noremap <silent> <F11> :cal VimCommanderToggle()<CR>
" nerdtree
map <F12> :NERDTreeToggle<CR>
" }}}
" " VimOrganizer {{{
" 
" THE NECESSARY STUFF" {{{
" THe three lines below are necessary for VimOrganizer to work right
" =================================================================
let g:ft_ignore_pat = '\.org'
"filetype plugin indent on
" and then put these lines in vimrc somewhere after the line above
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()
" let g:org_capture_file = '~/org_files/mycaptures.org'
" luke ?
" let g:org_capture_file = '~/test.org'
command! OrgCapture :call org#CaptureBuffer()
command! OrgCaptureFile :call org#OpenCaptureFile()
" }}}
" THE UNNECESSARY STUFF" {{{
"=============================================================
"  Everything below here is a customization.  None are needed.
"============================================================

" vars below are used to define default Todo list and
" default Tag list.  Both of these can also be defined 
" on a document-specific basis by config lines in a file.
" See :h vimorg-todo-metadata and/or :h vimorg-tag-metadata
" 'TODO | DONE' is the default,so not really necessary to define it at all
let g:org_todo_setup='TODO | DONE'
" OR, e.g.,:
" let g:org_todo_setup='TODO NEXT STARTED WAITED | DONE CANCELED'

" include a tags setup string if you want:
" let g:org_tags_alist='{@home(h) @work(w)} {Brest Quimper easy(e) hard(d)} {computer(c) phone(p) letter(l)}'
"
" g:org_agenda_dirs specify directories that, along with 
" their subtrees, are searched for list of .org files when
" accessing EditAgendaFiles().  Specify your own here, otherwise
" default will be for g:org_agenda_dirs to hold single
" directory which is directory of the first .org file opened
" in current Vim instance:
" Below is line I use in my Windows install:
" NOTE:  case sensitive even on windows.
" let g:org_agenda_select_dirs=["~/desktop/org_files"]
" let g:org_agenda_files = split(glob("~/desktop/org_files/org-mod*.org"),"\n")
let g:org_agenda_select_dirs=["/home/luke/org"]
let g:org_agenda_files = split(glob("/home/luke/org/*.org"),"\n")

let g:agenda_files = ['/home/luke/org/home.org','/home/luke/org/tweaks.org','/home/luke/org/work.org']
" }}}
" " Emacs setup {{{
" " --------------------
" " To use Emacs you will need to define the client.  On
" " Linux/OSX this is typically simple, just:
let g:org_command_for_emacsclient = 'emacsclient'
" " }}}
" " Custom Agenda Searches {{{
" " --------------------
" " the assignment to g:org_custom_searches below defines searches that a 
" " a user can then easily access from the Org menu or the Agenda Dashboard.
" " (Still need to add help on how to define them, assignment below
" " is hopefully illustrative for now. . . . )
let g:org_custom_searches = [
	    \  { 'name':"Next week's agenda", 'type':'agenda', 
	    \              'agenda_date':'+1w','agenda_duration':'w'}
            \, { 'name':"Next week's TODOS", 'type':'agenda', 
            \    'agenda_date':'+1w','agenda_duration':'w','spec':'+UNFINISHED_TODOS'}
	    \, { 'name':'Home tags', 'type':'heading_list', 'spec':'+HOME'}
	    \, { 'name':'Home tags', 'type':'sparse_tree', 'spec':'+HOME'}
	    \           ]
" " }}}
" " Custom colors {{{
" " --------------------------------"
" " OrgCustomColors() allows a user to set highlighting for particular items
" function! OrgCustomColors()
"     " various text item "highlightings" are below
"     " these are the defaults.  Uncomment and change a line if you
"     " want different highlighting for the element
"     "
"     " below are defaults for any TODOS you define.  TODOS that
"     " come before the | in a definition will use  'NOTDONETODO'
"     " and those that come after are DONETODO
"     hi! DONETODO guifg=green ctermfg=green
"     hi! NOTDONETODO guifg=red ctermfg=lightred
" 
"     " heading level highlighting is done in pairs, one for the
"     " heading when unfoled and one for folded.  Default is to make
"     " them the same except for the folded version being bold:
"     " assign OL1 pair for level 1, OL2 pair for level 2, etc.
"     " hi! OL1 guifg=somecolor guibg=somecolor 
"     " hi! OL1Folded guifg=somecolor guibg=somecolor gui=bold
" 
" 
"     " tags are lines below headings that have :colon:separated:tags:
"     hi! Org_Tag guifg=lightgreen ctermfg=blue
" 
"     "  lines that begin with '#+' in column 0 are config lines
"     hi! Org_Config_Line guifg=darkgray ctermfg=magenta
" 
"     "drawers are :PROPERTIES: and :LOGBOOK: lines and their associated
"     " :END: lines
"     hi! Org_Drawer guifg=pink ctermfg=magenta
"     hi! Org_Drawer_Folded guifg=pink ctermfg=magenta gui=bold cterm=bold
" 
"     " this applies to value names in :PROPERTIES: blocks 
"     hi! Org_Property_Value guifg=pink ctermfg=magenta
" 
"     " three lines below apply to different kinds of blocks
"     hi! Org_Block guifg=#555555 ctermfg=magenta
"     hi! Org_Src_Block guifg=#555555 ctermfg=magenta
"     hi! Org_Table guifg=#888888 guibg=#333333 ctermfg=magenta
" 
"     " dates are date specs between angle brackets (<>) or square brackets ([])
"     hi! Org_Date guifg=magenta ctermfg=magenta gui=underline cterm=underline
" 
"     " Org_Star is used to "hide" initial asterisks in a heading
"     hi! Org_Star guifg=#444444 ctermfg=darkgray
" 
"     hi! Props guifg=#ffa0a0 ctermfg=gray
" 
"     " bold, itals, underline, and code are highlights applied
"     " to character formatting
"     hi! Org_Code guifg=darkgray gui=bold ctermfg=14
"     hi! Org_Itals gui=italic guifg=#aaaaaa ctermfg=lightgray
"     hi! Org_Bold gui=bold guifg=#aaaaaa ctermfg=lightgray
"     hi! Org_Underline gui=underline guifg=#aaaaaa ctermfg=lightgray
"     hi! Org_Lnumber guifg=#999999 ctermfg=gray
" 
"     " these lines apply to links: [[link]], and [[link][link desc]]
"     if has("conceal")
"        hi! default linkends guifg=blue ctermfg=blue
"     endif
"     hi! Org_Full_Link guifg=cyan gui=underline ctermfg=lightblue cterm=underline
"     hi! Org_Half_Link guifg=cyan gui=underline ctermfg=lightblue cterm=underline
" 
"     "  applies to the Heading line that can be displayed in column view
"     "highlight OrgColumnHeadings guibg=#444444 guifg=#aaaaaa gui=underline
" 
"     " Use g:org_todo_custom_highlights to set up highlighting for individual
"     " TODO items.  Without this all todos that designate an uninished state 
"     " will be highlighted using NOTDONETODO highlight (see above) 
"     " and all todos that designate a finished state will be highlighted using
"     " the DONETODO highlight (see above).
    let g:org_todo_custom_highlights = 
               \     { 'NEXT': { 'guifg':'#888888', 'guibg':'#222222',
               \              'ctermfg':'gray', 'ctermbg':'darkgray'},
               \      'WAITING': { 'guifg':'#aa3388', 
               \                 'ctermfg':'red' } }

"endfunction
" 
" " below are two examples of Org-mode "hook" functions
" " These present opportunities for end-user customization
" " of how VimOrganizer works.  For more info see the 
" " documentation for hooks in Emacs' Org-mode documentation:
" " http://orgmode.org/worg/org-configs/org-hooks.php#sec-1_40
" "
" " These two hooks are currently the only ones enabled in 
" " the VimOrganizer codebase, but they are easy to add so if
" " there's a particular hook you want go ahead and request it
" " or look for where these hooks are implemented in 
" " /ftplugin/org.vim and use them as example for placing your
" " own hooks in VimOrganizer:
function! Org_property_changed_functions(line,key, val)
        "call confirm("prop changed: ".a:line."--key:".a:key." val:".a:val)
endfunction
function! Org_after_todo_state_change_hook(line,state1, state2)
        "call confirm("changed: ".a:line."--key:".a:state1." val:".a:state2)
        "call OrgConfirmDrawer("LOGBOOK")
        "let str = ": - State: " . org#Pad(a:state2,10) . "   from: " . Pad(a:state1,10) .
        "            \ '    [' . org#Timestamp() . ']'
        "call append(line("."), repeat(' ',len(matchstr(getline(line(".")),'^\s*'))) . str)
endfunction
" " }}}
" " Column view {{{
" let g:global_column_view = 1
" " let g:global_column_defaults = '%ITEM %15DEADLINE %30TAGS'
" " }}}
" 
" " }}}
" Ranger {{{
fun! RangerChooser()
   exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
   if filereadable('/tmp/chosenfile')
     exec 'edit ' . system('cat /tmp/chosenfile')
     call system('rm /tmp/chosenfile')
   endif
   redraw!
 endfun
 map ,r :call RangerChooser()<CR>
" Encryption
setlocal cm=blowfish
" -- END line--do-not-cross-----
