### 🐧 Openbox Window Manager 🐧
This window manager can be used as a basic desktop environent.  
It will let you run graphical applications without a full desktop environment.  
```bash
xinit /usr/bin/firefox -- :1    # If you have followed this guide before the use this command!
```
(_if you have not read this guide before - then read on, and I will explain what you need to know!_)  

<br>

### System Packages Needed (Already installed with ArchOS or CachyOS):
- xorg-server is a X Window System [developer-info](https://www.x.org/releases/X11R7.7/doc/)  
- xorg-xinit is a [developer-info](https://xorg.freedesktop.org/wiki/)  
```bash
sudo pacman -S xorg-server xorg-xinit    # If you dont have them - install them! Must have!
```
- openbox is the Window Manager (it draws all type windows - like those you see in your normal desktop environment)
```bash
sudo pacman -S openbox    # If you dont have it- install it! Must have!
```
<br>

### App Packages Needed for testing (may not be installed):

The xrandr and arandr are text and GUI based ways of setting up several monitors connected to your machine! A must have!  
```bash
sudo pacman -S xorg-xrandr arandr # The arandr is a gui alternative to xrandr - Setting up monitors size, orientation, m.m!!
```

The xterm is a very tiny basic graphical bash konsole. [developer-info](https://invisible-island.net/xterm/)  A must have!
```bash
sudo pacman -S xterm    # tiny GUI terminal for starters!
```

The xorg-xclock and xorg-xeyes are "a tiny gui clock" and a "tiny follow mousepointer visually type app"...  
```bash
pacman -S xorg-xclock xorg-xeyes    # tiny GUI apps to test with
```

If you want to test out all the 36 or more xGUI apps (you can always remove them later)  
```bash
sudo pacman -S xorg-apps   # all 36 tiny GUI apps to test openbox with
```
:: There are 36 members in group xorg-apps:
:: Repository cachyos-extra-v3
   1) xorg-bdftopcf  2) xorg-iceauth  3) xorg-mkfontscale  4) xorg-sessreg  5) xorg-setxkbmap  6) xorg-smproxy  7) xorg-x11perf  8) xorg-xauth
   9) xorg-xbacklight  10) xorg-xcmsdb  11) xorg-xcursorgen  12) xorg-xdpyinfo  13) xorg-xdriinfo  14) xorg-xev  15) xorg-xgamma
   16) xorg-xhost  17) xorg-xinput  18) xorg-xkbcomp  19) xorg-xkbevd  20) xorg-xkbprint  21) xorg-xkbutils  22) xorg-xkill  23) xorg-xlsatoms
   24) xorg-xlsclients  25) xorg-xmodmap  26) xorg-xpr  27) xorg-xprop  28) xorg-xrandr  29) xorg-xrdb  30) xorg-xrefresh  31) xorg-xset
   32) xorg-xsetroot  33) xorg-xvinfo  34) xorg-xwd  35) xorg-xwininfo  36) xorg-xwud

<br>

### Switch to a free available TTY (virtual bash terminal): 
From your current session (GUI or TTY1),  
switch to an available virtual terminal (e.g., TTY2) by pressing Ctrl+Alt+F2 (or Ctrl+Alt+ F3, F4, F5, F6).  
You will see a command-line login prompt.  
Log in with your username and password (login as root or normal account).  
(If you see your normal desktop, or a black screen with mousepointer, then just try a different TTY!)  


### Best Launch Method (Specific Display Number):
You can launch an application on a specific, separate X display number without modifying your main .xinitrc file by specifying a display number (e.g., :1).
```bash
xinit /usr/bin/firefox -- :3   # Manually starts on specific X server "display  3" (display does not mean monitor in this case)
```
This method works flawless !! And there is no need to edit any files!
This runs Firefox on display 1 (or 2, or 3, or 4, or...), which might be on TTY8 (depending on your configuration),  
allowing you to switch to it using Ctrl+Alt+F8 (or the appropriate F-key).  
(try CTRL+ALT+ F1,F2,F3,F4,F5,F6,F7,F8 and you will find it on one of those).  

### NB: PS: 
Using `exec <app>` means when the application is closed,  
the X session terminates, returning you to the TTY login prompt.  
(Use this instead of `<app> &` as that may get the X display stuck after you close the GUI app).  

<br>

### Alternative - Create or Edit .xinitrc:
The startx command uses a script in your home directory named `.xinitrc` to determine what to run.  
That file is normally loaded when loading in your normal desktop environment.
If this file doesn't exist, create it by copying the default system one from /etc/X11/xinit/.  
```bash
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```
In this case we copy the xinitrc file to our home folder (~/) and save it as ".xinitrc".  
By doing so we tell the system to "_read our extra file as well as the original xinitrc_".  
This will let us temporarily override the main original xinitrc file, so that we can experiment safely!  
Delete the `~/.xinitrc file` if something stops working correctly (`rm ~/.xinitrc    # Deletes file!`) and all changes are automatically reset! (`sudo rm ~/.xinitrc    # Deletes file as admin!`)

<br>

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
(Use this instead of `<app> &` as that may get the X display stuck after you close the GUI app).  

<br>

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

A smart choice may be to run konsole as the app (not firefox or xterm), then from konsole more apps can be started!

