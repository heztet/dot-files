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
    export PS1="\[\e]0;\w\a\]\n\d \@ \[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\[\e[36m\]\$(parse_git_branch)\[\e[0m\]\n\$ "
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
    
    # Repeat the previous command with sudo
    alias fuck='sudo $(fc -ln -1)'

    # Various 'ls'
    # Don't edit ls in case of bash scriptping
    alias ll="ls -lhpG"
    alias l="ll"
    alias la="ls -lhAp"
    alias lh="ls -dhp .*" # hidden files only

    # ls for non-macOS
    if [ "$(uname)" != "Darwin" ]; then
        # GNU version of ls
        alias ls='ls -F --color=tty -B'
    fi

    # Edit .bashrc or .vimrc
    alias bashrc='vim ~/.bashrc'
    alias vimrc='vim ~/.vimrc'
    alias brc='bashrc'
    alias vrc='vimrc'

    # Load .bashrc
    alias loadbrc='. ~/.bashrc'
    alias lbrc='loadbrc'

    # Copy files to dot-files
    alias commitdots='echo "Dot files copied to ~/dot-files" && cp ~/.gitconfig ~/dot-files/.gitconfig && cp ~/.bashrc ~/dot-files/.bashrc && cp ~/.vimrc ~/dot-files/.vimrc && cp ~/.bash_profile ~/dot-files/.bash_profile && cp ~/.tmux.conf ~/dot-files/.tmux.conf'
    # Push dot files to home directory
    alias loaddots='echo "~/dot-files copied to ~" && cp ~/dot-files/.gitconfig ~/.gitconfig && cp ~/dot-files/.bashrc ~/.bashrc && cp ~/dot-files/.vimrc ~/.vimrc && cp ~/dot-files/.bash_profile ~/.bash_profile && . ~/.bashrc && cp -r ~/dot-files/vim/* ~/.vim/. && cp ~/dot-files/.tmux.conf ~/.tmux.conf'

    alias cdots='commitdots'
    alias ldots='loaddots'

    alias dirs="dirs -v"

    # Go backwards 'n' times
    function ddn() { for i in `seq $1`; do cd ..; done; }

    # tmux
    alias t='tmux'

    # Open octave
    alias o='octave'

    # Python
    alias p='python3'
    alias p2='python'

    # Jupyter notebook
    alias jn='jupyter notebook'

    # GCC/Valgrind
    alias gcc='gcc -Werror -Wall -Wshadow'
    alias valgrind='valgrind --leak-check=full'
    alias v='valgrind'

    # Why is kubectl so many letters?
    alias k='kubectl'

    # Add local bin to PATH
    export PATH=$PATH:~/.local/bin

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

    # whence
    alias whence='type -a'
    # prints description of a command (i.e., alias, location, etc.) -a means to
    # print all of the places that contain an executable matching the argument

    # Up arrow to search history
    # Credit: 'user287613' @ http://askubuntu.com/a/475614 - License: CC-BY-SA-3.0
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'

    # macOS specific setup
    if [ "$(uname)" == "Darwin" ]; then
        # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
        export PATH="$PATH:$HOME/.rvm/bin"

        # Add /usr/local/bin to PATH
        export PATH="$PATH:/usr/local/bin"

        # Use pyenv for Python versioning
        # Note: To set python and python3, use "pyenv [global|local] 2.7.x 3.x.x"
        export PATH="$PATH:$HOME/.pyenv/bin"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi
fi


# vim: set tabstop=4 shiftwidth=4 fileencoding=utf8 expandtab filetype=sh:
