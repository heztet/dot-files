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

    ######################################################################
    # ENGR 142 Functions/Aliases
    ######################################################################
    alias egcc='gcc -Wall -Werror -lm'

    ######################################################################
    # ECE 368 Functions/Aliases
    ######################################################################
    
    alias gcc='gcc -Werror -Wall -Wshadow -O3'

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

    # Copy .bashrc and .vimrc to 264 folder
    alias copyrc='cp ~/.bashrc ~/264/bashrc.backup && cp ~/.vimrc ~/264/vimrc.backup'

    ## Jump to homework folder
    #function gg() {
    #    # "" -> 264/
    #    if [ $# -eq 0 ]; then # No input args
    #        cd ~/264/
    #    # "ez" -> Submit
    #    elif [ "$1" = "ez" ]; then
    #        264submit ${PWD##*/} *.c *.txt *.h
    #    # "t" -> Test
    #    elif [ "$1" = "t" ]; then
    #        264test ${PWD##*/}
    #    # "l" -> 264/lectures
    #    elif [ "$1" = "l" ]; then
    #        cd ~/264/lectures
    #    # "h" -> 264/honors
    #    elif [ "$1" = "h" ]; then
    #        cd ~/264/honors
    #    # Anything else -> 264/hw<arg>
    #    else
    #        cd ~/264/hw$1
    #    fi
    #}

    ### Homework Aliases
    # Generic warmups
    alias compilew='gcc warmup.c -o warmup.o'
    alias runw='compilew && ./warmup.o'
    alias valw='compilew && valgrind ./warmup.o'
    alias gdbw='compilew && gdb ./warmup.o'

    # Honors
    alias compileh='gcc test_print_integer.c print_integer.c -o test_print_integer.o'
    alias runh='compileh && ./test_print_integer.o'
    alias valh='compileh && valgrind ./test_print_integer.o'
    alias gdbh='compileh && gdb ./test_print_integer.o'

    # HW 02
    alias testhw2='gcc -o hw02test hw02test.c hw02.c && ./hw02test | diff hw02test.txt -'

    # HW 03
    alias testhw4='gcc -o test_mintf.o test_mintf.c mintf.c && ./test_mintf.o | diff test_mintf.txt -'

    # HW 06
    alias testhw6='gcc -o test_smintf.o test_smintf.c smintf.c && ./test_smintf.o | diff -B expected.txt -'
    alias runhw6='gcc -o test_smintf.o test_smintf.c smintf.c && ./test_smintf.o'

    # HW 07
    alias testhw7='gcc -o test_team.o test_team.c team.c && ./test_team.o | diff -B expected.txt -'
    alias runhw7='gcc -o test_team.o test_team.c team.c && ./test_team.o'
    alias submithw7='264submit hw07 team.c team.h test_team.c warmup.c expected.txt'

    # HW 08
    alias warmup8='gcc -o warmup.o warmup.c && ./warmup.o'
    alias testwarmup8='warmup8 && val8'
    alias testhw8='gcc -o test_team.o test_team.c team.c && ./test_team.o | diff -B expected.txt -'
    alias itesthw8='gcc -o instructor_test_team.o instructor_test_team.c team.c && ./instructor_test_team.o | diff instructor_expected.txt -'
    alias runhw8='gcc -o test_team.o test_team.c team.c && ./test_team.o'
    alias valhw8='gcc -o test_team.o test_team.c team.c && valgrind ./test_team.o'
    alias ivalhw8='gcc -o instructor_test_team.o instructor_test_team.c team.c && valgrind ./instructor_test_team.o'
    alias gdbhw8='gcc -o test_team.o test_team.c team.c && gdb ./test_team.o'
    alias submithw8='264submit hw08 team.c team.h test_team.c expected.txt warmup.c'

    # HW 09
    alias warmup9='gcc -o warmup.o warmup.c && ./warmup.o'
    alias testwarmup9='warmup9 && val9'
    alias testhw9='gcc -o test_team.o test_team.c team.c && ./test_team.o | diff -B expected.txt -'
    alias itesthw9='gcc -o instructor_test_team.o instructor_test_team.c team.c && ./instructor_test_team.o | diff instructor_expected.txt -'
    alias runhw9='gcc -o test_team.o test_team.c team.c && ./test_team.o'
    alias valhw9='gcc -o test_team.o test_team.c team.c && valgrind ./test_team.o'
    alias ivalhw9='gcc -o instructor_test_team.o instructor_test_team.c team.c && valgrind ./instructor_test_team.o'
    alias gdbhw9='gcc -o test_team.o test_team.c team.c && gdb ./test_team.o'
    alias submithw9='264submit hw09 team.c team.h test_team.c expected.txt warmup.c'

    # HW 10
    alias submithw10='264submit hw10 team.c team.h test_team.c expected.txt warmup.c'

    # HW 11
    alias compile11='gcc -o test_index.o test_index.c index.c'
    alias warmup11='gcc -o warmup.o warmup.c && ./warmup.o'
    alias submithw11='264submit hw11 warmup.c index.c index.h indexer.c test_index.c expected.txt'
    alias runhw11='gcc -o indexer.o index.c indexer.c && ./indexer.o'
    alias gdbhw11='runhw11 && gdb ./indexer.o'
    alias testhw11='compile11 && ./test_index.o | diff expected.txt -'
    alias valhw11='compile11 && valgrind ./test_index.o' 

    # HW 12
    alias compile12='gcc -o test_sorts.o test_sorts.c sorts.c'
    alias runhw12='compile12 && ./test_sorts.o'
    alias testhw12='compile12 && ./test_sorts.o | diff expected.txt -'
    alias valhw12='compile12 && valgrind ./test_sorts.o'
    alias submithw12='264submit hw12 sorts.c sorts.h test_sorts.c expected.txt'
    alias gdbhw12='compile12 && gdb ./test_sorts.o'

    # HW 13
    alias compile13='gcc test_bmp.c bmp.c -o test_bmp.o'
    alias out13='./test_bmp.o'
    alias runhw13='compile13 && out13'
    alias testhw13='compile13 && out13 | diff expected.txt -'
    alias valhw13='compile13 && valgrind ./test_bmp.o'
    alias gdbhw13='compile13 && gdb ./test_bmp.o'
    alias submithw13='264submit hw13 test_bmp.c bmp.c expected.txt warmup.c a.txt b.txt'

    # HW 14
    alias compile14='gcc -pthread test_mtat.c mtat.c bmp.c -o test_mtat.o'
    alias out14='./test_mtat.o'
    alias runhw14='compile14 && out14'
    alias testhw14='compile14 && out14 | diff expected.txt -'
    alias valhw14='compile14 && valgrind ./test_mtat.o'
    alias gdbhw14='compile14 && gdb ./test_mtat.o'
    alias submithw13='264submit hw14 test_mtat.c bmp.c bmp.h mtat.c mtat.h warmup.c expected.txt'
fi

# vim: set tabstop=4 shiftwidth=4 fileencoding=utf8 expandtab filetype=sh:
