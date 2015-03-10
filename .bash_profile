
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin
export PATH=$PATH:~/tools
export ANDROID_HOME=/Users/arpit/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

# GRADLE STUFF #

function upfind() {
  dir=`pwd`
  while [ "$dir" != "/" ]; do
    p=`find "$dir" -maxdepth 1 -name $1`
    if [ ! -z $p ]; then
      echo "$p"
      return
    fi
    dir=`dirname "$dir"`
  done
}

function gw() {
  GW="$(upfind gradlew)"
  if [ -z "$GW" ]; then
    echo "Gradle wrapper not found."
  else
    $GW --configure-on-demand --profile --parallel $@
  fi
}
alias gcb="gw clean build"
alias gb="gw build"
alias gt="gw test"

## END GRADLE STUFF ##

## MARK ##
# See http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html

export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}
