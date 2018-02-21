# If Windows/Cygwin, convert dot files to unix
if [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN32_NT" ]; then
	dos2unix ~/.bashrc
	dos2unix ~/.vimrc
fi

# Read and execute the commands in your .bashrc file.
source ~/.bashrc
