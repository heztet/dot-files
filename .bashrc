#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# .bashrc file for ECE 264 Fall 2016
#
# Author:   Alexander J. Quinn -- http://engineering.purdue.edu/~aq
# License:  Public domain (except where noted otherwise below)
#

#------------------------------------------------------------------------------
# In ECE 264 (Fall 2016), we are using an alternative installation of gcc on
# ecegrid.  This gives you gcc v6.1.0, which is quite a bit newer than the
# default, gcc v4.7.  We also use a bash alias to automatically fill in flags
# to gcc that will help you catch bugs.  By default, we turn all of this off
# after the semester, to avoid causing confusion with future classes.
#------------------------------------------------------------------------------


# Make all files that you create private by default (i.e., not readable,
# writable, or executable by other users on the system).
umask 077

if [[ $- =~ "i" ]]; then  # If this is an interactive session...
    ######################################################################
    # ECE 264
    #

    #export PATH="/opt/gcc/6.1.0/bin:$PATH:/home/shay/a/ece264s0/16au/bin"
    export PATH="/opt/gcc/6.1.0/bin:/home/shay/a/ece264s0/16au/bin:$PATH"
    # Tell bash where to look when you type a command (e.g., '264get', etc.).
    # * /home/shay/a/ece264p0/share/16au is where we put the ECE 264 scripts.
    # * $PATH is the list of paths that it would check otherwise.
    # * /opt/gcc/6.1.0/bin is where ECN has installed the latest version of gcc.

    alias gcc="gcc -std=c99 -g -Wall -Wshadow --pedantic -Wvla"
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


    ######################################################################
    # PROMPT FORMAT
    #
    # Make your bash prompt show your current directory in color.
    #
    # Credit:  Cygwin, license: GPL, from the default .bashrc that comes with Cygwin
    export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
    export PS2='> '
    export PS4='+ '
    # To learn more about these codes, see:
    # http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html ...


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
    # alias rm='rm -i'
    # -i = --interactive ... means to prompt before deleting any files, unless
    # -f is added

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

    ######################################################################
    # Personal Functions/Aliases
    ######################################################################

    # Vi -> vim
    alias vi='vim'

    # Clear screen
    alias c='clear'

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

    # Copy .bashrc and .vimrc to 264 folder
    alias copyrc='cp ~/.bashrc ~/264/bashrc.backup && cp ~/.vimrc ~/264/vimrc.backup'

    # Jump to homework folder
    function gg() {
        if [ $# -eq 0 ]; then # No input args
            pushd ~/264/
        else
            pushd ~/264/hw$1
        fi
    }

    # Jump to lectures folder
    alias ggl='pushd ~/264/lectures'

    ### Homework Aliases
    alias testhw2='gcc -o hw02test hw02test.c hw02.c && ./hw02test | diff hw02test.txt -'

    alias testhw4='gcc -o test_mintf.o test_mintf.c mintf.c && ./test_mintf.o | diff test_mintf.txt -'

    alias testhw6='gcc -o test_smintf.o test_smintf.c smintf.c && ./test_smintf.o | diff -B expected.txt -'
    alias runhw6='gcc -o test_smintf.o test_smintf.c smintf.c && ./test_smintf.o'

    alias testhw7='gcc -o test_team.o test_team.c team.c && ./test_team.o | diff -B expected.txt -'
    alias runhw7='gcc -o test_team.o test_team.c team.c && ./test_team.o'
    alias submithw7='264submit hw07 team.c team.h test_team.c warmup.c expected.txt'

    alias warmup8='gcc -o warmup.o warmup.c && ./warmup.o'
    alias testwarmup8='warmup8 && val8'
    alias testhw8='gcc -o test_team.o test_team.c team.c && ./test_team.o | diff -B expected.txt -'
    alias itesthw8='gcc -o instructor_test_team.o instructor_test_team.c team.c && ./instructor_test_team.o | diff instructor_expected.txt -'
    alias runhw8='gcc -o test_team.o test_team.c team.c && ./test_team.o'
    alias valhw8='gcc -o test_team.o test_team.c team.c && valgrind ./test_team.o'
    alias ivalhw8='gcc -o instructor_test_team.o instructor_test_team.c team.c && valgrind ./instructor_test_team.o'
    alias gdbhw8='gcc -o test_team.o test_team.c team.c && gdb ./test_team.o'
    alias submithw8='264submit hw08 team.c team.h test_team.c expected.txt warmup.c'

    alias warmup9='gcc -o warmup.o warmup.c && ./warmup.o'
    alias testwarmup9='warmup9 && val9'
    alias testhw9='gcc -o test_team.o test_team.c team.c && ./test_team.o | diff -B expected.txt -'
    alias itesthw9='gcc -o instructor_test_team.o instructor_test_team.c team.c && ./instructor_test_team.o | diff instructor_expected.txt -'
    alias runhw9='gcc -o test_team.o test_team.c team.c && ./test_team.o'
    alias valhw9='gcc -o test_team.o test_team.c team.c && valgrind ./test_team.o'
    alias ivalhw9='gcc -o instructor_test_team.o instructor_test_team.c team.c && valgrind ./instructor_test_team.o'
    alias gdbhw9='gcc -o test_team.o test_team.c team.c && gdb ./test_team.o'
    alias submithw9='264submit hw09 team.c team.h test_team.c expected.txt warmup.c'

    alias runtest='gcc -o test.o test.c && ./test.o'
fi

# vim: set tabstop=4 shiftwidth=4 fileencoding=utf8 expandtab filetype=sh:
