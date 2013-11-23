" Touche Entrée pour utiliser les hyperliens de l'aide au lieu de C-]
nmap <buffer> <CR> <C-]>
" Touche Backspace pour page précédente
nmap <buffer> <BS> <C-T>

"go to the next place where an option link
nmap <buffer> o /''[a-z]\{2,\}''<CR>
"go to the previous place where an option link
nmap <buffer> O ?''[a-z]\{2,\}''<CR>
"go to the next subject link
nmap <buffer> s /\|\S\+\|<CR>
"go to the previous subject link
nmap <buffer> S ?\|\S\+\|<CR>

