# 🐧 AlexData-Minimal-Linux-Arch-OS [🐧](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

Current Progress For This Project:
- [x] Install instructions (_first edition - needs editing_) !!
      [Link](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/README.md#-alexdata-minimal-linux-arch-os-)
- [x] Installing apps and packages - near complete! 
      [Link-1](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/install-app-packages-pacman.md#-installing-apps-and-packages-in-linux-arch-)
      [Link-2](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/install-app-packages-paru.md#-installing-apps-and-packages-in-linux-)
- [x] Restart Desktop Environment - near complete! 
      [Link](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/restart-desktop-environment.md#-restart-desktop-environment-)
- [ ] Firewall Installation and Usage - started...
      [Link](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/firewall-for-arch.md#-firewall-for-linux-arch-)
- [x] Environment variables - near complete!
      [Link](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/environment-variables.md#-environment-variables---in-linux-os-)
- [ ] Recommended apps - started...
      [Link](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/recommended-apps.md#-recommended-apps-)
- [ ] File and Folder Access Issues - started...
      [Link-1](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/file-and-folder-access.md#-taking-ownership-over-files-folders-and-drives-)
      [Link-2](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/errors-on-disk-file-access.md#-cannot-access-the-boot-partiton-fat32-format-)
- [ ] System backup - started... (_many scripts written - none uploaded yet_)
      [Link](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/system-backup.md#-backing-up-your-linux-arch-system-)
- [ ] Better readability for all files - started...
      [Link]()
- [ ] Error handling when installing ARCH OS from USB OR DVD...
      [Link]()
- [ ] Error handling when OS is up and running...
      [Link]()
- [ ] Checks to perform after first boot (firewall, mounts, app-packages, update, m.m) - indirectly started...
      [Link-1](https://github.com/AlexData-Hawkhill/alexdata-minimal-linux-arch-os/blob/main/firewall-for-arch.md#-firewall-for-linux-arch-)
      [Link-2](coming-soon)

My personal instructions for how to install a minimal Linux Arch OS.  
The machine has a MSI motherboard, i9 CPU, 32gb ram, rtx5070, 12gb vram, M2.ssd + S-ata HDD.  
In this scenario this is a dual-boot with windows being installed on the M2.ssd (for now).  
While Linux is installed to the S-ata HDD (its partition 1[boot] and 4[root], partition 2 and 3 holds data.  

🔥 **NB: PS: NEEDED: safeboot & TPM disabled in UEFI/BIOS. Fastboot, update, defender disabled in windows.**  

🔥 **NB: PS: NEEDED: ventoy-usb setup with Linux ISO files, as well as a grub config to load partitions (F6 menu).**  

🔥 **NB: PS: NEEDED: network-cable based internet - for speed and to avoid broken downloads.**  

_(more details on this may be added later - in a separate document - or right into this one)._  

🐧 This is a fully hands-on-manual-labour-operation - nothing is currently automated during this install.  
If you're new to linux - try installing a few distro's first. CachyOS is the one closest to what this guide does!  
Since this is a minimal install, where the system is built piece by piece, package by package.  
The guide currently starts from the point where you have booted from your VENTOY usb, into the Arch Linux ISO.  
And you're presented with a bash login prompt.  

🔥 **_NB: PS: Following this guide WILL GUARANTEED delete or owerwrite files, folders, partitions, and possibly whole disks!!_**  
🔥 **_NB: PS: So follow this guide on your own risk! Best practice: Try it out on a new blank virtual machine first! (safe - causes no real damage to personal files)._**  


# INSTALL ARCH LINUX - FROM VENTOY USB (WITH ARCH LINUX ISO):  
Boot from VENTOY USB into ARCH LINUX OS - ISO file.  

## 0. SHELL HOT-SWAPPING DURING INSTALL (TTY)(F1):  
LOGIN AS ROOT IN TTY1 (F1) BASH SHELL.  
You're now on TTY1 (virtual bash shell 1).  
Here you will open the Install Guide so you can read it during install.  

Press CTRL+ALT+F2 to enter TTY2 (virtual bash shell 2).
LOGIN AS ROOT IN TTY2 (F2) SHELL.
There you can run the actual install commands written below.

Switch back to the open Install Guide by pressing CTRL+ALT+1
This way you can switch back and forth between Help-Guide-Space and Actual-Install-Space.

(CTRL+ALT+ F1-F6 = Virtual Bash Sessions - swap between them by using said hotkeys)
(CTRL+ALT+ F7-F8 = Virtual Desktop Sessions - if any x11, wayland, kwin, or any desktop-environment is loaded there)
THEN PRESS (ALT+CTRL+F2) AND USE THIS SHELL FOR THE ACTUAL INSTALL COMMANDS! (ALT+CTRL+F1) FOR THE HELP INSTALL DOCUMENT!


## 1. Setup the install environment 
```
loadkeys no
pacman -Sy nano
cd /
mkdir help
mount /dev/sda2 /help/ # A partiton with help files like this one.
nano ArchOS-Minimal-Install-Guide_16nov2025.md #(the-file-you're-now-reading)

# ALTERNATIVE-KBD-LAYOUTS:
# loadkeys us
# loadkeys de-latin1
```

## 2. Verify Boot Mode
```
cat /sys/firmware/efi/fw_platform_size
# Returns 64 = UEFI 64-bit (good! proceed!)
# Returns 32 = UEFI 32-bit (may work, but limited)
# No output = BIOS mode (wont fully work!)
```

## 3. Connect to Internet
```
ip link                              # OK List network interfaces available
ping archlinux.org                   # OK Test connection - Press CTRL+C to exit ping!
```

## 4. Update System Clock
```
timedatectl                          # OK Check time sync status
```

## 5. Identify Connected Disks
```
fdisk -l                             # OK List all disks with many details
lsblk                                # OK Tree view of disks - easy to read
```

## 6. Partition The Disk
```
fdisk /dev/sda                       # OK Or nvme0n1, etc. I use my S-ata disk!

# Minimum partitions needed:
# 1. EFI System Partition (ESP) - 512MB - FAT32
# 2. Root partition (/) - Rest of disk - EXT4
# Optional: Swap partition

# Example layout:
# /dev/sda1 = 512MB   = EFI (type: EFI System)
# /dev/sda4 = 25GB+   = Root (type: Linux filesystem)
#/dev/sda? = 2GB     = Swap (type: Linux swap  if created - optional)
```

## 7. Format Partitions
```
mkfs.fat -F32 /dev/sda1              # OK Format EFI partition SDA1 as FAT32 file format
mkfs.ext4 /dev/sda4                  # OK Format root SDA4 as EXT4 file format
#mkswap /dev/sda?                     # Optional - Initialize swap if created - optional
```

## 8. Mount Partitions
```
mount /dev/sda4 /mnt                 # OK Mount EXT4 root partition /mnt/
mount --mkdir /dev/sda1 /mnt/boot    # OK Mount EFI boot partition to /mnt/boot/
#swapon /dev/sda2                     # Optional - Enable swap if created - optional
```

## 9. Select Fastest Mirrors (Optional) - Use reflector:
```
reflector --country Norway,Sweden --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Edit mirror list (put fastest mirror on top)
# nano /etc/pacman.d/mirrorlist (USE ABOVE INSTEAD! FASTER! AUTO! PS:IGNORE WARNINGS!)
```

## 10. Install Base System

### Minimal base system:
```
pacstrap -K /mnt base linux linux-firmware  # OK (sometimes show ERR: /etc/vconsole.conf)
```

### Add essential tools:
```
pacstrap -K /mnt base-devel networkmanager sudo nano
```

### Add CPU microcode:
```
pacstrap -K /mnt intel-ucode         # OK For Intel (not using AMD: amd-ucode)
```

**What each package is and does:**
- `base` = Core system utilities
- `linux` = ArchOS optimized kernel
- `linux-firmware` = Hardware drivers/firmware
- `base-devel` = Development tools (gcc, make, etc.)
- `networkmanager` = Network management
- `sudo` = Run commands as admin (alternative is: su - )
- `nano` = Text editor (F3 saves, CTRL+X exits nano)

## 11. Generate fstab
```
genfstab -U /mnt >> /mnt/etc/fstab   # OK Generate filesystem table (by UUID)
cat /mnt/etc/fstab                   # OK Verify it looks correct by reading it.
```

## 12. Chroot into New System (Load it as a virtual filesystem that can be modified)
```
arch-chroot /mnt                     # Enter new system virtually (as if it was a virtual os)
```

## 13. Set Timezone
```
ln -sf /usr/share/zoneinfo/Europe/Oslo /etc/localtime # OK Set timezone with a symlink.
hwclock --systohc                                     # OK Generate /etc/adjtime.
```

## 14. Set Locale
```
nano /etc/locale.gen                        # OK Edit this file to edit the OS language.
# Uncomment: "en_US.UTF-8 UTF-8" line       # This enables US English language for the OS.
locale-gen                                  # OK Generate locales to be used in the OS.
echo "LANG=en_US.UTF-8" > /etc/locale.conf  # OK Add this info to locale file too.
```

## 15. Set Keyboard Layout (Persistent)
```
echo "KEYMAP=no" > /etc/vconsole.conf       # OK Copy here so that console also uses this layout.
```

## 16. Set Hostname / Computer-name
```
echo "arch-alexdata" > /etc/hostname        # OK Set your preferred username.
```

## 17. Set Root Password for the ROOT account
```
passwd                               # OK Set root password (important!)
```

## 18. Create Normal Day-To-Day User Account
```
useradd -m -G wheel -s /bin/bash alexdata  # OK
passwd alexdata                            # OK Set user password
```

### Enable normal account for wheel group (gives user sudo rights):
```
EDITOR=nano visudo                            # Opens "visudo" file for adding your user to a new group.
# Uncomment line: %wheel ALL=(ALL:ALL) ALL    # Adds you to the group that has sudo install rights.

# If any sudo errors:
#pacman -S sudo                               # Install sudo first! (or try with "su -")
#EDITOR=nano visudo                           # Then this nano edit will work
```

## 18.5 ADDED NEW ADDITIONAL REPOS TO DOWNLOAD PACKAGES FROM !!
NB: PS: changed this method - see 18.7 below instead!

Step 18.6 - USE 18.7 BELOW INSTEAD !!!!  Add CachyOS Repos (DURING INSTALL)
```
pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key F3B607488DB35A47
```
Install CachyOS packages:
```
pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
          'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-18-1-any.pkg.tar.zst' \
          'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst'
```
Edit "pacman.conf" and add CachyOS repos at top:
```
nano /etc/pacman.conf
```
Update databases:
```
pacman -Sy
```

## 18.7 CACHYOS AUTO-INSTALLER:
Download and run CachyOS repo installer script:
```
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
cd cachyos-repo
sudo ./cachyos-repo.sh
```
This CachyOS script:
✅ Detects your CPU capabilities (v3 or v4)
✅ Downloads correct packages automatically
✅ Adds CachyOS repos to /etc/pacman.conf
✅ Installs mirrorlist files
✅ Updates package databases

### FIX - ALSO ADD MULTILIB 32BIT SUPPORT TO THE LIST:
1. Edit pacman.conf:
```
sudo nano /etc/pacman.conf
```
2. Find these lines (they're commented out):
#[multilib]
#Include = /etc/pacman.d/mirrorlist

3. Uncomment them (remove the #):
[multilib]
Include = /etc/pacman.d/mirrorlist

4. Save (F3/Ctrl+O, Enter, Ctrl+X)

5. Update package databases:
```
sudo pacman -Sy
```

## WINE - IF YOU NEED TO RUN WINDOWS PROGRAMS
Install wine support - use windows apps directly in Linux:
```
sudo pacman -S wine-cachyos
```
Install winetricks for help with installing windows-programs
Winetricks is in the AUR REPOSITORY (Arch User Repository) , use paru wrapper for pacman:
```
paru -S winetricks
```

# Then install one of these lines:
```
# I Recommend this:
sudo pacman -S wine-cachyos winetricks # This combo is best of both worlds.

# Alternatives:
sudo pacman -S wine-staging winetricks # Combo of the older method and helper.
sudo pacman -S wine-cachyos            # This variant is fast.
sudo pacman -S wine-staging            # This variant is feature rich.
sudo pacman -S winetricks              # Helper for easier installs of win progs.
```

## 19. Install Boot Loader (systemd-boot)
```
bootctl install                      # OK Install to EFI partition
```

### Create boot entry:
```
nano /boot/loader/entries/arch.conf
```

### Add these lines to "arch.conf" file:
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=/dev/sda4 rw               # OK Replace sdaX with your actual / root partition
[F3 to save. CTRL+X to exit nano]

### Configure "loader.conf" file OK:
```
nano /boot/loader/loader.conf
```

### Add these lines to "loader.conf" file OK:
default  arch.conf
timeout  4
console-mode max
editor   no
[F3 to save. CTRL+X to exit nano]


## 20. Install Display Server (X11)
```
pacman -S xorg-server xorg-xinit # OK
```

## 21. Install Window Manager & Desktop
```
pacman -S kwin plasma-desktop plasma-workspace plasma-workspace-wallpapers # OK
```

## 22. Install Display Manager
```
pacman -S sddm                       # OK Login manager
systemctl enable sddm                # OK Auto-start on boot
```

## 23. Install Essential KDE Apps
```
pacman -S konsole dolphin kate spectacle # OK
```

## 24. Install Network Management
```
pacman -S plasma-nm                  # OK NetworkManager KDE frontend
systemctl enable NetworkManager      # OK Enable network on boot
```

## 25. Install Firewall
```
pacman -S firewalld plasma-firewall  # OK Firewall(d) + Plasma KDE based firewall GUI
systemctl enable firewalld           # OK Enable firewall on boot
#pacman -S opensnitch                # OK More visual firewall gui with more options!
```
## 26. Install Audio System
```
pacman -S pipewire pipewire-pulse pipewire-alsa wireplumber plasma-pa # OK
```

IF INSTALLED AFTER OS IS INSTALLED:
```
sudo pacman -S plasma-pa
killall plasmashell && plasmashell &
```   

## 27. Install Fonts for OS:
```
pacman -S noto-fonts noto-fonts-emoji ttf-liberation # OK
```

## 28. Install Wine (For Windows Apps)
```
pacman -S wine-cachyos               # Run Windows apps (FL Studio, etc.)
```
⚠️ **_MOVE WHAT IS WRITTEN ABOUT WINE FURTHER UP - DOWN HERE!_**

## 29. Install Additional Tools
```
pacman -S breeze-gtk                 # OK Make GTK apps match KDE apps in visual looks!
```

## 29.5 ALSO A MUST TO HAVE THESE PACKAGES AND APPS

### Also install these KDE control modules:
```
sudo pacman -S kscreen                   # Install display configuration module:
sudo pacman -S powerdevil                # Power management
sudo pacman -S plasma5support            # Legacy support
sudo pacman -S kinfocenter               # Infocenter about the computer
sudo pacman -S brightnessctl             # Taskbar-icon-scroll-to-dim-sceen(s).
sudo pacman -S breeze-gtk                # GTK theme compatibility
 
sudo pacman -S btop                      # Info on the CPU GPU DISKS MEM ++
sudo pacman -S openssh                   # Remote SSH, SFTP, SCP to other servers / local-machines.

sudo reboot                              # Logout and login again (or reboot)
```
### IF USING BLUETOOTH DEVICES - OR CONNECTING LINUX--ANDRIOD-PHONES:
```
#sudo pacman -S bluedevil                 # Bluetooth (only if needed)
```

## 30. Enable Essential Services
```
systemctl enable NetworkManager      # OK Network
systemctl enable firewalld           # OK Firewall
systemctl enable sddm                # OK Login screen
```

### 31. Screen drivers!
```
sudo pacman -S nvidia-open nvidia-utils # For 4-xx and 5-xx series cards (post ai revolution.)
sudo pacman -S lib32-nvidia-utils       # Settings type utilities (both desktop and bash)
sudo pacman -S systemsettings           # If not added before - add now to be able to change display setts.
sudo pacman -S egl-wayland              # Gives display driver wayland support!
```
```
#sudo pacman -S nvidia                   # For older nvidia cards (pre ai revolution)
```

## 32. Exit & Reboot into installed OS
```
exit                                 # OK Exit chroot
umount -R /mnt                       # OK Unmount partitions
#lbfsk
reboot                               # OK Restart!
```


## 33. install paru from git # NOT DONE (after booting into OS)
⚠️ Steps missing - These steps will be added soon...
NB: PS: WRITE IN GRUB RESCUE EFI RENAME FIX STUFF HERE AND ALSO AT THE BEGINNING OF THIS FILE !!



### SCREEN DRIVER TIPS -:
At login screen (SDDM):
Click session dropdown (bottom-left)
Look for "Plasma (Wayland)"

TIP this returns: x11 or wayland (shows current actually used display server!)
```echo $XDG_SESSION_TYPE```


TIP Remove old driver:
```sudo pacman -R nvidia```

TIP Install correct drivers for RTX 5070:
```sudo pacman -S nvidia-open nvidia-utils lib32-nvidia-utils```

TIP X11 display config tool (if on X11)
```sudo pacman -S xorg-xrandr```

TIP If you want Wayland support:
```sudo pacman -S egl-wayland```

TIP If wayland is not available then:
```
sudo pacman -S plasma-wayland-session
sudo reboot
```

Command Line (X11 - if GUI doesn't work):
List connected displays:
```xrandr```

Example output:
_DP-0 connected 1920x1080 (your horizontal monitor)_
_DP-2 connected 1920x1080 (your vertical monitor)_
_HDMI-0 disconnected_

Enable both monitors:
```
xrandr --output DP-0 --mode 1920x1080 --primary
xrandr --output DP-2 --mode 1920x1080 --rotate left --right-of DP-0
```

For your actual setup (adjust names/resolutions):
```
xrandr --output DP-0 --mode 2560x1440 --primary --rotate normal
xrandr --output DP-2 --mode 1920x1080 --rotate left --right-of DP-0
```
Replace DP-0 and DP-2 with your actual output names from xrandr

DIAGNOSTIC COMMANDS - Check what's running:
```
echo $XDG_SESSION_TYPE           # x11 or wayland
ps aux | grep kwin               # See if kwin_x11 or kwin_wayland
```

Check NVIDIA driver:
```
nvidia-smi                       # Should show RTX 5070
```

Check displays:
```
xrandr                           # List connected monitors (X11 only)
```

Check graphics:
```
glxinfo | grep "OpenGL renderer" # Should show NVIDIA
```

----------------------------------------------------------------------------
pacman search for packets online, with additional info displayed about them:
----------------------------------------------------------------------------
Search for package in sync databases (online repos):
```pacman -Ss vlc```

More detailed info about specific package:
```pacman -Si vlc```

With paru (searches repos + AUR):
```paru -Ss vlc```

Show only package names (cleaner output):
```pacman -Ssq vlc```


-------------------------------
Add CachyOS Repos to Your Arch:
--------------------------------

1. Import CachyOS GPG key:
```
sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key F3B607488DB35A47
```

2. Install CachyOS keyring and mirrorlist:
```
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst'
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-18-1-any.pkg.tar.zst'
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst'
sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-6.1.0-7-x86_64.pkg.tar.zst'
```

3. Edit pacman.conf:
```
sudo nano /etc/pacman.conf
```

4. Add these lines at the TOP (righh before the [core] section):
[cachyos-v3]
Include = /etc/pacman.d/cachyos-v3-mirrorlist

[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist

5. Update package databases:
```sudo pacman -Sy```

6. NOW you can install CachyOS packages:
```sudo pacman -S wine-cachyos linux-cachyos```

-----------------------------------
Commands to remove unused packages:
-----------------------------------
```du -sh size folder```
```df -kh size mounted partitions```

Orphaned packages (installed as dependencies but no longer needed):
```paru -Qtdq              # list orphaned packages```
```paru -Rns $(paru -Qtdq) # remove orphaned packages```

Package cache cleanup:
```paru -Sc     # clean old package cache (keeps current versions)```
```paru -Scc    # clean ALL package cache```
```paccache -r  # keep only last 3 versions```

```sudo pacman -Sc   # clean old package cache (keeps current versions)```
```sudo pacman -Scc  # clean ALL package cache!```


Other cleanup commands:
```pacman -Qdtq            # list orphaned packages (pacman version)```
```pacman -Rns packagename # remove package plus dependencies.```

Remove all orphaned packages:
```paru -Rns $(paru -Qtdq)```

Or with sudo + pacman:
```sudo pacman -Rns $(pacman -Qtdq)```

Keep only last 3 versions of each package (best balance):
```sudo paccache -r```

Install paccache if missing:
```sudo pacman -S pacman-contrib```

Remove package and its dependencies (if nothing else needs them):
```sudo pacman -Rns package_name```

------------------------------
LIST ALL INSTALLED PACKAGES:
------------------------------
List all explicitly installed packages:
```pacman -Qe```

List all packages (including dependencies):
```pacman -Q```

Count total packages:
```pacman -Q | wc -l```

Show package sizes:
```pacman -Qi | grep 'Installed Size' | awk '{sum+=$4} END {print sum/1024 " MB"}'```

------------------------------
FIND LARGE INSTALLED PACKAGES:
------------------------------
List packages by size (largest first) (head -20 is where you define how many to list):
```pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -rh | head -20```


------------------------
COMPLETE CLEANUP SCRIPT:
------------------------
```
#!/bin/bash
# clean-arch.sh - Complete system cleanup

echo "🧹 Starting Arch Linux cleanup..."

# 1. Remove orphaned packages:
echo "🗑️  Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "No orphans found"

# 2. Clean package cache (keep last 3 versions):
echo "📦 Cleaning package cache..."
sudo paccache -r

# 3. Clean paru/AUR cache:
echo "🔧 Cleaning AUR cache..."
paru -Sc --noconfirm

# 4. Remove old journal logs (keep last 7 days):
echo "📜 Cleaning old logs..."
sudo journalctl --vacuum-time=7d

# 5. Show disk space saved:
echo "💾 Disk usage:"
df -h / | tail -1

echo "✅ Cleanup complete!"
Save as clean-arch.sh, make executable:
bashchmod +x clean-arch.sh
./clean-arch.sh
```
----------------------------
FOR YOUR REINSTALL PRACTICE:
----------------------------
Quick System Reset (Keep Home Directory):
1. List explicitly installed packages (save for later):
```
pacman -Qe > ~/installed-packages.txt
```

2. Boot USB, format root partition (NOT home!):
```
mkfs.ext4 /dev/sda4
```

3. Reinstall base system using this document.

4. After install, reinstall your saved packages:
```
cat ~/installed-packages.txt | awk '{print $1}' | xargs sudo pacman -S --needed
```
Complete Wipe (Fresh Start):
```
# Boot USB
# Format everything:
mkfs.fat -F32 /dev/sda1     # EFI
mkfs.ext4 /dev/sda4         # Root
# Follow install guide from scratch
```

------------------------
AUTOMATION SCRIPT IDEAS:
------------------------
1. Package List Backup:
```
#!/bin/bash
# backup-packages.sh
pacman -Qe > ~/packages-explicit.txt
pacman -Qm > ~/packages-aur.txt
echo "✅ Package lists backed up!"
```

2. Quick Reinstall All:
```
#!/bin/bash
# restore-packages.sh
sudo pacman -S --needed $(cat ~/packages-explicit.txt | awk '{print $1}')
paru -S --needed $(cat ~/packages-aur.txt | awk '{print $1}')
```

3. Minimal Install Post-Script:
```
#!/bin/bash
# post-install.sh - Run after minimal Arch install

# Update system:
sudo pacman -Syu

# Install display config:
sudo pacman -S kscreen powerdevil

# Install nvidia:
sudo pacman -S nvidia-open nvidia-utils

# Install AUR helper:
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si

# Enable services:
sudo systemctl enable NetworkManager firewalld sddm

echo "✅ Post-install complete! Reboot now."
```

-----------------------------------
MOST USEFUL FOR REINSTALL PRACTICE: 🐧🔥
-----------------------------------
```
# Before reinstall - save your package list:
pacman -Qe > ~/my-packages.txt

# After fresh install - restore everything:
sudo pacman -S --needed $(cat ~/my-packages.txt | awk '{print $1}')
# This way you can practice reinstalling without losing your package choices!
```
HAVE FUN PRACTICING REINSTALLS! 🐧🔥
The orphan packages cleanup command:
```(paru -Rns $(paru -Qtdq))```
That's a "remove unused packages" command!




============================
GET ARCH OS BOOTING - ATTEMPT 2 -- fixed by renmaing /EFI/ folders and files (alphanum)
============================

AH-HA! THE REAL CULPRIT REVEALED!
Your boot entry is CORRECT now! But look at your EFI partition:
X:\EFI\          ← OLD CachyOS boot entries still here!
X:\loader\       ← NEW systemd-boot config (correct!)
The problem: Your UEFI firmware is still trying to boot the OLD GRUB from /EFI/cachyos/ or /EFI/boot/ instead of the NEW systemd-boot from /loader/!
DELETE /SDA1/EFI folder (or rename so it wont be detected and used by UEFI)


OR VIA SOME LINUX LIVECD:
# Mount EFI partition:
```mount /dev/sda1 /mnt```
# See what's in EFI folder:
```ls -la /mnt/EFI/
# You'll probably see:
# /mnt/EFI/systemd/      ← systemd-boot (good!)
# /mnt/EFI/cachyos/      ← old GRUB (bad!)
# /mnt/EFI/boot/         ← old fallback (bad!)
# Delete old entries:
rm -rf /mnt/EFI/cachyos
rm -rf /mnt/EFI/boot
# Reinstall bootloader (updates UEFI boot order):
mount /dev/sda4 /mnt2
arch-chroot /mnt2
bootctl install --esp-path=/boot
exit
```
Reboot:
```
umount -R /mnt /mnt2
reboot
```

IF IT STILL DOESN'T BOOT:
Plan B - Create Fallback Entry:
The UEFI standard says: Always try /EFI/boot/bootx64.efi first as fallback.
If systemd-boot doesn't show up, create a fallback that points to it:
From Windows:
X:
```
cd EFI
mkdir boot
copy systemd\systemd-bootx64.efi boot\bootx64.efi
```

UEFI BOOT ORDER - EDIT From live linux USB:
```efibootmgr -v                    # List all boot entries```
Delete old GRUB entry (example):
```efibootmgr -b 0001 -B            # Replace 0001 with actual GRUB entry number```
Set systemd-boot as default:
```efibootmgr -o 0000               # Replace 0000 with systemd-boot entry```



WHAT TO DO NOW:
Option A (Quick Fix):

Boot USB
Mount & chroot
Fix /boot/loader/entries/arch.conf with correct kernel names
Fix options root=/dev/sda4
Reboot

Option B (Easier Long-term):

Boot USB
Mount & chroot
Install GRUB instead (auto-detects everything)
Reboot

step 18.5 (added to list above)
pacman -S sudo        # Install sudo first!
EDITOR=nano visudo    # Then this will work




QUICK FIX - BOOT FROM USB AGAIN:
1. Boot from Arch USB/Ventoy
2. Login as root

3. Mount your system:
```
mount /dev/sda4 /mnt
mount /dev/sda1 /mnt/boot
```

4. Chroot:
```arch-chroot /mnt```

5. Fix the boot entry:
```nano /boot/loader/entries/arch.conf```

6. Make the file look EXACTLY like this:
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=/dev/sda4 rw

Save (Ctrl+O, Enter, Ctrl+X)

7. Verify files exist:
```
ls -la /boot/
# Should see:
# vmlinuz-linux
# initramfs-linux.img
# intel-ucode.img
```

8. Reinstall bootloader (just to be sure):
```bootctl install```

9. Exit and reboot:
```
exit
umount -R /mnt
reboot
```

IF THAT DOESN'T WORK - ALTERNATIVE: INSTALL GRUB:
GRUB is more forgiving and auto-detects kernels.

After mounting and chrooting as above:
Install GRUB:
```pacman -S grub efibootmgr```

Install to EFI:
```grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB```

Generate config (auto-detects kernel!):
```grub-mkconfig -o /boot/grub/grub.cfg```

Exit and reboot:
```
exit
umount -R /mnt
reboot
```

`GRUB 2` is easier for beginners because `grub-mkconfig` auto-detects everything!



# SCRIPTED INSTALL APPROACH
### ...MAKE A LIST OF ALL INSTALLED PACKAGES WHEN EVERYTHING IS INSTALLED AND WORKS - THEN ADD PACKAGES TRO THIS SCRIPT...
INSTALL EVERTYTHING WE END UP INSTALLING, BY RUNNING THIS SCRIPT AFTER OS INSTALL VIA VENTOY
(USE THE SCRIPT FOR FINDING ALL INSTALLED PACKAGES - TO PROPAGATE THE LIST IN THE FOLLOWING SCRIPT - OR SORT BY USER INSTALLED PACKAGES IF POSSIBLE!)
https://claude.ai/chat/27831315-3fd6-4bab-bcff-e011da08e87b


#!/bin/bash
echo "Checking Wine dependencies..."

packages=(
    "lib32-libpulse"
    "lib32-alsa-lib"
    "lib32-portaudio"
    "lib32-mesa"
    "lib32-gnutls"
    "lib32-mpg123"
)

for pkg in "${packages[@]}"; do
    if pacman -Q "$pkg" &>/dev/null; then
        echo "✅ $pkg installed"
    else
        echo "❌ $pkg NOT installed"
    fi
done

echo ""
echo "Checking Wine components..."
if [ -d ~/.wine/drive_c/windows/system32/gecko ]; then
    echo "✅ wine-gecko present"
else
    echo "❌ wine-gecko missing"
fi

if [ -d ~/.wine/drive_c/windows/mono ]; then
    echo "✅ wine-mono present"
else
    echo "❌ wine-mono missing"
fi

# chmod +x check-wine.sh
# ./check-wine.sh



# SAVE YOUR PACKAGE LIST FOR REINSTALLS:Save Explicitly Installed Packages:
### Save your package list:
pacman -Qe > ~/installed-packages.txt

### View it:
cat ~/installed-packages.txt

Save EVERYTHING (Including Dependencies):
bash# Save complete list:
pacman -Q > ~/all-packages.txt

# Count total:
pacman -Q | wc -l

RESTORE PACKAGES AFTER REINSTALL:
Method 1: Restore Explicit Packages (Recommended):
bash# After fresh install, restore your packages:
sudo pacman -S --needed $(cat ~/installed-packages.txt | awk '{print $1}')

# Restore AUR packages:
paru -S --needed $(cat ~/installed-aur-packages.txt | awk '{print $1}')
Method 2: Create Backup Script:
bash# Create backup script:
nano ~/backup-packages.sh
Add:
bash#!/bin/bash
# Package backup script
DATE=$(date +%Y%m%d)
BACKUP_DIR=~/package-backups

mkdir -p $BACKUP_DIR

echo "📦 Backing up package lists..."

# Explicit packages (what you installed):
pacman -Qe > $BACKUP_DIR/explicit-$DATE.txt
echo "✅ Saved explicit packages"

# AUR packages:
pacman -Qm > $BACKUP_DIR/aur-$DATE.txt
echo "✅ Saved AUR packages"

# All packages (including dependencies):
pacman -Q > $BACKUP_DIR/all-$DATE.txt
echo "✅ Saved all packages"

# Package database (for exact versions):
tar czf $BACKUP_DIR/pacman-db-$DATE.tar.gz /var/lib/pacman/local/

# Config files:
cp /etc/pacman.conf $BACKUP_DIR/pacman.conf-$DATE
cp /etc/pacman.d/mirrorlist $BACKUP_DIR/mirrorlist-$DATE

echo ""
echo "📦 Backup complete!"
echo "Location: $BACKUP_DIR"
ls -lh $BACKUP_DIR/*$DATE*
Make executable:
bashchmod +x ~/backup-packages.sh
./backup-packages.sh

CREATE RESTORE SCRIPT:
bashnano ~/restore-packages.sh
Add:
bash#!/bin/bash
# Package restore script

if [ ! -f ~/installed-packages.txt ]; then
    echo "❌ No package list found!"
    echo "Run backup-packages.sh first!"
    exit 1
fi

echo "📦 Restoring packages..."
echo ""

# Update system first:
echo "🔄 Updating system..."
sudo pacman -Syu

# Restore official packages:
echo "📥 Installing official packages..."
sudo pacman -S --needed $(cat ~/installed-packages.txt | grep -v "local" | awk '{print $1}')

# Restore AUR packages (if paru is installed):
if command -v paru &> /dev/null; then
    echo "📥 Installing AUR packages..."
    paru -S --needed $(cat ~/installed-aur-packages.txt | awk '{print $1}')
else
    echo "⚠️  paru not installed, skipping AUR packages"
    echo "Install paru first, then run this script again"
fi

echo ""
echo "✅ Restore complete!"
echo "Reboot recommended: sudo reboot"
Make executable:
bashchmod +x ~/restore-packages.sh

YOUR CURRENT MINIMAL ARCH PACKAGE LIST:
Let me create a snapshot of your current setup:
bash# Save current setup:
cat > ~/my-minimal-arch-setup.txt << 'EOF'
# AlexData's Minimal Arch Setup
# Date: $(date)

## Base System
base
linux
linux-firmware
base-devel
intel-ucode

## Boot
systemd-boot

## Display Server
xorg-server
xorg-xinit

## Desktop Environment
kwin
plasma-desktop
plasma-workspace
sddm
systemsettings
kscreen
powerdevil

## Essential Apps
konsole
dolphin
kate
spectacle

## Network
networkmanager
plasma-nm

## Firewall
firewalld
plasma-firewall

## Audio
pipewire
pipewire-pulse
pipewire-alsa
wireplumber
plasma-pa

## Graphics
nvidia-open
nvidia-utils

## Wine + Audio Production
wine-cachyos
(81 lib32 packages - see full list)

## Fonts
noto-fonts
noto-fonts-emoji
ttf-liberation

## Tools
nano
sudo
python
python-pip
breeze-gtk

## AUR
paru (AUR helper)
opensnitch (network monitor)

Total packages: $(pacman -Q | wc -l)
Total explicit: $(pacman -Qe | wc -l)
Total lib32: 81
EOF

QUICK BACKUP ALIAS (Add to ~/.bashrc):
bash# Add this to ~/.bashrc:
alias backup-pkgs='pacman -Qe > ~/installed-packages-$(date +%Y%m%d).txt && echo "✅ Packages backed up to ~/installed-packages-$(date +%Y%m%d).txt"'

# Reload:
source ~/.bashrc

# Now you can just type:
backup-pkgs

ADVANCED: CREATE FULL SYSTEM SNAPSHOT:
bash# Complete system backup script:
nano ~/full-system-backup.sh
bash#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=~/system-backup-$DATE

mkdir -p $BACKUP_DIR

echo "🔧 Creating full system backup..."

# Packages
pacman -Qe > $BACKUP_DIR/packages-explicit.txt
pacman -Qm > $BACKUP_DIR/packages-aur.txt
pacman -Q > $BACKUP_DIR/packages-all.txt

# Configs
cp /etc/pacman.conf $BACKUP_DIR/
cp /etc/pacman.d/mirrorlist $BACKUP_DIR/
cp ~/.bashrc $BACKUP_DIR/bashrc
cp ~/.xprofile $BACKUP_DIR/xprofile 2>/dev/null

# Display config
cp ~/.local/share/kscreen/* $BACKUP_DIR/ 2>/dev/null

# Installed kernels
uname -r > $BACKUP_DIR/kernel-version.txt

echo "✅ Backup complete: $BACKUP_DIR"
tar czf ~/system-backup-$DATE.tar.gz -C ~ system-backup-$DATE/
echo "📦 Archive: ~/system-backup-$DATE.tar.gz"

NOW YOU HAVE:
✅ 81 lib32 packages (Wine fully supported!)
✅ Package backup commands
✅ Restore scripts for reinstalls
✅ Complete system snapshot capability

Last edit:
AlexData 17.nov.2025
