#!/bin/sh
# script to install the tools i use in my desktop env

if ! type "paru" > /dev/null; then
    echo "Install paru first!"
    echo "# git clone https://aur.archlinux.org/paru.git"
    echo "# cd paru"
    echo "# makepkg -si"
    exit 1
fi

apps=(
    #"acpilight"                        # backlight control for thinkpad t14
    #"base-devel"                       # base-devel
    "alacritty"                        # my terminal of choice
    "arandr"                           # xrandr gui
    "aws-cli-v2-bin"                   # cli for aws v2
    "azote"                            # Wallpaper & color manager for wlroots-based compositors
    "bat"                              # cat clone with syntax highlighting and Git integration
    "bitwarden-cli"                    # command line vault
    "blueman"                          # bluetooth manager
    "bluez-utils"                      # bluetooth dev/debug tools
    "brave-bin"                        # safer browsing
    "btop"                             # btop++
    "chafa"                            # character art facsimile generator
    "chezmoi"                          # manages my dotfiles and ssh keys
    "cliphist"                         # wayland clipboard manager
    "ctags"                            # generate tag files for source code
    "curl"                             # transfer a url
    #"dive-bin"                         # explore docker layers
    "dnsutils"                         # dnsutils like dig, host etc.
    "downgrade"                        # downgrade arch linux packages
    "duf"                              # disk usage/free utility
    "dunst"                            # Customizable and lightweight notification-daemon
    "eksctl"                           # cli for creating clusters on amazon eks
    "exa"                              # colored ls
    "exodus"                           # bitcoin wallet
    "fd"                               # "find" for files
    "flameshot-git"                    # screenshot tool
    "foliate"                          # ebook reader
    "fzf"                              # command-line fuzzy finder
    "git"                              # git
    "github-cli"                       # yep, github cli
    "git-lfs"                          # git large files in Git repositories
    "grim"                             # Screenshot utility for Wayland
    "gtk-engines"                      # theme engines for GTK+ 2
    "gtk-engine-murrine"               # murrina engine
    "helm"                             # helm for k8s
    "htop"                             # hipster top
    "httpie"                           # human-friendly CLI HTTP for the API era
    "hyperland"                        # a highly customizable dynamic tiling Wayland compositor
    "hypridle"                         # hyprland’s idle daemon
    "hyprlock"                         # hyprland’s GPU-accelerated screen locking utility
    #"hypnotix"                         # iptv app
    "jq"                               # jq cli
    "jwt-cli"                          # decode/encode JWTs
    "neovim"                           # ditched vim for neovim
    "k9s"                              # view/manage k8s clusters
    "kitty"                            # kitty terminal
    "krew-bin"                         # package manager for kubectl plugins
    "kubectl"                          # kubectl
    "kubectx"                          # kubectx
    "lazygit"                          # simple terminal UI for git commands
    "light-locker"                     # screen locker
    "lscolors-git"                     # colored shell
    "lxappearance"                     # lxappearance
    "manjaro-pipewire"                 # manjaro pipewire meta package for pipewire support
    "mtr"                              # traceroute and ping
    "ncdu"                             # disk space info (a better du)
    "neovim"                           # vim fork improved
    "networkmanager-dmenu-git"         # networkmanger using dmenu and rofi
    "networkmanager-openconnect"       # networkmanager vpn plugin for openconnect
    "nitrogen"                         # nitrogen wallpaper manager
    "nmap"                             # nmap - network discovery / portscan
    "openbsd-netcat"                   # TCP/IP swiss army knife
    "nvm"                              # node version manager
    "nwg-look"                         #  GTK3 settings editor adapted to work on wlroots-based compositors
    "pamixer"                          # pulseaudio command line mixer
    #"pavucontrol"                      # pulseaudio vol control
    "picom-git"                        # composito
    "playerctl"                        # playerctl
    "plex-desktop"                     # plex desktop client
    "podman"                           # simple management tool for pods, containers and images
    "prometheus-node-exporter"         # Exporter for machine metrics
    "python-pipenv"                    # manage python virtualenvs
    "python-pyotp"                     # python otp lib for aegis-decrypt
    "python-qrcode"                    # python qr code lib for aegis-decrypt
    "qt5ct"                            # qt5ct
    "qt6ct"                            # qt6ct
    "rclone"                           # manage files on cloud storage
    "ripgrep"                          # recursive search on steroids
    "ristretto"                        # picture viewer
    "rofi"                             # app launcher
    "rtkit"                            # realtime policy and watchdog daemon control
    #"seahorse"                         # manage PGP keys
    "signal-desktop"                   # signal messenger
    "sipcalc"                          # subnetting calculator
    "slack-desktop"                    # slack
    "slurp"                            # Select a region in a Wayland compositor
    #"sof-firmware"                     # Sound Open firmare for thinkapd t14
    "spotify"                          # spotify
    "sslscan"                          # sslscan tool to determine supported ciphers
    "starship"                         # starship prompt
    "step-cli"                         # plumbing for distributed systems
    "syncthing"                        # continuous replication / cluster synchronization thing
    "tailscale"                        # mesh vpn
    "thunar"                           # file manager
    "thunar-volman"                    # file manager removable devices
    "tumbler"                          # file manager - thumbnail previews
    "unrar"                            # unrar
    "unzip"                            # unzip
    "v4l-utils"                        # userspace tools for video 4 linux
    "visual-studio-code-bin"           # VS Code
    "waybar-cava-git"                  # waybar with cava support
    "whois"                            # whois
    "wireguard-tools"                  # secure network tunnel - tools
    "wl-clipboard"                     # Command-line copy/paste utilities for Wayland
    "xclip"                            # clipboard
    "xdg-desktop-portal-hyprland"      # xdg-desktop-portal backend for hyprland
    "xdg-user-dirs"                # xdg-user-dirs
    "xdg-utils"                        # xdg-utils
    #"xfce4-power-manager"              # xfce power manager

    # fonts
    "noto-fonts"                       # google noto ttf fonts
    "noto-fonts-emoji"                 # google noto ttf fonts emoji characters
    "ttf-fira-code"                    # fira code font
)

counter=0
echo "Installing apps..."
for app in "${apps[@]}"; do
    #echo "$app"
    counter=$((counter+1))
    paru -Qi $app | grep ^Name || yes | paru --skipreview -S $app
done
echo "$counter apps installed"

echo "Running xdg-user-dirs-update..."
xdg-user-dirs-update

# fonts
echo "Installing fonts..."

#echo "Iosevka Regular"
#test -f "${HOME}/.local/share/fonts/Iosevka Nerd Font Complete.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete.ttf -P ~/.local/share/fonts/

#echo "Iosevka Regular Mono"
#test -f "${HOME}/.local/share/fonts/Iosevka Nerd Font Complete Mono.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/

echo "IosevkaNerdFont-Regular.ttf"
test -f "${HOME}/.local/share/fonts/IosevkaNerdFont-Regular.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/IosevkaNerdFont-Regular.ttf -P ~/.local/share/fonts/

echo "SauceCodeProNerdFontMono-Italic.ttf"
test -f "${HOME}/.local/share/fonts/SauceCodeProNerdFontMono-Italic.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFontMono-Italic.ttf -P ~/.local/share/fonts/

echo "SauceCodeProNerdFontMono-Regular.ttf"
test -f "${HOME}/.local/share/fonts/SauceCodeProNerdFontMono-Regular.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFontMono-Regular.ttf -P ~/.local/share/fonts/

echo "SauceCodeProNerdFontMono-SemiBold.ttf"
test -f "${HOME}/.local/share/fonts/SauceCodeProNerdFontMono-SemiBold.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFontMono-SemiBold.ttf -P ~/.local/share/fonts/

echo "SauceCodeProNerdFontMono-SemiBoldItalic.ttf"
test -f "${HOME}/.local/share/fonts/SauceCodeProNerdFontMono-SemiBoldItalic.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/SauceCodeProNerdFontMono-SemiBoldItalic.ttf -P ~/.local/share/fonts/

#echo "Source Code Pro (SauceCodePro) Semibold Italic"
#test -f "${HOME}/.local/share/fonts/Sauce Code Pro Semibold Italic Nerd Font Complete Mono.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold-Italic/complete/Sauce%20Code%20Pro%20Semibold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/

#echo "Source Code Pro (SauceCodePro) Semibold Mono"
#test -f "${HOME}/.local/share/fonts/Sauce Code Pro Semibold Nerd Font Complete Mono.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/

echo "Installing (hypr)cursor"

test -d "${HOME}/.local/share/icons/BreezeX-RosePine-Linux" || wget https://github.com/rose-pine/cursor/releases/download/v1.1.0/BreezeX-RosePine-Linux.tar.xz -P ~/.local/share/icons/
test -d "${HOME}/.local/share/icons/BreezeX-RosePine-Linux" || tar -xvf ~/.local/share/icons/BreezeX-RosePine-Linux.tar.xz -C ~/.local/share/icons
rm -f "${HOME}/.local/share/icons/BreezeX-RosePine-Linux.tar.xz"

test -d "${HOME}/.local/share/icons/rose-pine-hyprcursor" || wget https://github.com/ndom91/rose-pine-hyprcursor/releases/download/v0.3.2/rose-pine-cursor-hyprcursor_0.3.2.tar.gz -P ~/.local/share/icons/
test -d "${HOME}/.local/share/icons/rose-pine-hyprcursor" || mkdir -p ~/.local/share/icons/rose-pine-hyprcursor
test -f "${HOME}/.local/share/icons/rose-pine-hyprcursor/manifest.hl" || tar zxvf ~/.local/share/icons/rose-pine-cursor-hyprcursor_0.3.2.tar.gz -C ~/.local/share/icons/rose-pine-hyprcursor
rm -f ~/.local/share/icons/rose-pine-cursor-hyprcursor_0.3.2.tar.gz
