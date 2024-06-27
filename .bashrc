# .bashrc

# get system type
system_type=$(uname -s)

# User specific aliases and functions

# disable beeps
#setterm -blength 0
#xset b off

# disable flow control so ctrl+s fwd searches
if [ -z "$PS1" ]; then
  # non-interactive
  :
else
  #interactive
  stty -ixon
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# system specifics
if [ "$system_type" = "Darwin" ]; then
  alias ls='ls -G'
  alias sha256sum='shasum -a 256'
  alias sha512sum='shasum -a 512'
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

  #java
  export JAVA_HOME=$(/usr/libexec/java_home > /dev/null 2>&1)
  export JAVA_OPTS="-Xmx4g"

  #vmware
  export OVFTOOL_HOME="/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool"
    
  #hashicorp
  export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

  #1p-cli
  export OP_HOME=${HOME}/.config/op
  if [ -d "${OP_HOME}" ]; then
    source ${OP_HOME}/plugins.sh
  fi
else
  alias ls='ls --color'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  #alias pbcopy='xsel --clipboard --input'
  #alias pbpaste='xsel --clipboard --output'

  # java
  export JAVA_OPTS="-Xmx4g -Dhttp.nonProxyHosts='localhost|127.*|[::1]' -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8080 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=8080"
fi

# EXPORTS
export no_proxy=localhost,127.0.0.1,169.254.169.254
#export http_proxy=127.0.0.1:8080
#export https_proxy=127.0.0.1:8080
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y%m%d %T "
export HISTCONTROL=ignorespace
export PS1="[\u@\h \w]\$ "
export EDITOR=vim
export XOA_URL=op://range/XOA/website
export XOA_USER=op://range/XOA/username
export XOA_PASSWORD=op://range/XOA/password
export ANSIBLE_XO_HOST=op://range/XOA/host
export ANSIBLE_XO_USER=op://range/XOA/username
export ANSIBLE_XO_PASSWORD=op://range/XOA/password

# ALIASES
alias rebash='source $HOME/.bashrc'
alias cisco='screen /dev/tty.usbserial-* 9600'
alias nc='nc -v'
alias traceroute='traceroute -I'
alias mkdir='mkdir -p'
alias gl='git log'
alias gco='git checkout'
alias gb='git branch'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcom='git checkout master'
alias ga='git add'
alias gaa='git add --all .'
alias gs='git status'
alias gsho='git show'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git pull --rebase'
alias gca='git commit -a'
alias gca!='git add . && git commit --amend --no-edit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gp!='git push'
alias yoda='git push --force'
alias burp="java -Djsse.enableSNIExtension=false -jar -Xmx4096m ${HOME}/bin/burp.jar"
alias burp2="java -Djsse.enableSNIExtension=true -jar -Xmx4096m ${HOME}/bin/burp.jar"
alias xmr="monero-wallet-cli --config-file ${HOME}/.monero-wallet-cli.conf --wallet-file"

#maven
export MAVEN_OPTS="${JAVA_OPTS}"

#ruby
export RBENV_ROOT=${HOME}/.rbenv

#python
export PYENV_ROOT=${HOME}/.pyenv

#go
export GOPATH=${HOME}/src/golang

#########
# PATHs #
#########
export PATH=${HOME}/.local/bin:\
${RBENV_ROOT}/bin:\
${PYENV_ROOT}/bin:\
${GOPATH}/bin:\
${JAVA_HOME}/bin:\
/sbin:\
/usr/sbin:\
/usr/local/sbin:\
${PATH}

export MANPATH=${HOME}/man:\
${JAVA_HOME}/man:\
${MANPATH}

export LD_LIBRARY_PATH=${HOME}/lib:\
${JAVA_HOME}/lib:\
${LD_LIBRARY_PATH}

if [ -d "${RBENV_ROOT}" ] ; then
  eval "$(rbenv init -)"
fi

if [ -d "${PYENV_ROOT}" ] ; then
  eval "$(pyenv init -)"
fi

if [ -d "${OVFTOOL_HOME}" ]; then
    export PATH=${PATH}:${OVFTOOL_HOME}
  fi

# docker rmi -f $(docker images -f "dangling=true" -q)
#export PATH="/usr/local/opt/openssl@1.1/bin:$PATH
#e0f
