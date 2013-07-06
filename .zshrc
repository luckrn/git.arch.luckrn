#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
    if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
      source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    fi

# Customize to your needs...
# source custom colors: {{{
# --------------------
    # le fichier manuel
      eval $(dircolors -b ${HOME}/.dircolors)
#}}}
# editor vim  {{{
    export VISUAL="vim"
    export EDITOR="${VISUAL}"
# }}}
# Alias commande {{{
    # ls
      alias lsd='lt -ld *(/)'
    # on/off
      alias x='sudo umount -a 2>/dev/null; sudo poweroff'
      alias rsync='rsync --progress -h -r'
    # console
      alias ZZ='exit'
      alias :q='exit'
      alias :q!='exit'
    # pour awesome
      alias vimrclua='vim ~/.config/awesome/rc.lua'
    # Archlinux
      alias s='yaourt -Syu'
# alias xclip
      alias pbcopy='xclip -selection clipboard'       # copy to the clipboard, ctrl+c, ctrl+shift+c
      alias pbpaste='xclip -selection clipboard -o'   # paste from clipboard, ctrl+v, ctrl+shift+v
      alias pbselect='xclip -selection primary -o'    # paste from highlight, middle click, shift+insert
# }}}
# Color in Man pages {{{
# Get color support for 'less'
    export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
    [[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP
# }}}

# Alias executable {{{
  alias -s m4v="cvlc"
  alias -s mp4="cvlc"
  alias -s avi="cvlc"
  alias -s Avi="cvlc"
  alias -s part="cvlc"
  alias -s mkv="cvlc"
  alias -s mpg="cvlc"
  alias -s mov="cvlc"
  alias -s wmv="cvlc"
  alias -s flv="cvlc"
  alias -s pdf="zathura"
  alias -s org="vim"
  alias -s doc="libreoffice"
  alias -s sxw="libreoffice"        # texte
  alias -s docx="libreoffice"
  alias -s odt="libreoffice"
  alias -s ppt="libreoffice"
  alias -s pps="libreoffice"
  alias -s sti="libreoffice"        # modèle présentation
  alias -s sxi="libreoffice"        # présentation
  alias -s xls="libreoffice"
  alias -s sxc="libreoffice"        # classeur
  alias -s xlsx="libreoffice"
  alias -s stc="libreoffice"        # modèle classeur
  alias -s std="libreoffice"        # moièle dessin
  alias -s stw="libreoffice"        # modèle texte
  alias -s sxd="libreoffice"        # dessin
  alias -s sxm="libreoffice"        # formule
  alias -s cbr="mcomix"             # comix
# }}}
# export dirs {{{
  export dlr=~/dl/rtorrent
  export cv=/media/c/vidéos
  export fv=/media/freebox/Vidéos
  export fvf=/media/freebox/Vidéos/Family
  export fvc=/media/freebox/Vidéos/cc
  export f=/media/freebox
# }}}
# vim Mon Précieux {{{
# ---------------

  bindkey -v # use vi keymap
  # On remappe pour le bépo
  # source: Zsh line editor (the Z shell guide) http://www.cs.elte.hu/zsh-manual/zsh_14.html
    # Movement
      # char
        bindkey -a c vi-backward-char
        bindkey -a r vi-forward-char
      # word
        bindkey -a é vi-forward-blank-word-end
        bindkey -a b vi-backward-blank-word
      # début,fin de ligne
        bindkey -a 0 vi-digit-or-beginning-of-line 
        bindkey -a $ vi-end-of-line
      # Edition
        bindkey -a dé delete-word
        bindkey -a d kill-line  #pète d'où on est jusqu'à la fin de ligne

        bindkey -a t vi-down-line-or-history
        bindkey -a s vi-up-line-or-history
        bindkey -a h vi-change
        bindkey -a H vi-change-eol
        bindkey -a dd vi-change-whole-line
        bindkey -a l vi-replace-chars
        bindkey -a L vi-replace
        bindkey -a k vi-substitute
        bindkey -a é vi-forward-blank-word-end

      # recherche dans history
        bindkey '^R' history-incremental-search-backward
        bindkey '^S' history-incremental-search-forward
        #see: http://stackoverflow.com/questions/171563/whats-in-your-zshrc
        bindkey -M vicmd 'u' undo

        # }}}
# search history: {{{
#  https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/history-substring-search/history-substring-search.zsh
# taper un motif de recherche puis uparrow ou downarrow pour chercher l'occurence dans history
# Ctrl U pour annuler
# NB: doit être placé avant le plugin «zsh-syntax-highlighting» pour bénéficier de la couleur
    source /usr/share/oh-my-zsh/plugins/history-substring-search/history-substring-search.zsh
    # pb rencontré: ne marchait pas car placé après «bindkey -v»
# }}}

# Functions
    # extract any archive {{{
      extract_archive ()
        {
          local old_dirs current_dirs lower
          lower=${(L)1}
          old_dirs=( *(N/) )
          if [[ $lower == *.tar.gz || $lower == *.tgz ]]; then
              tar zxfv $1
          elif [[ $lower == *.gz ]]; then
              gunzip $1
          elif [[ $lower == *.tar.bz2 || $lower == *.tbz ]]; then
              bunzip2 -c $1 | tar xfv -
          elif [[ $lower == *.bz2 ]]; then
              bunzip2 $1
          elif [[ $lower == *.zip ]]; then
              unzip $1
          elif [[ $lower == *.rar ]]; then
              unrar e $1
          elif [[ $lower == *.tar ]]; then
              tar xfv $1
          elif [[ $lower == *.lha ]]; then
              lha e $1
          else
              print "Unknown archive type: $1"
              return 1
          fi
          # Change in to the newly created directory, and
          # list the directory contents, if there is one.
          current_dirs=( *(N/) )
          for i in {1..${#current_dirs}}; do
              if [[ $current_dirs[$i] != $old_dirs[$i] ]]; then
                  cd $current_dirs[$i]
                  ls
                  break
              fi
          done
        }

      alias ex=extract_archive
      compdef '_files -g "*.gz *.tgz *.bz2 *.tbz *.zip *.rar *.tar *.lha"' extract_archive
# }}}
    # backup file with date.backup {{{
      bu () { sudo cp $1 ${1}-`date +%Y%m%d%H%M`.backup ;}
# }}}
    # cp with progress bar {{{
      # Method #1
          # packet «strace» required
            cp_p()
            {
               strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
                  | awk '{
                    count += $NF
                        if (count % 10 == 0) {
                           percent = count / total_size * 100
                           printf "%3d%% [", percent
                           for (i=0;i<=percent;i++)
                              printf "="
                           printf ">"
                           for (i=percent;i<100;i++)
                              printf " "
                           printf "]\r"
                        }
                     }
                     END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
            }
      # Method #2
          # packet «pv» required
            cp_p2() 
            { 
               if [ `echo "$2" | grep ".*\/$"` ]; then 
                      pv "$1" > "$2""$1"; 
               else pv "$1" > "$2"/"$1"; 
               fi  ;     
            }
# }}}
