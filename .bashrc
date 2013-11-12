alias eb="rm -f ~/.ABORT; exec bash"
[ -e "$HOME/.ABORT" ] && return
>"$HOME/.ABORT"
############################################################
[ -z "$PS1" ] && return
[ -e ~/.cddrc ] || touch ~/.cddrc
[ -e ~/.frc ] || touch ~/.frc
[ -e ~/.cdrc ] || echo $HOME > ~/.cdrc
[ -e ~/.filterwords ] || echo PASSWORD > ~/.filterwords

#export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Add the following lines to maven.sh
export M2_HOME=/opt/apache-maven-3.0.5
export M2=$M2_HOME/bin
PATH=$M2:$PATH 
export a b c d e f g h i j k l m n o p q r s t u v w x y z
export NODE_PATH="~/node_modules"
export CDPATH=".:~"
export PATH=~/bin:/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.0.x86_64/bin:/bin:/usr/bin:/usr/local/bin:~/local/bin:~/ThirdParty/android-sdk/tools:~/ThirdParty/android-sdk/platform-tools:~/ThirdParty/jdk1.7.0_07/bin:~/ThirdParty/node-v0.8.12-linux-x64/bin:$PATH
export JAVA_HOME="/usr/lib/jvm/java-1.6.0"
export ANT_HOME="/usr/share/ant"
export LC_COLLATE=C
export PYTHONPATH="$HOME/local:/usr/lib/python2.6:/usr/lib/pymodules:$HOME/local/lib/python2.6/site-packages"
#export PYTHONPATH="~/local:/usr/lib/python2.6:/usr/share/pyshared:/usr/lib/pyshared:/usr/lib/pymodules:~/local/lib/python2.6/site-packages"
export HISTSIZE=""
export GREP_OPTIONS='--color=auto'

# some aliases
alias a=alias
alias wu="line1;cat /etc/*-release;lsb_release -a;uname -a;cat /proc/version;line1"
alias ff="sudo find / -name"
alias ts="cd; ( sudo nohup /usr/bin/tracd -p 80 --basic-auth='MyProject,/home/ec2-user/projects/MyProject/.htpasswd,My Project' /home/ec2-user/projects/MyProject & ) ; cd -"
alias wp="sudo netstat -tulpn; sudo ps -ef"
alias lnm="ls ~/node_modules"
alias plan="vi ~/.plan;"
alias cj='cat *.json'
alias lj='less *.json'
alias g=git
alias ga="git add"
alias gt="git tag"
alias gc="git commit --allow-empty -a -m '';gpom"
alias gs="git status"
alias gpom="git push origin master"
alias dc=dotcloud
alias sg="sudo su git"
alias myip='echo `curl http://169.254.169.254/latest/meta-data/public-ipv4`'
alias dcl="dotcloud list"
alias dcc="dotcloud create"
alias dcp='EE=$PWD;dcr;dotcloud push;cd $EE'
alias dci='EE=$PWD;dcr;dotcloud info $(ys);dc info $(ydb); cd $EE'
alias dcd='EE=$PWD;dcr;dotcloud destroy -A $(app);cd $EE'
alias dca="EE=$PWD;dcr;json application < .dotcloud/config;cd $EE"
alias dcdb='EE=$PWD;dcr;dc run -A $(app) $(ydb) mongo;cd $EE'
alias dcsh='EE=$PWD;dcr;dc run -A $(app) $(ys);cd $EE'
alias app="json application < .dotcloud/config"
alias pw='dc info $(ydb) | grep mongodb_password: | awk "{print \$2}"'
alias .dc=". ~/.env/.dotcloud.env"
alias ua=unalias
alias us=unset
alias c8="cd *"
alias v8="vim *"
alias n8="node *.js"
alias l8="less *"
alias vi=vim
alias y='cat *.yml'
alias -- -="cd -;"
alias sx="svn ci -mz"
alias vf="vim ~/.filterwords"
alias p.="p=\`pwd\`"
alias f1="fg %1"
alias f2="fg %2"
alias f3="fg %3"
alias f4="fg %4"
alias f5="fg %5"
alias f6="fg %6"
alias f7="fg %7"
alias f8="fg %8"
alias f9="fg %9"
alias a="alias"
alias cd.='cd $_;l'
alias ccd="cdd"
alias cl="clear"
alias c="ccd"
alias ..="cd ..;"
alias ...="cd ../..;"
alias ....="cd ../../..;"
alias crc="./cruisecontrol.sh"
alias cs=csvn
alias e="cd ~;vi .vimrc;cd -"
alias h='history'
alias j=jobs
alias k1="kill -9 %1"
alias k2="kill -9 %2"
alias k3="kill -9 %3"
alias k4="kill -9 %4"
alias k5="kill -9 %5"
alias k6="kill -9 %6"
alias k7="kill -9 %7"
alias k8="kill -9 %8"
alias k9="sudo kill -9"
alias la='ls -A'
alias ll='ls -la --color --group-directories-first'
alias l='ls -CFxa --color --group-directories-first'
alias m="java mocha.Decompiler"
alias mn=makensis
alias .b='. ~/.bashrc'
alias b='vi ~/.bashrc;.b'
alias .p='. ~/.profile'
alias p='vi ~/.profile;.p'
alias pipi="pip install --install-option='--prefix=$HOME/local'"
alias pipu="pip uninstall"
alias v="fc -s 'vi '"
alias vr="vi README*" 
alias v.="vi $_"
alias x="chmod +x"
alias x.='chmod +x \$_'
alias find.="find . -name"
alias less="less -N"
alias q="vi ~/bin/.load_prerequisites"
alias s=store

#######################################################################

set -o vi

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

dcr () {
	while [ '$PWD' != "/" ] ; do if [ -d .dotcloud ] ; then return; else cd ..; fi; done
}

function cdd {
	if [ $# -lt 1 ]
	then
		cat ~/.cddrc |
			sed 's/export //;s/=/	/'
		return
	fi
	if [ $1 = v ]
	then 
		vi ~/.cddrc
		return
	fi
	if [ $# -eq 2 ]
	then 
		if [ -e "$1" ]
		then
			cd "$1"
			cdd "$2"
			return
		else
			return
		fi
	fi
	. ~/.cddrc
	_d="echo \$$1"
	_o="echo $( eval $_d )"
	r="$( eval $_o )"
	if [ -z "$r" ]
	then
		echo "export $1=`pwd`" >> ~/.cddrc
		tput setaf 1
		echo "exported \$$1 as `pwd`"
		tput setaf 9
		export "$1=`pwd`"
		return
	fi
	cd $r
	tput setaf 1
	echo ">>> $r"
	tput setaf 9
	l
}
. ~/.cddrc

function f {
    if [ $# = 0 ]
    then
        eval $( cat ~/.frc )
        return 0
    fi
    if [ -f "~/bin/$1" ]
    then 
        echo "vi ~/bin/$1" > ~/.frc
        vi "~/bin/$1"
    else 
        touch "~/bin/$1"
        chmod +x "~/bin/$1"
        echo "vi ~/bin/$1" > ~/.frc
        vi "~/bin/$1"
    fi
}


function sdkm {
  cd ~/ThirdParty/android-sdk
  java -Xmx256M -Dcom.android.sdkmanager.toolsdir=~/ThirdParty/android-sdk/tools -classpath ~/ThirdParty/android-sdk/tools/lib/sdkmanager.jar:~/ThirdParty/android-sdk/tools/lib/swtmenubar.jar:~/ThirdParty/android-sdk/tools/lib/x86_64/swt.jar com.android.sdkmanager.Main update sdk --no-ui
  cd -
}
PROMPT_COMMAND='export O=$?;[ ! $O = 0 ] && PS1="$USER:\W:$O> " || PS1="$USER:\W> ";history -a ; printf %s "$PWD" > ~/.cdrc'

shopt -s histappend
shopt -s cmdhist
export HISTIGNORE="&:ls:l:pwd:b:h:pp:v:p:cd:c:ccd:ll:[bf]g:exit"

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

if [ -e ~/.111 ]
then
	ZZ="$HOME/.111/*"
	UDIR=`basename $ZZ`
else
	UDIR=timsdb
	[ -d ~/timsdb ] || mkdir ~/timsdb
fi

function filt {
	sed "s#$LOGNAME#XXXXXXXX#gI" |
	sed 's#[i-n][aeiou][lnrst][a-e][aeiou][lmnprst]#XXXXXXXX#gI' |
	sed 's#google[A-Z./a-z0-9]*#XXXXXXXX#gI' |
	sed "s#$UDIR#XXXXXXXX#gI" 
}

function filt2 {
	sed "s#$LOGNAME#XXXXXXXX#gI" |
	sed 's#google[A-Z./a-z0-9]*#XXXXXXXX#gI' |
	sed "s#$(cat ~/.filterwords)#XXXXXXXX#gI"
}

function ys {
/usr/bin/python<<!!!
import yaml

f = open("dotcloud.yml","r")
b = yaml.load(f.read())
for bb in b:
	if b[bb]['type'] == 'nodejs':
		print bb
!!!
}

function ydb {
/usr/bin/python<<!!!
import yaml

f = open("dotcloud.yml","r")
b = yaml.load(f.read())
for bb in b:
	if b[bb]['type'] == 'mongodb':
		print bb
!!!
}


function line1 {
	for (( i=${#line} ; i<$width ; i++ )); do echo -n "_" ; done; echo ""
}
cd $( cat ~/.cdrc )

function store {
	HDIR="$PWD"
	ZT="$HOME/$UDIR"
	cd ~
	cp .bash_profile .bashrc .vimrc $ZT
	cp -r ~/bin/ $ZT
	cp ~/.env/.* $ZT/env 2>/dev/null
	filt < ~/.bash_history > $ZT/.bash_history.ref
	filt < ~/.cddrc > $ZT/.cddrc.ref
	cd "$ZT"
	git add .
	git commit -m "`date`"
	git push origin master
	cd $HDIR
}


function pp {
	curdir=$(pwd|sed s#$HOME#~#)
	width=$(tput cols)
	halfwid=$((($width-${#curdir})/2))
	echo;echo;echo;echo;echo
	if [ -e ~/.plan ]
	then
		line1
		echo
		tput setaf 4
		cat ~/.plan
		tput setaf 0
	fi
	line1
	echo
	tail  -20 ~/.bash_history
	line1
	echo
	for (( i=${#line} ; i<$halfwid ; i++ )); do echo -n " " ; done;
	echo "$(tput setaf 1;tput smul)$(echo $curdir|sed s#$HOME#~#)$(tput setaf 0;tput smul)"
	echo
	l
	line1
	echo
}

############################################################
trap 'store; exit' 0 15
############################################################
rm "$HOME/.ABORT" 
