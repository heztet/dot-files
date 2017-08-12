# Make all files that you create private by default (i.e., not readable,
# writable, or executable by other users on the system).
umask 077

if [[ $- =~ "i" ]]; then  # If this is an interactive session...
    # Put git branch in prompt
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }

    ######################################################################
    # ECE 264 Functions/Aliases
    ######################################################################
    
    ########### Instructor commands
        # Tell bash where to look when you type a command (e.g., '264get', etc.).
        export PATH="/opt/gcc/6.1.0/bin:/home/shay/a/ece264s0/16au/bin:$PATH"
        # alias gcc="gcc -std=c99 -g -Wall -Wshadow --pedantic -Wvla"
        # Tell bash to automatically add some standard arguments to gcc.  This ensures
        # that everyone in the class is compiling in the same way.
        # * --std=c99 means to use the C99 version of the C language.
        # * -g means to enable gdb by storing information such as your variable names
        #   in the executable
        # * -Wall, -Wshadow, --pedantic, and Wvla turn on extra warnings to let
        #   you know about anomolies in your code might indicate a bug.

        alias valgrind='valgrind --leak-check=full'
        # Tell bash to automatically add the --leak-check=full argument whenever you
        # type 'valgrind'.

        alias 264version_bashrc='echo "You have version 2 of the .bashrc for ECE 26400 Fall 2016.";echo;echo PATH=$PATH;echo;ls -l ~/.bashrc ~/.bash_profile ~/.vimrc'
    #####################################################################

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
    # ALIASES
    #

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
    alias setdots='cp ~/dot-files/.gitconfig ~/.gitconfig && cp ~/dot-files/.bashrc ~/.bashrc && cp ~/dot-files/.vimrc ~/.vimrc && cp ~/dot-files/.bash_profile ~/.bash_profile' 

    # Go backwards 'n' times
    function cdn() { for i in `seq $1`; do cd ..; done; }

    # Open octave
    alias o='octave'

    # Python 3
    alias p='python3'

    ######################################################################
    # ENGR 142 Functions/Aliases
    ######################################################################
    alias egcc='gcc -Wall -Werror -lm'
    alias rfai='cd /share/engr14x && python3 rfai.py'
    alias eagle='ssh marinon@eagle.ecn.purdue.edu'

    ######################################################################
    # ECE 368 Functions/Aliases
    ######################################################################
    alias gcc='gcc -Werror -Wall -Wshadow'
    alias valgrind='valgrind --leak-check=full'
    alias v='valgrind'

    # Jump to homework folder
    function gg() {
        # "" -> 368/
        if [ $# -eq 0 ]; then # No input args
            cd ~/368/
        # Anything else -> 368/hw<arg>
        else
            cd ~/368/hw$1
        fi
    }

fi
# vim: set tabstop=4 shiftwidth=4 fileencoding=utf8 expandtab filetype=sh:
