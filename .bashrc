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

else
  alias ls='ls --color'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  #alias pbcopy='xsel --clipboard --input'
  #alias pbpaste='xsel --clipboard --output'

  # mainly for ref...cause i'll never remember this
  alias batstat='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

  # systemd :/
  alias journalctl='journalctl --no-pager'

  # java
  export JAVA_OPTS="-Xmx4g -Dhttp.nonProxyHosts='localhost|127.*|[::1]' -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8080 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=8080"
fi

# EXPORTS
export no_proxy=localhost,127.0.0.1,169.254.169.254
#export http_proxy=127.0.0.1:8080
#export https_proxy=127.0.0.1:8080
export HISTSIZE=-1
export HISTFILESIZE=-1
#export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%Y%m%d %T "
export PS1="[\u@\h \w]\$ "
export EDITOR=vim
export XOA_URL=op://range/XOA/website
export XOA_USER=op://range/XOA/username
export XOA_PASSWORD=op://range/XOA/password
export ANSIBLE_XO_HOST=op://range/XOA/host
export ANSIBLE_XO_USER=op://range/XOA/username
export ANSIBLE_XO_PASSWORD=op://range/XOA/password
export VAULT_ADDR=op://range/vault/website
export RESTIC_REPOSITORY=op://range/restic/repo
export RESTIC_PASSWORD=op://range/restic/password
export BORG_REPO=op://range/borg/repo
export BORG_PASSPHRASE=op://range/borg/password

# aws s3
export AWS_ACCESS_KEY_ID="op://Private/qxg732dw7hp6nqgj5ufffmmzyq/access key id"
export AWS_SECRET_ACCESS_KEY="op://Private/qxg732dw7hp6nqgj5ufffmmzyq/secret access key"

# backblaze-b2
# replication is crazy slow via s3-compatible API, and i'm not sure about their whole
# lifecycle policy they're doing as i turned it off, (keep only last file) and it's still versioning!
#export AWS_ACCESS_KEY_ID="op://Private/cloq7txxk2k4ymrbgjfaqkyywe/access key id"
#export AWS_SECRET_ACCESS_KEY="op://Private/cloq7txxk2k4ymrbgjfaqkyywe/secret access key"
# actually replication is fuct using their API too ¯\_(ツ)_/¯
export B2_ACCOUNT_ID="op://Private/cloq7txxk2k4ymrbgjfaqkyywe/access key id"
export B2_ACCOUNT_KEY="op://Private/cloq7txxk2k4ymrbgjfaqkyywe/secret access key"


# ALIASES
alias rebash='source $HOME/.bashrc'
alias cisco='screen /dev/tty.usbserial-* 9600'
alias nc='nc -v'
alias traceroute='traceroute -I'
alias mkdir='mkdir -p'
alias gl='git log --show-signature'
alias gco='git checkout'
alias gb='git branch'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcom='git checkout master'
alias ga='git add'
alias gaa='git add --all .'
alias gs='git status'
alias gsho='git show --show-signature'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git pull --rebase'
alias gca='git add . && git commit -v'
alias gca!='git add . && git commit --amend --no-edit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gp!='git push'
alias yoda='git push --force --all'
alias ma='mutt_oauth2.py -av ${HOME}/.mutt/mutt_oauth2.tokens'
alias m='mutt'
alias burp="java -Djsse.enableSNIExtension=false -jar -Xmx4096m ${HOME}/bin/burp.jar"
alias burp2="java -Djsse.enableSNIExtension=true -jar -Xmx4096m ${HOME}/bin/burp.jar"
alias xmr="monero-wallet-cli --config-file ${HOME}/.bitmonero/monero-wallet-cli.conf --wallet-file"
alias shrug='echo -n ¯\\_\(ツ\)_/¯ | pbcopy'
alias tableflip='echo -n \(╯°□°\)╯︵ ┻━┻ | pbcopy'
alias ansible='op run --no-masking -- ansible'
alias ansible-playbook='op run --no-masking -- ansible-playbook'
alias ap='ansible-playbook'
alias vault='op run --no-masking -- vault'
alias tf='op run --no-masking -- terraform'
alias tfa='op run --no-masking -- terraform apply'
alias restic='op run --no-masking -- restic'
alias borg='op run --no-masking -- borg --iec'
alias aws='op run --no-masking -- aws'

#maven
export MAVEN_OPTS="${JAVA_OPTS}"

#ruby
export RBENV_ROOT=${HOME}/.rbenv

#python
export PYENV_ROOT=${HOME}/.pyenv

#go
export GOPATH=${HOME}
export GOPROXY=direct

#########
# PATHs #
#########
export PATH=${HOME}/bin:\
${HOME}/.local/bin:\
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

##1p-cli
#export OP_HOME=${HOME}/.config/op
#if [ -f "${OP_HOME}/plugins.sh" ]; then
#  source ${OP_HOME}/plugins.sh
#fi

# docker rmi -f $(docker images -f "dangling=true" -q)
#export PATH="/usr/local/opt/openssl@1.1/bin:$PATH
#e0f
