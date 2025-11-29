# 🐧📦 Things we can do with app packages 📦🐧

Sometimes we want to change things, remove things, or try new things.  
Other times we want to backup things, or restore things.  

We can use `bash in terminal`, `pacman`, `paru`, or `octopi` for working with packages.  
So here are different methods I found for doing many different things with packages, using those!  


<br>

### List all installed packages and save as a text file:
```bash
pacman -Q > ~/installed-packages.txt
```
<br>

### List packages by size (example: this finds big desktop enviroments):
```bash
pacman -Qi | grep -E "^Name|^Installed Size" | paste - - | sort -k4 -h
```
```bash
pacman -Qi | grep -E "^Name|^Installed Size" | paste - - | sort -k4 -h > ~/installed-packages.txt
```
<br>

### Search for specific packages (example: search for desktop environments):
```bash
pacman -Q | grep -E "(plasma|gnome|xfce|mate|cinnamon|lxde|lxqt)"
```
```bash
pacman -Q | grep -E "(plasma|gnome|xfce|mate|cinnamon|lxde|lxqt)" > ~/installed-packages.txt
```
<br>

### Octopi (APP / GUI) [pacman -s octopi]:
Use this app-store to install, uninstall, search for, or learn about installed or soon to be installed packages!  
Click through the installed packages - read what they do - figue out what you want to remove manually.
Or use 🔎search function🔍 in octopi if you know what you're looking for!  
![Octopi App](/images/octopi-app.webp)
<br>
