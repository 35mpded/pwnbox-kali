#!/usr/bin/env bash

# Request root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
else

# Set the colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGRAY='\033[0;37m'
NC='\033[0m' # No Color

# Set the variables which will store the user's choices
VAR_PWNBOXTERM=false
VAR_AUTORECON=false
VAR_RECONNOITRE=false
VAR_NMAPAUTOMATOR=fasle
VAR_TOOLS=false
VAR_TMUXWALLPAPERS=fasle
VAR_TMUXCONFIG=fasle
VAR_ATOM=false
VAR_CLEANUP=false
# Get the root home path and regular user home path.
root_home=$HOME
user_home=$(sudo -H -u kali zsh -c 'echo $HOME')

# Print a DISCLAIMER:
printf "${RED}[*] DISCLAIMER:${NC}\n"
printf "The author of the script is not responsible for any damages made by the use of this script.\n"
printf "Do you agree with the above statement? (please answer with yes[y] or no[n]).\n"
#    read -p "`echo [*] The author of the script is not responsible for any damages made by the use of this script. $'\nDo you agree with the above statement? (please answer with yes[y] or no[n]) '$'\n> '`" yn

# Check if the user accepted the disclaimer
while true; do
    read -p "`echo $'> '`" yn
    case $yn in
        [Yy]* ) VAR_PWNBOXTERM=true; break;;
        [Nn]* ) VAR_PWNBOXTERM=false; exit;;
        * ) echo "Please answer yes(y) or no(n).";;
    esac
done

# Prompt function to ask the user for installation choices
prompt()
{
printf "${PURPLE}[*] ${CYAN}Select the options you want the script to perform:${NC}\n"
while true; do
	printf "${BORANGE}Do you want to install ${GREEN}pwnbox-terminal?${NC} (y/n)"
    read -p "`echo $'\n> '`" yn
    case $yn in
        [Yy]* ) VAR_PWNBOXTERM=true; break;;
        [Nn]* ) VAR_PWNBOXTERM=false; break;;
		* );;
    esac
done
while true; do
	printf "${BORANGE}Do you want to install ${GREEN}AutoRecon?${NC} (y/n)"
	read -p "`echo $'\n> '`" yn
    case $yn in
        [Yy]* ) VAR_AUTORECON=true; break;;
        [Nn]* ) VAR_AUTORECON=false; break;;
        * );;
    esac
done
while true; do
	printf "${BORANGE}Do you want to install ${GREEN}Reconnoitre?${NC} (y/n)"
    read -p "`echo $'\n> '`" yn
    case $yn in
        [Yy]* ) VAR_RECONNOITRE=true; break;;
        [Nn]* ) VAR_RECONNOITRE=false; break;;
        * );;
    esac
done
while true; do
	printf "${BORANGE}Do you want to install ${GREEN}nmapAutomator?${NC} (y/n)"
    read -p "`echo $'\n> '`" yn
    case $yn in
        [Yy]* ) VAR_NMAPAUTOMATOR=true; break;;
        [Nn]* ) VAR_NMAPAUTOMATOR=false; break;;
        * );;
    esac
done
while true; do
	printf "${BORANGE}Do you want to install ${GREEN}Atom.io?${NC} (y/n)"
    read -p "`echo $'\n> '`" yn
    case $yn in
        [Yy]* ) VAR_ATOM=true; break;;
        [Nn]* ) VAR_ATOM=false; break;;
        * );;
    esac
done
while true; do
	printf "${BORANGE}Do you want the ${GREEN}tmux wallpaper cheatsheet?${NC} (y/n)"
	read -p "`echo $'\n> '`" yn
    case $yn in
        [Yy]* ) VAR_TMUXWALLPAPERS=true; break;;
        [Nn]* ) VAR_TMUXWALLPAPERS=false; break;;
        * );;
    esac
done
while true; do
	printf "${BORANGE}Do you want to set the ${GREEN}pwnbox config for tmux?${NC} (y/n)"
	read -p "`echo $'\n> '`" yn
    case $yn in
        [Yy]* ) VAR_TMUXCONFIG=true; break;;
        [Nn]* ) VAR_TMUXCONFIG=false; break;;
        * );;
    esac
done
}
install_PWNBOXTERM()
{
if [ "$VAR_PWNBOXTERM" = true ] ; then
	printf "${PURPLE}[*] ${CYAN}Installing pwnbox-terminal...${NC}\n"
	sleep 2
	# Backup the .zshrc files for the normal user and root user
	cp $user_home/.zshrc $user_home/.zshrc.bak
	cp $HOME/.zshrc $HOME/.zshrc.bak
	
	# Change the prompt for regular user (2022 versions)
	sed -i 's/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\x27\$prompt_symbol\$\x27%m%b%F{%(#\.blue\.green)})-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\x27\$prompt_symbol\$\x27%m%b%F{%(#\.blue\.green)})-%B%F{152}\[`get_ip`\]%b%f%F{%(#\.blue\.green)}-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/g' $user_home/.zshrc
	
	# Change the prompt for regular user (2021 versions)
	# sed -i 's/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\$prompt_symbol%m%b%F{%(#\.blue\.green)})-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\$prompt_symbol%m%b%F{%(#\.blue\.green)})-%B%F{152}\[`get_ip`\]%b%f%F{%(#\.blue\.green)}-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/g' $user_home/.zshrc
	
	# Comment the next line if you do not want the skull
	sed -i 's/prompt_symbol=㉿/prompt_symbol=💀/g' $user_home/.zshrc
	
	# Add the get ip function to regular user
	printf "\n# START CUSTOM \nfunction get_ip(){\n   # It can be thm or htb IP\n   tunnel_ip=\`ifconfig tun0 2>/dev/null | grep netmask | awk '{print \$2}'\` \n   # Use eth0 as default IP,\n   default_ip=\`ifconfig eth0 2>/dev/null | grep netmask | awk '{print \$2}'\`\n   if [[ \$tunnel_ip == *\"192.168.\"* ]]; then\n      echo \$tunnel_ip\n   else\n      echo \$default_ip\n   fi\n}\n# END CUSTOM" >> $user_home/.zshrc

	# Change the promtp for root user (2022 versions)
	sed -i 's/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\x27\$prompt_symbol\$\x27%m%b%F{%(#\.blue\.green)})-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\x27\$prompt_symbol\$\x27%m%b%F{%(#\.blue\.green)})-%B%F{152}\[`get_ip`\]%b%f%F{%(#\.blue\.green)}-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/g' $root_home/.zshrc
	
	# Change the prompt for root user (2021 versions) 
	# sed -i 's/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\$prompt_symbol%m%b%F{%(#\.blue\.green)})-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/PROMPT=\$\x27%F{%(#\.blue\.green)}┌──\${debian_chroot:+(\$debian_chroot)─}\${VIRTUAL_ENV:+(\$(basename \$VIRTUAL_ENV))─}(%B%F{%(#\.red\.blue)}%n\$prompt_symbol%m%b%F{%(#\.blue\.green)})-%B%F{152}\[`get_ip`\]%b%f%F{%(#\.blue\.green)}-\[%B%F{reset}%(6~\.%-1~\/…\/%4~\.%5~)%b%F{%(#\.blue\.green)}\]\\n└─%B%(#\.%F{red}#\.%F{blue}\$)%b%F{reset} \x27/g' $root_home/.zshrc

	# Add the get ip function to root user
	printf "\n# START CUSTOM \nfunction get_ip(){\n   # It can be thm or htb IP\n   tunnel_ip=\`ifconfig tun0 2>/dev/null | grep netmask | awk '{print \$2}'\` \n   # Use eth0 as default IP,\n   default_ip=\`ifconfig eth0 2>/dev/null | grep netmask | awk '{print \$2}'\`\n   if [[ \$tunnel_ip == *\"192.168.\"* ]]; then\n      echo \$tunnel_ip\n   else\n      echo \$default_ip\n   fi\n}\n# END CUSTOM" >> $root_home/.zshrc
	
fi
}
install_AUTORECON()
{
if [ "$VAR_AUTORECON" = true ] ; then
    printf "${PURPLE}[*] ${CYAN}Installing AutoRecon...${NC}\n"
	sleep 2
	apt install seclists curl enum4linux feroxbuster gobuster impacket-scripts nbtscan nikto nmap onesixtyone oscanner redis-tools smbclient smbmap snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf -y
	sudo python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git
fi
}

install_RECONNOITRE()
{
if [ "$VAR_RECONNOITRE" = true ] ; then
    printf "${PURPLE}[*] ${CYAN}Installing Reconnoitre...${NC}\n"
	sleep 2
	sudo -H -u root zsh -c 'python3 -m pip install git+https://github.com/codingo/Reconnoitre.git'
fi
}

install_NMAPAUTOMATOR()
{
if [ "$VAR_NMAPAUTOMATOR" = true ] ; then
    printf "${PURPLE}[*] ${CYAN}Installing nmapAutomator...${NC}\n"
	sleep 2
	
	# nmapAutomator needs it
	apt install gobuster -y
	git clone https://github.com/21y4d/nmapAutomator.git /opt/nmapAutomator
	
	# Create a symlink "nmapAutomator.sh" for the automator
	sudo ln -s /opt/nmapAutomator/nmapAutomator.sh /usr/local/bin/
fi
}
install_TMUXWALLPAPERS()
{
if [ "$VAR_TMUXWALLPAPERS" = true ] ; then
	printf "${PURPLE}[*] ${CYAN}Moving wallpapers...${NC}\n"
	sleep 2
	
	# Move the wallpaper
	sudo -H -u kali zsh -c 'mkdir $HOME/Pictures/pwnbox-wallpapers'
	sudo -H -u kali zsh -c 'mv ./pwnbox-wallpapers/kali-*-tmux-*.png $HOME/Pictures/pwnbox-wallpapers'
fi
}
install_TMUXCONFIG()
{
if [ "$VAR_TMUXCONFIG" = true ] ; then
	printf "${PURPLE}[*] ${CYAN}Configuring TMUX...${NC}\n"
	sleep 2
	
	# Install the tmux logging plugin:
	git clone https://github.com/tmux-plugins/tmux-logging /opt/tmux-logging
	
	# Set the tmux config for normal user
	sudo -H -u kali zsh -c 'printf "## CONFIG\n## Remap prefix to screen\n#set -g prefix C-a\n#bind C-a send-prefix\n#unbind C-b\n## Quality of life stuff\n# Set scrollback buffer\nset -g history-limit 10000\n# Only static names no autorename allowed\nset -g allow-rename off\n## join Windows\nbind-key j command-prompt -p \"join pane from:\"      \"join-pane -s '%%'\"\nbind-key s command-prompt -p \"send pane to:\"   \"join-pane -t '%%'\"\n## Search Mode VI (default is emac because author is an ass)\nset-window-option -g mode-keys vi\n# history loggin plugin: https://github.com/tmux-plugins/tmux-logging\nrun-shell /opt/tmux-logging/logging.tmux\n# Enable mouse scroll: https://superuser.com/questions/210125/scroll-shell-output-with-mouse-in-tmux\n#set -g mouse on\n#https://appuals.com/stuck-in-tmux-scroll-up/\nset -g terminal-overrides 'xterm*:smcup@:rmcup@'" > $HOME/.tmux.conf'
	
	# Reload the tmux config for normal user
	sudo -H -u kali zsh -c 'tmux source-file ~/.tmux.conf'
	
	# Set the tmux config for root user
	printf "## CONFIG\n## Remap prefix to screen\n#set -g prefix C-a\n#bind C-a send-prefix\n#unbind C-b\n## Quality of life stuff\n# Set scrollback buffer\nset -g history-limit 10000\n# Only static names no autorename allowed\nset -g allow-rename off\n## join Windows\nbind-key j command-prompt -p \"join pane from:\"      \"join-pane -s '%%'\"\nbind-key s command-prompt -p \"send pane to:\"   \"join-pane -t '%%'\"\n## Search Mode VI (default is emac because author is an ass)\nset-window-option -g mode-keys vi\n# history loggin plugin: https://github.com/tmux-plugins/tmux-logging\nrun-shell /opt/tmux-logging/logging.tmux\n# Enable mouse scroll: https://superuser.com/questions/210125/scroll-shell-output-with-mouse-in-tmux\n#set -g mouse on\n#https://appuals.com/stuck-in-tmux-scroll-up/\nset -g terminal-overrides 'xterm*:smcup@:rmcup@'" > $HOME/.tmux.conf
	
	# Reload the tmux config for root user
	tmux source-file ~/.tmux.conf
fi
}
install_ATOM()
{
if [ "$VAR_ATOM" = true ] ; then
	printf "${PURPLE}[*] ${CYAN}Installing Atom.io...${NC}\n"
	sleep 2
	
	# Download and install atom
	wget https://atom.io/download/deb -O /tmp/atom.deb
	sudo -H -u root zsh -c 'dpkg -i /tmp/atom.deb'
fi
}
# Prompt the user for installation choices
prompt
printf "${PURPLE}[*] ${CYAN}Installing prerequisites...${NC}\n"
sleep 2
# Update and Install prerequisites
apt-get update
apt install python3-pip -y
# Self explanatory
install_AUTORECON
install_RECONNOITRE
install_NMAPAUTOMATOR
install_ATOM
install_PWNBOXTERM
install_TMUXWALLPAPERS
install_TMUXCONFIG
fi