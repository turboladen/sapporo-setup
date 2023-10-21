#!/bin/bash

# https://github.com/hyprwm/Hyprland/discussions/284
sudo dnf install ninja-build \
	cmake \
	meson \
	gcc-c++ \
	libxcb-devel \
	libX11-devel \
	pixman-devel \
	wayland-protocols-devel \
	cairo-devel \
	pango-devel

# https://github.com/hyprwm/Hyprland/discussions/284#discussioncomment-3113786
sudo dnf install wayland-devel \
	libdrm-devel \
	libxkbcommon-devel \
	systemd-devel \
	libseat-devel \
	mesa-libEGL-devel \
	libinput-devel \
	xcb-util-wm-devel \
	xorg-x11-server-Xwayland-devel \
	mesa-libgbm-devel \
	xcb-util-renderutil-devel

git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland && sudo make install
sudo cp build/Hyprland /usr/bin/
sudo cp hyprctl/hyprctl /usr/bin/

# Didn't try it, but this might be better?
# https://github.com/s1n7ax/notes/blob/main/Linux/Fedora/Fedora%2038%20Hyprland%20Build%20%26%20Install.md

#╭─────────────────╮
#│ Display manager │
#╰─────────────────╯
dnf copr enable erikreider/SwayNotificationCenter
sudo dnf install alacritty greetd tuigreet swayidel swaylock SwayNotificationCenter
sudo systemctl set-default graphical.target

# ╭──────╮
# │ rofi │
# ╰──────╯
sudo dnf install rofi-wayland
mkdir ~/.config/rofi/
rofi -dump-config > ~/.config/rofi/config.rasi

# ╭─────────────╮
# │ # 1password │
# ╰─────────────╯
# sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
# sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
# sudo dnf install 1password

# https://1password.community/discussion/comment/631807/#Comment_631807
curl -sSO https://downloads.1password.com/linux/tar/beta/aarch64/1password-latest.tar.gz
tar -zxvf 1password-latest.tar.gz
sudo mkdir -p /opt/1Password
sudo mv 1password-*/* /opt/1Password
sudo /opt/1Password/after-install.sh

sudo cp /opt/1Password/resources/1password.desktop /usr/share/applications/
sudo cp icons/hicolor/64x64/apps/1password.png /usr/share/icons/hicolor/64x64/apps/
sudo cp icons/hicolor/512x512/apps/1password.png /usr/share/icons/hicolor/512x512/apps/
sudo cp icons/hicolor/32x32/apps/1password.png /usr/share/icons/hicolor/32x32/apps/
sudo cp icons/hicolor/256x256/apps/1password.png /usr/share/icons/hicolor/256x256/apps/

#  ╭──────╮
#  │ Rust │
#  ╰──────╯
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# ╭──────────────────╮
# │ CLI, basic tools │
# ╰──────────────────╯
dnf copr enable atim/starship
sudo dnf install bat eza fastfetch firefox gh htop ripgrep starship thunar zoxide
cargo install cargo-update topgrade zr

# This installs to /usr/share/zsh-syntax-highlighting/
sudo dnf install zsh-syntax-highlighting zsh-autosuggestions

#  ╭───────────────────╮
#  │ Editor, LSP tools │
#  ╰───────────────────╯
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit neovim openssl tmux tree-sitter-cli yamllint
cargo install bacon
cargo install deno
cargo install just
cargo install taplo-cli --features lsp
# Use nvim's LspInstall to install remaining LSPs

#  ╭────────╮
#  │ neovim │
#  ╰────────╯


#  ╭──────╮
#  │ Ruby │
#  ╰──────╯
cd ~/packages/
wget https://github.com/postmodern/chruby/releases/download/v0.3.9/chruby-0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo scripts/setup.sh

cd ~/packages/
wget https://github.com/postmodern/ruby-install/releases/download/v0.9.2/ruby-install-0.9.2.tar.gz
tar -xzvf ruby-install-0.9.2.tar.gz
cd ruby-install-0.9.2/
sudo make install

ruby-install 3 -- --enable-shared
