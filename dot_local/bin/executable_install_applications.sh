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
  "alacritty"       # my terminal of choice
  "arandr"          # xrandr gui
  "blueman"         # bluetooth manager
  "brave-bin"       # safer browsing
  "chezmoi"         # manages my dotfiles and ssh keys
  "dnsutils"        # dnsutils like dig, host etc.
  "exa"             # colored ls
  "flameshot"       # screenshot tool
  "foliate"         # ebook reader
  "git"             # git
  "github-cli"      # yep, github cli
  "helm"            # helm for k8s
  "htop"            # hipster top
  "hypnotix"        # iptv app
  "jq"              # jq cli
  "neovim"          # ditched vim for neovim
  "kubectl"         # kubectl
  "kubectx"         # kubectx
  "lscolors-git"    # colored shell
  "lxappearance"    # lxappearance
  "mtr"             # traceroute and ping
  "nitrogen"        # nitrogen wallpaper manager
  "nmap"            # nmap - network discovery / portscan
  "pavucontrol"     # pulseaudio vol control
  "picom-git"       # composito
  "python-pipenv"   # manage python virtualenvs
  "ripgrep"         # recursive search on steroids
  "ristretto"       # picture viewer
  "rofi"            # app launcher
  "seahorse"        # manage PGP keys
  "signal-desktop"  # signal messenger
  "sipcalc"         # subnetting calculator
  "slack-desktop"   # slack
  "spotify"         # spotify
  "tailscale"       # mesh vpn
  "thunar"          # file manager
  "tumbler"         # file manager - thumbnail previews
  "unzip"           # unzip
  "whois"           # whois
  "wireguard-tools" # secure network tunnel - tools
  "xclip"           # clipboard
)

counter=0
echo "Installing apps..."
for app in "${apps[@]}"; do
  #echo "$app"
  counter=$((counter+1))
  paru -Qi $app | grep ^Name || yes | paru --skipreview -S $app
done
echo "$counter apps installed"

