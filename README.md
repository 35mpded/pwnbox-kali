# ABOUT
This script is intended to automatically setup (for the most part) environment which is especially useful for OSCP or HTB labs.  It will  modify the zsh terminal to show your adapter's IP address or that of your VPN connection next to the hostname. Much like that of the HTB's modified ParrotOS zsh.

Original zsh:
```
┌──(kali㉿kali)-[~]
└─$ 
```
Modified zsh:
```
┌──(kali💀kali)-[192.168.0.101]-[~]
└─$ 
```

It will also prompt to setup some frequently used tools:

 - nmapAutomator 
 - AutoRecon 
 - Reconnoitre 
 - Atom text editor
 - tmux configuration:
	 - default xterm behaviour (no need to enter into edit mode to copy or scroll)
	 - tmux logging plugin
	 - disabled auto rename of tmux windows
 - tmux wallpaper-cheatsheets

**Tested on:**
kali-linux-2022.1

# Installation & Configuration instructions
**Download and run the setup script:**
```
git clone https://github.com/SubXi/pwnbox-kali.git
pwnbox-kali
chmod +x pwnbox_setup.sh
sudo ./pwnbox_setup.sh
exit
```
Note:
* You'll need to accept the "pwnbox-terminal" option in order to get the customized terminal.
* After the installation, when you open a new terminal you should see the customized terminal. If you don't, see the Configuration section below.

**Configuration**

For the IP address to be displayed next to the hostname on the terminal, you'll need to modify both user and root `$HOME/.zshrc` (or the script) and find the `get_ip()` function . Then you'll need to change IP range `192.168.` according to your network settings.
```
if [[ $tunnel_ip == *"192.168."* ]]; then
```

# Notes:
Consider modifying the script to create a folder structure where you'll hold your loot/exploits, notes, maybe even to download frequently used tools for privilege escalation and so on. I haven't included such features on purpose, but I might in future updates. 
