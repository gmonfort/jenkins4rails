if [[ -n "$PS1" ]]; then
	PS1='\[\033[01;30m\][ \[\033[01;31m\]\u \[\033[01;30m\]]\[\033[01;34m\]\w\[\033[00m\]\$ '
	eval "`dircolors -b`"
	if [ -f ~/.bash_aliases ]; then
	    . ~/.bash_aliases
	fi
fi

xhost +LOCAL:

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
