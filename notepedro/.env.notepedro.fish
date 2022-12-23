alias nix-develop="nix develop -c fish"
alias infinity="appimage-run $HOME/Applications/Appimages/InfinityWallet-2.1.5.AppImage"
alias personal="podman run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias dpersonal="docker run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias rebuild="sudo nixos-rebuild switch --flake .#notepedro"
alias pd=podman
alias pdc=podman-compose
alias dev="nix-shell -p nodejs go python3 sumneko-lua-language-server --run fish"
