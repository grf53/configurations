alias .bashrc='vim ~/.bashrc'
alias .bash_aliases='vim ~/.bash_aliases'
alias .zshrc='vim ~/.zshrc'

alias danglings='docker images -q -f "dangling=true"'
alias rmidanglings='docker rmi $(danglings)'

alias dockviz='docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t'

docker_rmi(){
  if [ $1 == "rmi" ] && [ $# -eq 2 ]; then
    if ! docker $* ; then
      docker rmi $(docker images --filter=reference=$2 --format "{{.Repository}}:{{.Tag}}" | sort -u)
    fi
  else
    docker $*
  fi
}
alias docker=docker_rmi


# transfer.sh
transfer(){ if [ $# -eq 0 ];then printf "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>\n">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip";(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;printf "\n";}
