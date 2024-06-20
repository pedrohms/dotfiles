set -U fish_user_paths $fish_user_paths /home/framework/Applications/android-studio/bin /home/framework/go/bin
# set JAVA_HOME "/usr/lib/jvm/java-21-openjdk-21.0.3.0.9-1.fc40.x86_64"
set FlakeHub "$HOME/Projects/nix"
alias personal="podman run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias dpersonal="docker run --rm -it --name teste -v personal:/root -v $PWD:/data pedrohms/gpg /bin/sh"
alias ndev="nix develop github:pedrohms/flake-develop -c fish"
alias ndev-php="nix develop github:pedrohms/flake-develop#php -c fish"
alias ndev-jdk="nix develop github:pedrohms/flake-develop#jdk -c fish"
alias ndev-node="nix develop github:pedrohms/flake-develop#nodejs -c fish"
alias ndev-bun="nix develop github:pedrohms/flake-develop#bun -c fish"
alias ndev-gcc="nix develop github:pedrohms/flake-develop#gcc -c fish"
alias cp_flake_develop="curl -o flake.nix https://gist.githubusercontent.com/pedrohms/32bd53267885999f33f8f9b5cd60bb47/raw/04cdef82fe25569e54c3bfc7a898cf9a80097b81/flake.nix"
alias mk=minikube
alias pd=podman
alias pdc=podman-compose
alias albiononline="flatpak run com.albiononline.AlbionOnline"
alias jump="cd (ghq list -p | fzf -1 -e)"
# alias runescape="flatpak run com.jagex.RuneScape"
alias oldrunescape="flatpak run dev.hdos.HDOS"
alias runelite="flatpak run net.runelite.RuneLite"
alias docker="podman"
alias docker-compose="podman-compose"
