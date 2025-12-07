# 🐧 Openbox Window Manager 🐧
This window manager can be used as a basic dektop environent.  
It will let you run graphical applications without a full desktop environment.  

### System Packages Needed:
- xorg-server is a X Window System [developer-info](https://www.x.org/releases/X11R7.7/doc/)  
- xorg-xinit is a [developer-info](https://xorg.freedesktop.org/wiki/)  
```bash
sudo pacman -S xorg-server xorg-xinit
```

### App Packages Needed:
- xterm is a very basic graphical bash konsole. [developer-info](https://invisible-island.net/xterm/)  
```bash
sudo pacman -S xterm
```

### Switch to a free available TTY: 
From your current session (GUI or TTY1),  
switch to an available virtual terminal (e.g., TTY2) by pressing Ctrl+Alt+F2 (or Ctrl+Alt+ F3, F4, F5, F6).  
You will see a command-line login prompt.  
Log in with your username and password (login as root or normal account).  

Create or Edit .xinitrc:
The startx command uses a script in your home directory named .xinitrc to determine what to run.  
If this file doesn't exist, create it by copying the default system one from /etc/X11/xinit/.  
```bash
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

### Configure .xinitrc to run a gui app:
Configure `.xinitrc` to run a single app: Edit your `~/.xinitrc` file using a terminal editor like nano (or vim).  
(You can also do this via Kate editor and Dolphin filebrowser if logged into a desktop environment like plasma).  
```bash
nano ~/.xinitrc
```
Comment out or remove the default desktop environment/window manager execution lines at the end of the file,  
and replace them with the command to run your specific application.  
Ensure the last line uses `exec` to manage the session correctly.  

To run just the xterm konsole like GUI app, for example,  
your final lines would look something like this (commenting out previous exec lines):  
```bash
# twm &
# xclock &
exec xterm 
```

To run just the firefox browser, for example,  
your final lines would look something like this (commenting out previous exec lines):  
```bash
# twm &
# xclock &
# xterm &
exec firefox
```

### NB: PS: 
Using `exec <app>` means when the application is closed,  
the X session terminates, returning you to the TTY login prompt.  

### Start the X session: From the TTY, run the startx command:
```bash
startx    # Try this - the automatic way first!
```
```bash
startx -- :1    # Manually starts on specific X server "display" (display does not mean monitor in this case)
```
The screen will clear/go black, and your GUI application will launch/open.  
When you close the GUI application (xterm/firefox), you will return to the TTY prompt.  

If you see an error when trying the two above commands - try a higher display port (2,3,4,5,m.m)
```bash
startx -- :2    # Manually starts on specific X server "display" (display does not mean monitor in this case)
```
```bash
startx -- :3    # Manually starts on specific X server "display" (display does not mean monitor in this case)
```
This runs Firefox on display 1 (or 2, or 3, or 4, or...), which might be on TTY8 (depending on your configuration),  
allowing you to switch to it using Ctrl+Alt+F8 (or the appropriate F-key).  
(try CTRL+ALT+ F1,F2,F3,F4,F5,F6,F7,F8 and you will find it on one of those).  

A smart choice may be to run konsole, then from konsole more apps can be started!


