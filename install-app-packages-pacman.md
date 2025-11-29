# 🐧 INSTALLING APPS AND PACKAGES IN LINUX ARCH 🐧
## USING "PACMAN" (THE DEFAULT INSTALLER FOR ARCH): 

<br>

### PACMAN - ONCE IN A WHILE TYPE COMMANDS (LINUX ARCH):
> pacman -S <name>              # (update repositories).  
> pacman -Sy                   # (Synchronizing package databases).  
> pacman -Sc                    # (Clean the CACHE folder for oldest downloaded packages).  
> pacman -Scc                   # (Clean the CACHE folder for all downloaded packages).  
> m.m  

<br>

### PACMAN - CHECK INSTALLED PACKAGES (LINUX ARCH):
> pacman -Q  
> pacman -Qs <name>   

<br>

### PACMAN - MOST USED COMMANDS (LINUX ARCH):
> pacman -Ss <word>             # SEARCH FOR APP OR PACKAGE NAMED <word> IN CONNECTED REPOSITORIES!  
> pacman -S <app/package>       # INSTALLS <app/package> IF IT EXISTS IN THE REPOSITORIES!  

<br>

### LIST ALL INSTALLED PACKAGES IN DIFFERENT WAYS:
> pacman -Qi                    # Very detailed list with lots of info on each package!
> pacman -Qi > ~/installed.txt  # Very detailed package list saved to file in home folder!  

> pacman -Q > ~/installed.txt   # List package names and save to file in home folder!

<br>

### List packages by size (find big packages)
pacman -Qi | grep -E "^Name|^Installed Size" | paste - - | sort -k4 -h

<br>

### Search for specific packages (desktop apps in this example)
pacman -Q | grep -E "(plasma|gnome|xfce|mate|cinnamon|lxde|lxqt)"

<br>

### INSTALL RECOMMENDED USEFUL APPS WITH PACMAN:
[More Apps: recommended-apps.md](/recommended-apps.md)
> pacman -S btop                # CLI interface for CPU, GPU, RAM, DISK info!  
> pacman -S openssh             # Use SSH SFTP SCP connections with local machines or remote servers.  
> pacman -S python              # Python itself - Coding language with live compiler.  
> pacman -S python-pip          # Python package manager for Python modules.  
> pacman -S octopi              # Pacman frontend GUI (similar to an app store).  

<br>

