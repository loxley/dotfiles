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
    #"base-devel"                       # base-devel
    "alacritty"                        # my terminal of choice
    "arandr"                           # xrandr gui
    "bat"                              # cat clone with syntax highlighting and Git integration
    "bitwarden-cli"                    # command line vault
    "blueman"                          # bluetooth manager
    "bluez-utils"                      # bluetooth dev/debug tools
    "brave-bin"                        # safer browsing
    "btop"                             # btop++
    "chezmoi"                          # manages my dotfiles and ssh keys
    "ctags"                            # generate tag files for source code
    "curl"                             # transfer a url
    "dive-bin"                         # explore docker layers
    "dnsutils"                         # dnsutils like dig, host etc.
    "duf"                              # disk usage/free utility
    "exa"                              # colored ls
    "fd"                               # "find" for files
    "flameshot"                        # screenshot tool
    "foliate"                          # ebook reader
    "fzf"                              # command-line fuzzy finder
    "git"                              # git
    "github-cli"                       # yep, github cli
    "git-lfs"                          # git large files in Git repositories
    "helm"                             # helm for k8s
    "htop"                             # hipster top
    #"hypnotix"                         # iptv app
    "jq"                               # jq cli
    "neovim"                           # ditched vim for neovim
    "k9s"                              # view/manage k8s clusters
    "krew-bin"                         # package manager for kubectl plugins
    "kubectl"                          # kubectl
    "kubectx"                          # kubectx
    "lscolors-git"                     # colored shell
    "lxappearance"                     # lxappearance
    "manjaro-pipewire"                 # manjaro pipewire meta package for pipewire support
    "mtr"                              # traceroute and ping
    "ncdu"                             # disk space info (a better du)
    "neovim"                           # vim fork improved
    "nitrogen"                         # nitrogen wallpaper manager
    "nmap"                             # nmap - network discovery / portscan
    "nvm"                              # node version manager
    "pa-applet"                        # pulseaudio applet
    #"pavucontrol"                      # pulseaudio vol control
    "picom-git"                        # composito
    "playerctl"                        # playerctl
    "podman"                           # simple management tool for pods, containers and images
    "python-pipenv"                    # manage python virtualenvs
    "python-pyotp"                     # python otp lib for aegis-decrypt
    "python-qrcode"                    # python qr code lib for aegis-decrypt
    "ripgrep"                          # recursive search on steroids
    "ristretto"                        # picture viewer
    "rofi"                             # app launcher
    "rtkit"                            # realtime policy and watchdog daemon control
    #"seahorse"                         # manage PGP keys
    "signal-desktop"                   # signal messenger
    "sipcalc"                          # subnetting calculator
    "slack-desktop"                    # slack
    "spotify"                          # spotify
    "starship"                         # starship prompt
    "syncthing"                        # continuous replication / cluster synchronization thing
    "tailscale"                        # mesh vpn
    "thunar"                           # file manager
    "thunar-volman"                    # file manager removable devices
    "tumbler"                          # file manager - thumbnail previews
    "unrar"                            # unrar
    "unzip"                            # unzip
    "v4l-utils"                        # userspace tools for video 4 linux
    "visual-studio-code-bin"           # VS Code
    "whois"                            # whois
    "wireguard-tools"                  # secure network tunnel - tools
    "xclip"                            # clipboard
    "xdg-user-dirs"                # xdg-user-dirs
    "xdg-utils"                        # xdg-utils

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

# fonts
echo "Installing fonts..."

echo "Iosevka Regular"
test -f "${HOME}/.local/share/fonts/Iosevka Nerd Font Complete.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete.ttf -P ~/.local/share/fonts/

echo "Iosevka Regular Mono"
test -f "${HOME}/.local/share/fonts/Iosevka Nerd Font Complete Mono.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/ 

echo "Source Code Pro (SauceCodePro) Semibold Italic"
test -f "${HOME}/.local/share/fonts/Sauce Code Pro Semibold Italic Nerd Font Complete Mono.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold-Italic/complete/Sauce%20Code%20Pro%20Semibold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/

echo "Source Code Pro (SauceCodePro) Semibold Mono"
test -f "${HOME}/.local/share/fonts/Sauce Code Pro Semibold Nerd Font Complete Mono.ttf" || wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/

