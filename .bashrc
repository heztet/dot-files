# Make all files that you create private by default (i.e., not readable,
# writable, or executable by other users on the system).
umask 077

if [[ $- =~ "i" ]]; then  # If this is an interactive session...
    # Put git branch in prompt
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }

    ######################################################################
    # PROMPT FORMAT
    #
    # Make your bash prompt show your current directory in color.
    # Credit:  Cygwin, license: GPL, from the default .bashrc that comes with Cygwin
    export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\[\e[36m\]\$(parse_git_branch)\[\e[0m\]\n\$ "
    export PS2='> '
    export PS4='+ '
    # To learn more about these codes, see:
    # http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html ...
    #
    # DESKTOP LINUX FIXES
    # 256 color
    if [ "$TERM" = xterm ]; then TERM=xterm-256color; fi 
    # Vim as default editor
    export VISUAL=vim
    export EDITOR="$VISUAL"

    ######################################################################
    # Personal Functions/Aliases
    ######################################################################

    alias home='cd ~'
    alias h='home'
    alias quit='exit'
    alias q='quit'
    alias vi='vim'
    alias c='clear'
    alias ..='cd ..'
    alias lh='ls -d .*' # hidden files only

    # Various 'ls'
    alias l='ll'
    alias la='ls -la'

    # Edit .bashrc or .vimrc
    alias bashrc='vim ~/.bashrc'
    alias vimrc='vim ~/.vimrc'
    alias brc='bashrc'
    alias vrc='vimrc'

    # Load .bashrc
    alias loadbrc='. ~/.bashrc'
    alias lbrc='loadbrc'

    # Copy files to dot-files
    alias copydots='cp ~/.gitconfig ~/dot-files/.gitconfig && cp ~/.bashrc ~/dot-files/.bashrc && cp ~/.vimrc ~/dot-files/.vimrc && cp ~/.bash_profile ~/dot-files/.bash_profile'
    # Push dot files to home directory
    alias setdots='cp ~/dot-files/.gitconfig ~/.gitconfig && cp ~/dot-files/.bashrc ~/.bashrc && cp ~/dot-files/.vimrc ~/.vimrc && cp ~/dot-files/.bash_profile ~/.bash_profile && . ~/.bashrc && cp ~/dot-files/vim-colorschemes/* ~/.vim/colors/'

    # Go backwards 'n' times
    function cdn() { for i in `seq $1`; do cd ..; done; }

    # Open octave
    alias o='octave'

    # Python 3
    alias p='python3'

    # GCC/Valgrind
    alias gcc='gcc -Werror -Wall -Wshadow'
    alias valgrind='valgrind --leak-check=full'
    alias v='valgrind'

    # mcd
    function mcd() {
        # Make a directory and then change to it.  This will be used like an alias.
        mkdir $1
        cd $1
    }

    # less
    alias less='less -r'
    # -r = --raw-control-chars .. means to display raw characters instead of
    # showing ^M, ^R, etc.

    # rm
    alias rm='rm'

    # whence
    alias whence='type -a'
    # prints description of a command (i.e., alias, location, etc.) -a means to
    # print all of the places that contain an executable matching the argument

    # ls
    if [ "${BASH_VERSINFO[5]}" == "x86_64-apple-darwin10.0" ]; then
        # Mac version of ls -- useful only if you copy this .bashrc to a Mac.
        alias ls='ls -G -p'
    else
        # GNU version of ls
        alias ls='ls -F --color=tty -B'
    fi

    # ll
    alias ll='ls -l'
    # -l = use long listing format

    # Up arrow to search history
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    # Credit: 'user287613' @ http://askubuntu.com/a/475614 - License: CC-BY-SA-3.0

    # gdb core file maintenance
    # Core dump c files if crash
    ulimit -c 2000 #unlimited
    # Remove core files in current directory
    alias rc='rm core.*'

    ######################################################################
    # ENGR 142 Functions/Aliases
    ######################################################################
    alias egcc='gcc -Wall -Werror -lm'
    alias rfai='cd /share/engr14x && python3 rfai.py'
    alias eagle='ssh marinon@eagle.ecn.purdue.edu'
    

fi
# vim: set tabstop=4 shiftwidth=4 fileencoding=utf8 expandtab filetype=sh:
