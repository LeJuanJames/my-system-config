#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#function to automate installation of aur packages.
function aurinstall() {
	#Check if valid git repo
	if git-remote-url-reachable "$1"; then
		cd ~;
		git clone https://aur.archlinux.org/$1.git && cd $1 &&
		makepkg -si --noconfirm || echo "Installation Failed! No packages were installed.";
	else 
		echo "No such AUR package exists!";
	fi
}

git-remote-url-reachable() {
      git ls-remote "https://aur.archlinux.org/$1.git" CHECK_GIT_REMOTE_URL_REACHABILITY >/dev/null 2>&1
  }

function jv() {
	javac $1.java && java $1 $2 $3; #add $2 and $3 if given to add params to running java program
}

function go() {
	if [[ $1 != school ]]; then
	
		cd "/run/media/juancena5599/D4F2-7026/Stupid Java Stuff" 2>/dev/null || echo 'USB not inserted, unable to change directory!'; 
	else
		cd "/run/media/juancena5599/D4F2-7026/CSA/5" 2>/dev/null || echo 'USB not inserted, unable to change directory!';
	
	fi
}



function newjava() {
	if [[ $PWD != "/run/media/juancena5599/D4F2-7026/CSA/5" ]]; then 
		cd "/run/media/juancena5599/D4F2-7026/CSA/5" 2>/dev/null && touch $1.java || touch $1.java 
		else
		#if already in usb simply create file
		touch $1.java;
	fi
	truncate -s 0 $1.java;

	#for school, add header text and ignore imports
	if [[ $2 = 'school' ]]; then
		current="`date +%D`" #get date and time %D forces mm/dd/yy format
		echo "/**" >> $1.java &&
		echo " * class $1" >> $1.java &&
		echo " * Author1:  Juan Couchenour" >> $1.java &&
		echo " * Date:     $current" >> $1.java &&
		echo " * Course:   Computer Science I AP" >> $1.java &&
		echo " * Period:   3rd" >> $1.java && 
		echo " * " >> $1.java &&
		echo " * Summary of file:" >> $1.java &&
		echo " * " >> $1.java &&
		echo " * " >> $1.java &&
		echo " * " >> $1.java &&
		echo " */" >> $1.java;
	else 
		echo "import java.util.*;" >> $1.java &&
		echo "import java.io.*;" >> $1.java &&
		echo "import static java.lang.Math.*;" >> $1.java;
	fi

	#GUI program, import all standard GUI imports
	if [[ $2 = 'gui' ]]; then
		echo "import javax.swing.*;" >> $1.java &&
		echo "import java.awt.event.*;" >> $1.java &&
		echo "import java.awt.*;" >> $1.java &&
		echo "import static javax.swing.JOptionPane.*;" >> $1.java;
	fi
		echo "  " >> $1.java && echo "  " >> $1.java && 
		echo "public class $1 {" >> $1.java &&
		echo "	public static void main(String [] args ) {" >> $1.java &&
		echo ' ' >> $1.java && echo '	}' >> $1.java &&  
		echo "}" >> $1.java 

		#open in sublime & close terminal. 
		/home/juancena5599/sublime-text-4/src/sublime_text/sublime_text $1.java && bash -c "sleep 10" & disown -ah && exit;
	
}

#function to run c++ programs
function cpp() {
	g++ $1 && ./a.out;
}

alias ls="ls -A --color=always";
alias sus="chafa /home/juancena5599/sus.jpg";
alias internet="ping www.google.com -c 5";
alias tux="chafa /home/juancena5599/tux.jpg";
alias back="alacritty && zsh -c \"sleep 10\" & disown -ah && exit";
alias remove="sudo eject /dev/sda1";
alias vi="vim $1";
alias fastfetch="hyfetch -b fastfetch";
alias sublime="/home/juancena5599/sublime-text-4/src/sublime_text/sublime_text $1";
alias cls="clear && fastfetch";
alias wiki="firefox https://wiki.archlinux.org && zsh -c \"sleep 10\" & disown -ah && exit";
alias aur="firefox https://aur.archlinux.org && zsh -c \"sleep 10\" & disown -ah && exit";
alias bye="poweroff";
alias null=":";
alias sso="firefox https://launchpad.classlink.com/conroeisd && zsh -c \"sleep 10\" & disown -ah && exit";
