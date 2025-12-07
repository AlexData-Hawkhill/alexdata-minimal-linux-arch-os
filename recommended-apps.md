# 🐧 RECOMMENDED APPS 🐧

### System apps:
```bash
pacman -S gparted  # GUI Disk And Partition Manager
```
```bash
pacman -S ntfs-3g ntfstools # Gparted dependencies
```
```bash
pacman -S dosfstools mtools # Gparted dependencies
```
```bash
pacman -S octopi # App store for pacman and aur.
```
```bash
pacman -S nvtop # GPU VRAM taskmanager like info with live update!
```
```bash
pacman -S btop  # CPU CPU MEM taskmanager like info with live update!
```

<br>

Vivaldi browswer installing (flatpak):
```bash
sudo pacman -S flatpak --needed
```
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
```bash
flatpak install -y flathub com.vivaldi.Vivaldi
```
Vivaldi start command:
```bash
/bin/flatpak run --branch=stable --arch=x86_64 --command=vivaldi --file-forwarding com.vivaldi.Vivaldi @@u %U @@
```
What folder was Vivaldi installed to:
```bash
flatpak info --show-location com.vivaldi.Vivaldi
```
