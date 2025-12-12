# 🐧 OpenBox-Only Arch Install Guide 🐧
**Minimal Arch Linux with OpenBox Window Manager**

Based on AlexData's Minimal Arch Install - Modified for OpenBox-Only (No KDE Plasma)

---

## FOLLOW ALEXDATA'S GUIDE STEPS 1-19 NORMALLY ✅

**Complete these steps exactly as written in arch-minimal-install.md:**

1. Setup install environment
2. Verify boot mode
3. Connect to internet
4. Update system clock
5. Identify connected disks
6. Partition the disk
7. Format partitions
8. Mount partitions
9. Select fastest mirrors
10. Install base system
11. Generate fstab
12. Chroot into new system
13. Set timezone
14. Set locale
15. Set keyboard layout
16. Set hostname
17. Set root password
18. Create normal user account
18.5-18.7. Add CachyOS repos + multilib
19. Install boot loader (systemd-boot)

**✅ STEPS 1-19 ARE UNIVERSAL - FOLLOW YOUR GUIDE EXACTLY!**

---

## STEP 20: INSTALL DISPLAY SERVER ✅ (SAME AS YOUR GUIDE)

```bash
pacman -S xorg-server xorg-xinit
```

**✅ OpenBox needs X11 - install this normally!**

---

## STEP 21: INSTALL OPENBOX (REPLACES PLASMA!) 🚨

**❌ DO NOT INSTALL THIS (from your guide):**
```bash
# pacman -S kwin plasma-desktop plasma-workspace plasma-workspace-wallpapers
```

**✅ INSTALL THIS INSTEAD:**
```bash
pacman -S openbox tint2 nitrogen picom
```

**What each package does:**
- `openbox` = Window manager (the core!)
- `tint2` = Panel/taskbar
- `nitrogen` = Wallpaper setter
- `picom` = Compositor (smooth graphics)

**Optional extras (install if wanted):**
```bash
pacman -S obconf obmenu            # GUI config tools (may not be in repos)
pacman -S arandr                   # Display configuration GUI
pacman -S rofi                     # Application launcher
pacman -S dunst                    # Notification daemon
```

---

## STEP 22: SKIP LOGIN MANAGER (LIGHTWEIGHT!) 🚨

**❌ DO NOT INSTALL THIS (from your guide):**
```bash
# pacman -S sddm
# systemctl enable sddm
```

**✅ SKIP ENTIRELY - Use startx method instead!**

**Alternative (if you want graphical login):**
```bash
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm
```

**Recommendation: SKIP login manager for minimal setup!**

---

## STEP 23: INSTALL APPS (KEEP OR USE LIGHTER ALTERNATIVES)

**OPTION A: Keep KDE apps (heavier but familiar):**
```bash
pacman -S konsole dolphin kate spectacle
```

**OPTION B: Use lightweight alternatives:**
```bash
pacman -S xterm pcmanfm mousepad scrot
```

**What's the difference:**
- `konsole` vs `xterm` → xterm is lighter terminal
- `dolphin` vs `pcmanfm` → pcmanfm is lighter file manager
- `kate` vs `mousepad` → mousepad is lighter text editor
- `spectacle` vs `scrot` → scrot is lighter screenshot tool

**Your choice!** KDE apps work fine in OpenBox.

---

## STEP 24: NETWORK MANAGEMENT 🔧

**❌ DO NOT INSTALL THIS (from your guide):**
```bash
# pacman -S plasma-nm
```

**✅ INSTALL THIS INSTEAD:**
```bash
systemctl enable NetworkManager     # Already installed from base

# Optional: Install system tray applet
pacman -S network-manager-applet
```

---

## STEP 25: FIREWALL 🔧

**❌ DO NOT INSTALL THIS (from your guide):**
```bash
# pacman -S firewalld plasma-firewall
```

**✅ INSTALL THIS INSTEAD:**

**OPTION A: Firewalld (CLI management):**
```bash
pacman -S firewalld
systemctl enable firewalld
```

**OPTION B: UFW with GUI:**
```bash
pacman -S ufw gufw
systemctl enable ufw
```

---

## STEP 26: AUDIO SYSTEM 🔧

**❌ DO NOT INSTALL THIS (from your guide):**
```bash
# pacman -S pipewire pipewire-pulse pipewire-alsa wireplumber plasma-pa
```

**✅ INSTALL THIS INSTEAD:**
```bash
pacman -S pipewire pipewire-pulse pipewire-alsa wireplumber pavucontrol
```

**Change:** Replace `plasma-pa` with `pavucontrol` (GTK audio control)

**Optional: System tray volume control:**
```bash
pacman -S volumeicon
```

---

## STEP 27: FONTS ✅ (SAME AS YOUR GUIDE)

```bash
pacman -S noto-fonts noto-fonts-emoji ttf-liberation
```

---

## STEP 28: WINE ✅ (SAME AS YOUR GUIDE)

```bash
pacman -S wine-cachyos
```

---

## STEP 29: ADDITIONAL TOOLS 🔧

**❌ DO NOT INSTALL THIS (from your guide):**
```bash
# pacman -S breeze-gtk
```

**✅ INSTALL THIS INSTEAD (if using GTK apps):**
```bash
pacman -S lxappearance              # GTK theme configurator
pacman -S arc-gtk-theme             # Nice GTK theme
```

---

## STEP 29.5: SYSTEM UTILITIES 🔧

**❌ DO NOT INSTALL THIS (from your guide):**
```bash
# pacman -S kscreen powerdevil plasma5support kinfocenter brightnessctl breeze-gtk
```

**✅ INSTALL THIS INSTEAD:**
```bash
pacman -S arandr                    # Display configuration (replaces kscreen)
pacman -S brightnessctl             # Brightness control
pacman -S btop                      # System monitor
pacman -S openssh                   # Remote access
pacman -S xorg-xrandr               # CLI display config
pacman -S polkit-gnome              # Permission dialogs
```

---

## STEP 30: ENABLE SERVICES 🔧

**✅ MODIFIED VERSION:**
```bash
systemctl enable NetworkManager     # Network
systemctl enable firewalld          # Firewall (or ufw if you chose that)
# NO SDDM - we're using startx!
```

---

## STEP 31: GRAPHICS DRIVERS ✅ (SAME AS YOUR GUIDE)

```bash
pacman -S nvidia-open nvidia-utils lib32-nvidia-utils
pacman -S systemsettings            # If you want KDE system settings
pacman -S egl-wayland               # Wayland support (optional)
```

---

## STEP 32: EXIT & REBOOT ✅ (SAME AS YOUR GUIDE)

```bash
exit                                # Exit chroot
umount -R /mnt                      # Unmount partitions
reboot                              # Restart!
```

---

## STEP 33: FIRST BOOT CONFIGURATION 🚀

**After reboot, login as your user and configure OpenBox:**

### 1. Create OpenBox config directory:
```bash
mkdir -p ~/.config/openbox
```

### 2. Copy default configs:
```bash
cp -r /etc/xdg/openbox/* ~/.config/openbox/
```

### 3. Create autostart script:
```bash
nano ~/.config/openbox/autostart
```

**Add this content:**
```bash
#!/bin/bash

# Display configuration (run arandr first and save your layout!)
# Then uncomment and point to your saved layout:
# ~/.screenlayout/layout.sh &

# Wallpaper
nitrogen --restore &

# Panel
tint2 &

# Compositor (smooth graphics)
picom -b &

# Network manager applet (system tray icon)
nm-applet &

# Volume control (system tray icon)
volumeicon &

# PolicyKit agent (for password prompts)
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Notification daemon
dunst &
```

**Make it executable:**
```bash
chmod +x ~/.config/openbox/autostart
```

### 4. Create ~/.xinitrc for startx:
```bash
nano ~/.xinitrc
```

**Add:**
```bash
#!/bin/bash
exec openbox-session
```

**Make it executable:**
```bash
chmod +x ~/.xinitrc
```

### 5. Configure display layout:
```bash
arandr
# Use GUI to arrange monitors
# File → Save As → ~/.screenlayout/layout.sh
# Then uncomment that line in autostart
```

### 6. Set wallpaper:
```bash
nitrogen ~/Pictures/
# Right-click image → Set as wallpaper
# Preferences → Add directory if needed
```

### 7. Configure tint2 panel:
```bash
nano ~/.config/tint2/tint2rc
# Edit as needed
# See your existing config for reference!
```

---

## STARTING OPENBOX

**Login at TTY and type:**
```bash
startx
```

**OpenBox launches!** 🎯

---

## RESTORE YOUR BACKUP CONFIGS

**If you have backup of your OpenBox configs:**

```bash
# Copy your backed-up configs:
cp -r /path/to/backup/.config/openbox ~/.config/
cp -r /path/to/backup/.config/tint2 ~/.config/
cp /path/to/backup/.xinitrc ~/
cp -r /path/to/backup/.screenlayout ~/

# Make scripts executable:
chmod +x ~/.xinitrc
chmod +x ~/.config/openbox/autostart
chmod +x ~/.screenlayout/*.sh
```

---

## AUTO-START OPENBOX ON LOGIN (OPTIONAL)

**Add to ~/.bash_profile:**
```bash
nano ~/.bash_profile
```

**Add:**
```bash
# Auto-start OpenBox on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec startx
fi
```

**Now OpenBox auto-starts when you login!**

---

## COMPLETE PACKAGE LIST FOR OPENBOX-ONLY INSTALL

**Base system (steps 1-19):**
```
base
linux
linux-firmware
base-devel
networkmanager
sudo
nano
intel-ucode
```

**Display (step 20):**
```
xorg-server
xorg-xinit
xorg-xrandr
```

**OpenBox essentials (step 21):**
```
openbox
tint2
nitrogen
picom
arandr
rofi
dunst
```

**Optional OpenBox tools:**
```
obconf          # May not be in repos
obmenu          # May not be in repos
```

**Apps (step 23) - OPTION A (KDE apps):**
```
konsole
dolphin
kate
spectacle
```

**Apps (step 23) - OPTION B (Lightweight):**
```
xterm
pcmanfm
mousepad
scrot
```

**Network (step 24):**
```
network-manager-applet
```

**Firewall (step 25):**
```
firewalld
# OR
ufw
gufw
```

**Audio (step 26):**
```
pipewire
pipewire-pulse
pipewire-alsa
wireplumber
pavucontrol
volumeicon
```

**Fonts (step 27):**
```
noto-fonts
noto-fonts-emoji
ttf-liberation
```

**Wine (step 28):**
```
wine-cachyos
```

**Themes (step 29):**
```
lxappearance
arc-gtk-theme
papirus-icon-theme
```

**Utilities (step 29.5):**
```
brightnessctl
btop
openssh
polkit-gnome
```

**Graphics (step 31):**
```
nvidia-open
nvidia-utils
lib32-nvidia-utils
```

---

## PACKAGE COUNT COMPARISON

- **Plasma install:** ~200-300 packages
- **OpenBox install:** ~100-150 packages
- **Savings:** ~50% lighter! 🏆

---

## TROUBLESHOOTING

### Panel not starting?
```bash
pkill -9 -f tint2
tint2 &
```

### Wallpaper not loading?
```bash
nitrogen --restore &
```

### No network icon?
```bash
nm-applet &
```

### No permission dialogs?
```bash
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
```

### OpenBox menu not working?
```bash
# Right-click desktop should show menu
# If not, check ~/.config/openbox/menu.xml exists
```

---

## NOTES

- **obconf** and **obmenu** may not be available in standard repos
- You can configure OpenBox by editing `~/.config/openbox/rc.xml` manually
- Your existing OpenBox backup configs will work perfectly!
- KDE apps (konsole, dolphin, kate) work great in OpenBox
- LightDM is optional - startx method is lighter

---

## QUICK REFERENCE

**Start OpenBox:**
```bash
startx
```

**Restart OpenBox:**
```bash
openbox --reconfigure
```

**Reload autostart:**
```bash
openbox --restart
```

**Kill panel:**
```bash
pkill -9 -f tint2
```

**Start panel:**
```bash
tint2 &
```

**Configure display:**
```bash
arandr
```

**Set wallpaper:**
```bash
nitrogen ~/Pictures/
```

---

**INSTALLATION COMPLETE!** 🎉

You now have a minimal Arch Linux with OpenBox - **NO KDE PLASMA!** 🐧⚡

---

**Last updated:** December 2025  
**Based on:** AlexData's Minimal Arch Install Guide
