#!/bin/env bash

#function for dependency check
dep_ch() {
	for dep; do
		if ! command -v "$dep" >/dev/null; then
			terminate_script "Program \"$dep\" not found. Please install it."
		fi
	done
}

# display error message in red to stderr
error() {
	printf "\33[2k\r\033[1;31m%s\033[0m\n" "$*" >&2
}

# display an informational message (first argument in green, second in magenta)
inf() {
	printf "\33[2K\r\033[1;35m%s \033[1;35m%s\033[0m\n" "$1" "$2"
}

#function to terminate script if error occur
terminate_script() {
	error "$*"
	exit 1
}

#provide dependency (space seperated)
dep_ch "gcc" "cmake" || true

CURRENT_DIR="$(pwd)"
NEOVIM_DIR="$HOME/.config/nvim/neovim"

#checks if neovim directory already exists
[ ! -d "$NEOVIM_DIR" ] || rm -rf "$NEOVIM_DIR"

# make a choice for build type
inf "" "Please choose a build type"

#cloning latest neovim from official repo
git clone https://github.com/neovim/neovim.git "$NEOVIM_DIR"
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

#checks for file existance
[ -e /usr/local/bin/nvim ] && sudo rm -f /usr/local/bin/nvim
[ -e /usr/local/share/nvim/ ] && sudo rm -rf /usr/local/share/nvim/

cd "$NEOVIM_DIR" 2>/dev/null || terminate_script "Error: neovim directory not found exiting script ..."

make CMAKE_BUILD_TYPE="Release"

sudo make install
cd "$CURRENT_DIR" || terminate_script "Error: not able to change directory to \"$CURRENT_DIR\""
rm -rf "$NEOVIM_DIR"

rm -Rf ~/.config/nvim
cp -Rf $CURRENT_DIR/nvim_config/ ~/.config/nvim/

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c "TSUpdateSync" -c qall
nvim --headless -c "MasonInstall prettier phpcbf astro-language-server bash-language-server clangd css-lsp delve dockerfile-language-server emmet-ls eslint-lsp gopls html-lsp java-debug-adapter java-test jdtls js-debug-adapter json-lsp kotlin-language-server lemminx lua-language-server node-debug2-adapter phpactor phpcs pyright rust-analyzer solidity solidity-ls svelte-language-server tailwindcss-language-server typescript-language-server vue-language-server yaml-language-server" -c qall
