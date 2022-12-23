set -U fish_user_paths $fish_user_paths /home/framework/Applications/android-studio/bin
alias personal="podman run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias dpersonal="docker run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias dev="nix-shell -p nodejs go python3 sumneko-lua-language-server --run fish"
alias mk=minikube
alias pd=podman
alias pdc=podman-compose
