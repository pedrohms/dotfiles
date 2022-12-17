set -U fish_user_paths $fish_user_paths /home/framework/Applications/android-studio/bin
alias personal="docker run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
