# ------------------------------------------------------
# file:     $HOME/.zshrc
# author:   luke
# modified: sam. 18 févr. 2012 15:20:47 CET 
# ------------------------------------------------------

#vi-mode test
yellow="%{[0;33m%}"

vim_ins_mode=">>>"
vim_cmd_mode="$yellow<<<"
vim_mode=$vim_ins_mode
function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select
function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish
setopt transient_rprompt




#source $HOME/.prompt
#white_time_single_prompt

# prompt zsh
autoload -U promptinit
promptinit
prompt fade blue

# return code: 0? si ok sinon affiche le code erreur %?
#PROMPT="%(0?. .<$c5%?>)${c1}[$c3%D{%H:%M:%S}$c1]$c1($c2%n$c1@$c2%m$c1)$c1($c2%~$c1)%#$normal "
#PROMPT=" $smiley${c1}[$c3%D{%H:%M:%S}$c1]$c1($c2%n$c1@$c2%m$c1)$c1($c2%~$c1)%#$normal "
RPROMPT='$vim_mode | %? | %#'


# Lines configured by zsh-newuser-install {{{
# --------------------------------------
  export  HISTFILE="${HOME}/.zsh_history"
  export HISTSIZE=50000
  export SAVEHIST=50000
  export LESSHISTFILE="-"
  export PAGER="less"
  export READNULLCMD="${PAGER}"
  export VISUAL="vim"
  export EDITOR="${VISUAL}"
  export BROWSER="dwb"
  export XTERM="urxvt"
  export JAVA_FONTS=/usr/share/fonts/TTF
  export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'
    # }}}

# Options {{{
# -------
    setopt extended_glob             # Extended glob 
    setopt interactive_comments      # Allow comments in shells
    setopt auto_cd                   # Change directory magic
    setopt complete_in_word          # 
    setopt no_beep                   # Don't beep on errors
    setopt hist_ignore_all_dups      #
    setopt hist_ignore_space         #
    setopt hist_reduce_blanks        # Remove blanks from history
    setopt hist_verify
    setopt correct_all               # Command correction in a line
    setopt promptsubst               
    #setopt no_clobber                # Don't overwrite files when redirect
    setopt always_to_end             # when complete from middle, move cursor setopt notify 
    setopt completealiases
    unsetopt beep                    # no beep
    #unsetopt clobber                 # zsh n'écrit pas dans un fichier non vide avec > (redirection)
    setopt hist_ignore_dups          # ne stocke pas une ligne dans l'historique si elle est identique à la précédente
    setopt hist_find_no_dups         # la recherche dans l'historique avec zsh ne montre pas une même ligre plus d'une fois, même si elle a été enregistrée

    # for rtorrent Ctrl Q : quit
    # for ^q (quit)
    stty stop undef
    # for ^s (start)
    stty start undef
    # for ^d (delete)
    # no good for screen
    #stty eof undef
    # }}}

# Completion {{{
# ----------
    zstyle ':completion:*' menu select
    zstyle :compinstall filename '$HOME/.zshrc'
    autoload -Uz compinit # activation completion 1/2
    compinit                # activation completion 2/2
    autoload -U incremental-complete-word
    zmodload zsh/complist 
    zstyle ':completion::complete:*' use-cache 1
    zstyle ':completion::complete:*' cache-path $HOME/.zshcache
    zstyle ':completion:*:*:kill:*' menu yes select
    zstyle ':completion:*:kill:*' force-list always
    zstyle ':completion:*:*:killall:*' menu yes select
    zstyle ':completion:*:killall:*'   force-list always

    zstyle ':completion:*:mv*'   force-list always

    zstyle ':completion:*:pacman:*' force-list always
    zstyle ':completion:*:*:pacman:*' menu yes select
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*:cd:*' ignore-parents parent pwd
    zstyle ':completion:*' completer _complete _match _approximate
    zstyle ':completion:*:match:*' original only
    zstyle ':completion:*:approximate:*' max-errors 1 numeric
# --- ubuntu
    zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
    zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
    zstyle ':completion:*' menu select=2
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%
    zstyle ':completion:*:rm:*' ignore-line yes
    zstyle ':completion:*:mv:*' ignore-line yes
    zstyle ':completion:*:cp:*' ignore-line yes
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# --- debian
    zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'$
    zstyle ':completion:*' max-errors 3 numeric$
    zstyle ':completion:*' use-compctl false
    # }}}

# Include local directories {{{
# --- http://stackoverflow.com/questions/171563/whats-in-your-zshrc
if [[ -r ~/.localdirs ]]; then
        source ~/.localdirs
fi

# Git, zsh completion
source /usr/share/git/completion/git-completio.zsh

# }}}

# {{{ Awesome, problem with Java
_JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARENTING
#}}}

# {{{ Alias et Export luke
alias pow='sudo poweroff'
# edit uzbl config
alias vim='nocorrect vim'
alias sudo='nocorrect sudo'
alias uc='vim ~/.config/uzbl/config'
export lus='/home/luke/.local/share/uzbl/scripts/'
export luu='/home/luke/.local/share/uzbl/userstyles/'

# ps cpu top 5
alias pscpu='clear;echo " ps cpu top 5 :";ps -eo pid,ppid,pcpu,pmem,vsz,args,user,tty | sort -k3n,3n |tail -5'
# ps mem top 5
alias psmem='clear;echo " ps mem top 5 :";ps -eo pid,ppid,pcpu,pmem,vsz,args,user,tty | sort -k4n,4n |tail -5'

# jeux Oil rush
alias oil='cd ~/oilrush/OilRush-1.02 && ./launcher_x64.sh'
#mount/umount cdrom dans /media/cdrom /media/cdrom'
alias mountcd='sudo mount -t iso9660 /dev/cdrom /media/cdrom'
alias umountcd='sudo umount /media/cdrom'

# pour torrent dans ~/dl/rtorrent et ~/dl/rtorrent/dl_ok
alias dlr='cd ~/dl/rtorrent'
alias dlro='cd ~/dl/rtorrent/dl_ok'
# clear & lt (list history)
alias clt="clear && ls -ltr"
# alias restart Privoxy et Polipo
alias ppon='sudo rc.d restart privoxy && sudo rc.d restart polipo'
export aw="$HOME/.config/awesome"
# ping sans Ctrl C pour l'arrêt
alias ping='ping -c 3'
# ps2pdf : transforme les pdf en réduisant la taille
alias ps2pdf='ps2pdf -sPAPERSIZE=a4 -dOptimize=true -dEmbedAllFonts=true $1 $2'
# jdownloader
alias ,j='jdownloader'
# blank-rename & minus
alias bm='blank-rename && minus'
# ps memory The Top 10 Memory Consuming Process
alias ps_mem='ps -auxf | sort -nr -k 4 | head -10'
# ps cpy The Top 10 CPU consuming Process
alias ps_cpu='ps -auxf | sort -nr -k 3 | head -10'

# saidar info tools
alias saidar='saidar -c -d 1'

# T° de la carte graphique
alias temp="nvidia-smi -q -d TEMPERATURE"

# uzbl le navigateur
# Copie des scripts de /usr/share/uzbl/examples/data/scripts/util/*.sh en ~/.config/uzbl/util
# et définition ici par export de la variable $UZBL_UTIL_DIR

# tty-clock
alias tty-clock='tty-clock -sctC4'
# urxvt en daemon
alias urxvt="urxvtc"

# copy with a progress bar. {{{
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
# }}}

function vim {
        LIMIT=$#
        for ((i = 1; i <= $LIMIT; i++ )) do
                eval file="\$$i"
                if [[ -e $file && ! -O $file ]]
                then
                        otherfile=1
                else

                fi
        done
        if [[ $otherfile = 1 ]]
        then
                clear
                echo 
                echo " root enable !!"
                echo 
                echo " root enable !!"
                echo 
                echo " root enable !!"
                command sudo vim "$@"
        else
                command vim "$@"
        fi
}
# }}}

# --- wiki.gcu.info ==> navigateur {{{
  autoload -U pick-web-browser
  zstyle ':mime:*' x-browsers uzbl-tabbed firefox elinks
  alias -s html=pick-web-browser
  # }}}

# Fonction interne {{{
# ---------------
  autoload -U zfinit zcalc zargs zmv         # activation fct interne 1/2
  zfinit                      # activation fct interne 2/2
  autoload zcalc
  #    zcalc : une calculatrice (plus besoin de bc ou autres expr)
  #    zargs : un super xargs
  #    zmv : une commande permettant de faire du renommage/déplaçage en masse de fichiers.
  #    }}}

# # Cope (colorize quelques fonctions : ps, md5sum, xrandr, [/usr/share/perl5/vendor_perl/auto/share/dist/:::]) {{{
# # ---------------
# OLDPATH=$PATH
# export PATH=/home/luke/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/qt/bin
# export PATH=/usr/share/perl5/vendor_perl/auto/share/dist/Cope/:$PATH
# }}}

# source custom colors: {{{
# --------------------
    # le fichier manuel
    eval $(dircolors -b ${HOME}/.dircolors)
    # et là le packet "dircolors-solarized-git"
    #eval $(dircolors -b /etc/dir_colors)
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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

#     # {{{ vi-mode
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select
# 
# # terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
# # function zle-line-init zle-keymap-select {
# #     PS1_2="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
# #     PS1="%{$terminfo_down_sc$PS1_2$terminfo[rc]%}%~ %# "
# #     zle reset-prompt
# # }
# # preexec () { print -rn -- $terminfo[el]; }
# #}}}

# autojump {{{
# --------
  source /etc/profile
  export AUTOJUMP_IGNORE_CASE=1
  export AUTOJUMP_KEEP_ALL_ENTRIES=1
  export AUTOJUMP_KEEP_SYMLINKS=1
  # }}}

# newsgroup avec slrn {{{
  NNTPSERVER='news.free.fr' && export NNTPSERVER
  # }}}

# alias xclip
alias pbcopy='xclip -selection clipboard'       # copy to the clipboard, ctrl+c, ctrl+shift+c
alias pbpaste='xclip -selection clipboard -o'   # paste from clipboard, ctrl+v, ctrl+shift+v
alias pbselect='xclip -selection primary -o'    # paste from highlight, middle click, shift+insert
# fonctions {{{
# Usage: show-archive <archive>
# Description: view archive without unpack
show-archive() {
 if [ -f $1 ]; then
       case $1 in
       *.tar.bz2)     tar -jtf $1 ;;
       *.tar.gz)      tar -ztf $1 ;;
       *.tar)         tar -tf $1  ;;
       *.tgz)         tar -ztf $1 ;;
       *.zip)         unzip -l $1 ;;
       *.rar)         rar vb $1   ;;
       *)             echo "'$1' Error. Please go away" ;;
       esac
       else
       echo "'$1' is not a valid archive"
fi
}

# luke
# cool mais perd le prompt du départ
#
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select
# 
# terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
# function zle-line-init zle-keymap-select {
#     PS1_2="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     PS1="%{$terminfo_down_sc$PS1_2$terminfo[rc]%}%~ %# "
#     zle reset-prompt
# }
# preexec () { print -rn -- $terminfo[el]; }
# }}}

# divers {{{
  alias merge='sudo xrdb -merge ~/.Xdefaults'
  alias vimXd='vim /home/luke/.Xdefaults'
  alias sz='source ~/.zshrc'
  alias vz='vim ~/.zshrc'
  alias dulocal='sudo du -sh /media/freebox/;sudo du -sh /media/sdb1/; du -s ~/;du -s ~/.jdownloader/downloads'
# .config/awesome
  alias aw='~/.config/awesome'
# yaourt
  alias yy='yaourt'
# comix
  alias -s cbr="mcomix"
# alias executable
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
  #alias -s pdf="xpdf"
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

# export /media/c/freebox/Vidéos
  export cv=/media/c/vidéos
  export fv=/media/freebox/Vidéos
  export fvf=/media/freebox/Vidéos/Family
  export fvc=/media/freebox/Vidéos/cc
  export f=/media/freebox
  export jd=/home/luke/.jdownloader/downloads
  export bitt=$HOME/dl/qbittorrent

  alias rsync='rsync --progress -h -r'

  export LESS="-R"

# ----------------------------
# quake - édition autoexec.cfg
# ----------------------------
  alias vimq='vim ~/.q3a/baseq3/autoexec.cfg'

# chromium avec privoxy
  alias chromiump='chromium --proxy-server="127.0.0.1:8118"'
# vimprobable2
# définition du proxy
#export http_proxy=http://127.0.0.1:8118
# pyLoad !!
  alias pyload='pyLoadCore'
  alias pyloadcli='pyLoadCli'

# Confirmation avant d'écraser
  alias rm='rm -i'
  alias mv='mv -i'
  alias cp='cp -i'

# pratique
  alias cls='c;ls'
  alias c='clear'
  alias less='less --quiet'
  alias df='df --human-readable'
  alias du='du --human-readable'
  alias md='mkdir'
  alias rd='rmdir'

# place ou pas ?
  alias dfhome='df -h | grep home'
#arrêt programmé, format 24h : $1=14:30
  alias halttime='sudo shutdown -rh $1'

# Archlinux
  alias syu='yaourt -Syu'
  alias s='yaourt -Syu'
  alias sss='yaourt -Ss $1'

# Pour le réseau ethernet up & down
  alias down='sudo ifconfig eth0 down'
  alias up='sudo ifconfig eth0 up'

  alias xterm='xterm -geometry 100x20+400+600'

  alias ll='ls -l --color'
  alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'
  alias lx='ls -lXB'          # sort by eXtension
  alias lk='ls -lSrh'         # sort by size 'k'o
  alias la='ls -Al'           # show hidden files
  alias lr='ls -lR | less'    # recursive ls
  alias lt='ls -ltr'          # sort by date 't'ime
  alias lm='ls -al | less'    # less better than more
  # alias tree='tre -Cs'        # nice alternative to 'ls'
  alias tree='tree -ifs --noreport .|sort -n -k2'
  alias l='ls -hF --color'    # quick listing
  alias lsize='ls --sort=size l-hr'   # list by size
  # alias lsd='ll | grep 'drw''       # list only directories
  alias lsd='lt -ld *(/)'
# close Awesome, quit Services (udiskie, mpd and umount Freebox)
  # freebox n'est plus mounté par awesome > x ne marchait plus donc je le dégage
  # alias x='sudo killall mpd && sudo umount /media/freebox && sudo shutdown -h now'
  alias x='sudo umount -a ; sudo poweroff'
  alias lll="ls -la --color | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[ rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"
# les 10 plus gros fichiers/répertoires du réperoitre en cours
  alias topten='blank-rename;du -skh $(/bin/ls -A) | sort -rn | head -10'
##  alias h='history' 
  alias hig='cat ~/.zsh_history | grep $1' # Recherche historique $1
  alias grep='grep --color=always'

# réseau
  alias ifdown='sudo ifconfig eth0 down'
  alias ifup='sudo ifconfig eth0 up'
  # alias ip='print ${${$(LC_ALL=C /sbin/ifconfig eth0)[8]}:gs/addr://}'
  # alias ip='ifconfig|grep 192.168.1.|cut -c14-42'
  alias ipnet='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'

# console
  alias ZZ='exit'
  alias :q='exit'
  alias :q!='exit'

# le temps d'aller chercher les sauvegardes
  alias cs='cd /media/c/0/sauvegarde/pc_bureau/sauve_home/luke'

# remettre la résolution d'écran normal après Quake
  alias 0='echo "rate 75";xrandr --output VGA-1 --mode 1600x1200 --rate 75 --pos 0x0 --rotate normal --output DVI-I-1 --off --output HDMI-1 --off'
  alias 1='echo " rate 85";xrandr --output VGA-1 --mode 1600x1200 --rate 85 --pos 0x0 --rotate normal --output DVI-I-1 --off --output HDMI-1 --off'

# Go rép. ~/dl
  alias dl='cd ~/dl'

# configuration des périphériques de saisie
  alias vimedev='sudo vim /etc/X11/xorg.conf.d/10-evdev.conf'

# dd
  alias goa='cd /media/a && ls'
  alias goc='cd /media/c && ls'

# les dvdrip
  alias avi='ll | grep avi$ --color'

# pour awesome
  alias vimrclua='vim ~/.config/awesome/rc.lua'
  alias vimrcconf='sudo vim /etc/rc.conf'


# ZMV see http://grml.org/zsh/zsh-lovers.html
  autoload zmv
  zmren_arg=''(*)$1(*)' '${1}$2${2}''
  alias zmvren='zmv zmvren_arg'
  # }}}

# functions {{{
# ---------

function wp(){
  dig +short txt $1.wp.dg.cx
  }

function translate(){
  wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$1&sl=auto&tl=fr" | sed 's/\[\[\[\"//' | cut -d \" -f 1}

function extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.rar)       rar e $1   ;;
      *.tar.bz2)   tar xjf $1 ;;
      *.tar.gz)    tar xzf $1 ;;
      *.bz2)       bunzip2 $1 ;;
      *.gz)        gunzip $1  ;;
      *.tar)       tar xf $1  ;;
      *.tbz2)      tar xjf $1 ;;
      *.tgz)       tar xzf $1 ;;
      *.zip)       unzip $1   ;;
      *.Z)         uncompress $1  ;;
      *)           echo "x() can't work out what to do with '$1'" ;;
    esac
    else
     echo "'$1' is not a valid file, dumbass"
  fi
  }

# backup file with date.backup
  bu () { sudo cp $1 ${1}-`date +%Y%m%d%H%M`.backup ;}


# cp with progress bar
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

spin ()
{
    echo -ne "${RED}-"
    echo -ne "${WHITE}\b|"
    echo -ne "${BLUE}\bx"
    sleep .02
    echo -ne "${RED}\b+${NC}"
}

spin2 ()
{
    echo -ne "${RED}-"
    echo -ne "${WHITE}\b|"
    echo -ne "${BLUE}\bx"
    sleep .01
    echo -ne "${RED}\b+${NC}"
}
# }}}

# {{{ Pacman
alias pacsy="sudo pacman -Sy"               # Sync & Update
alias pacup="sudo pacman -Syu"              # Sync, Update & Upgrade
alias pacdg="sudo pacman -Syuu"             # Sync, Update & Downgrade
alias paclu="pacman -Qu"                    # List upgradeable
alias pacin="sudo pacman -S"                # Install a specific package
alias pacnd="sudo pacman -Sdd"              # Install a package but ignore deps
alias pacrm="sudo pacman -Rns"              # Remove a specific package
alias pacrd="sudo pacman -Rdd"              # Remove a package but ignore deps
alias pacss="pacman -Ss"                    # Search for a package
alias pacsl="pacman -Qs"                    # Search for a package localy
alias pacsi="pacman -Si"                    # Package info
alias pacqi="pacman -Qi"                    # Package local info
alias pacls="pacman -Ql"                    # List files in a package
alias pacui="pacman -Qm"                    # List localy built packages
alias pacfi="pacman -Qo"                    # Which package file belongs to
alias paccl="sudo pacman -Scc"              # Fully clean the package cache
alias pacdl="sudo pacman -Sw"               # Download a package without installing
alias paclo="pacman -Qdt"                   # List package orphans
alias paclog="pacman -Qc"                   # Package changelog
# # }}}

# {{{ Manual pages
#     - colorize, since man-db fails to do so
export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'       # end mode
export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'       # end underline
export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline
# }}}
#
# test
