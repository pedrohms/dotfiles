set -U fish_user_paths $fish_user_paths /home/framework/Applications/android-studio/bin /home/framework/go/bin
alias personal="podman run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias dpersonal="docker run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias dev="nix develop github:pedrohms/flake-develop -c fish"
alias dev-php="nix develop github:pedrohms/flake-develop#php -c fish"
alias dev-jdk="nix develop github:pedrohms/flake-develop#jdk -c fish"
alias dev-node="nix develop github:pedrohms/flake-develop#nodejs -c fish"
alias dev-bun="nix develop github:pedrohms/flake-develop#bun -c fish"
alias nix-dev="nix develop -c fish"
alias cp_flake_develop="curl -o flake.nix https://gist.githubusercontent.com/pedrohms/32bd53267885999f33f8f9b5cd60bb47/raw/04cdef82fe25569e54c3bfc7a898cf9a80097b81/flake.nix"
alias mk=minikube
alias pd=podman
alias pdc=podman-compose
alias albiononline="flatpak run com.albiononline.AlbionOnline"
alias jump="cd (ghq list -p | fzf -1 -e)"
alias runescape="flatpak run com.jagex.RuneScape"
alias oldrunescape="flatpak run dev.hdos.HDOS"
alias runelite="flatpak run net.runelite.RuneLite"
