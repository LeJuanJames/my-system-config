# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mortalscumbag"
ENABLE_CORRECTION="true"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(zoxide init zsh)"
#function to automate installation of aur packages.
function aurinstall() {
	#Check if valid git repo
	
		cd ~;
		git clone https://aur.archlinux.org/$1.git  >/dev/null && cd $1 && git-remote-url-reachable && 
			makepkg -si --noconfirm || {cd ~ && rm -rf $1 && echo "Installation Failed! No packages were installed." && return 69};
	 
		#echo "No such AUR package exists!";
	
}

git-remote-url-reachable() {
      git log >/dev/null 2>&1
  }

function jv() {
	javac $1.java && java $@;
}

function go() {
	if [[ $1 != school ]]; then
	
		cd "/run/media/juancena5599/Hacks" 2>/dev/null || echo 'USB not inserted, unable to change directory!'; 
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
		echo " * class     $1" >> $1.java &&
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
		/home/juancena5599/sublime-text-4/src/sublime_text/sublime_text $1.java &!; exit;
	
}

alias cd=z
alias sudoedit="doas nvim";
alias ls="exa -a --icons";
alias sus="chafa /home/juancena5599/sus.jpg";
alias internet="ping www.google.com -c 5";
alias tux="chafa /home/juancena5599/tux.jpg";
alias back="alacritty &!; exit";
alias remove="sudo eject /dev/sda1";
alias fastfetch="hyfetch -b fastfetch";
alias sublime="/home/juancena5599/sublime-text-4/src/sublime_text/sublime_text $1";
alias cls="clear && fastfetch && echo 'Kill Me' && date";
alias wiki="brave https://wiki.archlinux.org &!; exit";
alias aur="brave https://aur.archlinux.org &!; exit";
alias bye="poweroff";
alias null=":";
alias sso="brave https://launchpad.classlink.com/conroeisd &!; exit";
alias packs="brave https://archlinux.org/packages/ &!; exit";
