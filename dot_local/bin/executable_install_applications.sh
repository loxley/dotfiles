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
  "alacritty"                        # my terminal of choice
  "arandr"                           # xrandr gui
  "blueman"                          # bluetooth manager
  "brave-bin"                        # safer browsing
  "chezmoi"                          # manages my dotfiles and ssh keys
  "dive-bin"                         # explore docker layers
  "dnsutils"                         # dnsutils like dig, host etc.
  "duf"                              # disk usage/free utility
  "exa"                              # colored ls
  "fd"                               # "find" for files
  "flameshot"                        # screenshot tool
  "foliate"                          # ebook reader
  "git"                              # git
  "github-cli"                       # yep, github cli
  "helm"                             # helm for k8s
  "htop"                             # hipster top
  "hypnotix"                         # iptv app
  "jq"                               # jq cli
  "neovim"                           # ditched vim for neovim
  "k9s"                              # view/manage k8s clusters
  "kubectl"                          # kubectl
  "kubectx"                          # kubectx
  "lscolors-git"                     # colored shell
  "lxappearance"                     # lxappearance
  "mtr"                              # traceroute and ping
  "nitrogen"                         # nitrogen wallpaper manager
  "ncdu"                             # disk space info (a better du)
  "nmap"                             # nmap - network discovery / portscan
  "pavucontrol"                      # pulseaudio vol control
  "picom-git"                        # composito
  "python-pipenv"                    # manage python virtualenvs
  "ripgrep"                          # recursive search on steroids
  "ristretto"                        # picture viewer
  "rofi"                             # app launcher
  "seahorse"                         # manage PGP keys
  "signal-desktop"                   # signal messenger
  "sipcalc"                          # subnetting calculator
  "slack-desktop"                    # slack
  "spotify"                          # spotify
  "tailscale"                        # mesh vpn
  "thunar"                           # file manager
  "tumbler"                          # file manager - thumbnail previews
  "unzip"                            # unzip
  "visual-studio-code-bin"           # VS Code
  "whois"                            # whois
  "wireguard-tools"                  # secure network tunnel - tools
  "xclip"                            # clipboard

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
#echo "Installing fonts..."
#
#echo "Iosevka Regular"
#wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete.ttf -P ~/.local/share/fonts/
#
#echo "Iosevka Regular Mono"
#wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/ 
#
#echo "Source Code Pro (SauceCodePro) Semibold Italic"
#wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold-Italic/complete/Sauce%20Code%20Pro%20Semibold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf ~/.local/share/fonts/
#
#echo "Source Code Pro (SauceCodePro) Semibold Mono"
#wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete%20Mono.ttf -P ~/.local/share/fonts/

