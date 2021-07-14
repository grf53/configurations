alias ls='ls -G'
alias subl='open -a Sublime\ Text.app'
alias code='open -a Visual\ Studio\ Code.app'
alias finder='open -a Finder.app'
alias .bash_profile='subl ~/.bash_profile'
alias gitgraphconfig="git config --global alias.graph 'log --all --decorate --oneline --graph'"

export DEVELOPMENT=~/Documents/Development
export GITHUB=~/Documents/GitHub
export ANDROID_WORKSPACE=$DEVELOPMENT/AndroidWorkspace
export ANDROID_SDK_HOME=$ANDROID_WORKSPACE/android-sdks
export PYTHON_WORKSPACE=$DEVELOPMENT/PythonWorkspace
export VENV_HOME=$PYTHON_WORKSPACE/venv_home

export MAVEN_HOME=$DEVELOPMENT/apache-maven-3.1.1
export ADB_HOME=$ANDROID_SDK_HOME/platform-tools
export GRADLE_HOME=$DEVELOPMENT/gradle-4.5.1

export PATH=$ADB_HOME:$MAVEN_HOME/bin:$VERTX_HOME/bin:$GRADLE_HOME/bin:$PATH

export PATH=/usr/local/opt/openssl@1.1/bin:$PATH


workon_venv(){
    if [[ $# -eq 0 ]]; then
        ls $VENV_HOME
    elif [[ $# -eq 1 ]]; then
        source $VENV_HOME/$1/bin/activate
    fi
}
alias workon=workon_venv

export GOROOT=/usr/local/go
export GOPATH=$DEVELOPMENT/go

export PATH=$GOROOT/bin:$PATH

alias cddevelopment='cd $DEVELOPMENT/'
alias cdgithub='cd $GITHUB/'
alias cdandroid='cd $ANDROID_WORKSPACE/'
alias cdpython='cd $PYTHON_WORKSPACE/'
alias cdgolang='cd $GOPATH/'

# from transfer.sh
transfer(){ if [ $# -eq 0 ];then printf "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>\n">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip";(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;printf "\n";}
