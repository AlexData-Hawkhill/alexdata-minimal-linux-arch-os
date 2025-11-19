# 🐧 INSTALLING APPS AND PACKAGES IN LINUX 🐧 
## USING "PARU" (THE SECONDARY INSTALLER CHOSEN FOR ARCH):
[git-md-text-formatting-help](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

## Installing paru on your Linux Arch:  

### Update pacman app database!!!  
> sudo pacman -Sy

### Install paru and its perl dependencies.         
> sudo pacman -S paru   

### Check and display paru version info.  
> paru --version  

### Adds AUR tab to Discover if you have that "app store" installed.  
> paru -S discover-aur            

### Install Discover App Store if you dont have it!
> sudo pacman -S discover flatpak xdg-desktop-portal-kde  
