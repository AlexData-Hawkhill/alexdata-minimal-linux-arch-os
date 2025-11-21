# 🐧 FIREWALL FOR LINUX ARCH: 🐧
### KDE-PLASMA BASED FIREWALL GUI - FOR PLASMA DESKTOPS
The _Plasma-Firewall_ works very well with the KDE-PLASMA Desktop Environment!  
And the optional app "Open Snitch" will give you very detailed control over your network.
- [x] **firewalld** - The system firewall component - **Recommended!**
- [x] **plasma-firewall** - The GUI app for editing firewall rules - **Recommended!**
- [ ] **open-snitch** - Visual firewall GUI that shows more details, and lets you block based on the details - **Optional...**


<br><br>
  
# INSTALLING:
<hr>

### Install the firewall into the Arch system
```bash
sudo pacman -S firewalld  
```

### Enable the firewall you just installed
```bash
sudo systemctl enable --now  
```

### Install grapichal GUI to change basic firewall settings
```bash
sudo pacman -S plasma-firewall
```

### Install more advanced GUI for setting more advanced firewall rules
```bash
sudo pacman -S opensnitch
```

<br><br>

# ERRORS:
<hr>

### Errors - Then Check firewalld status:
```bash
sudo systemctl status firewalld
```

### Errors - Then Enable firewalld:
```bash
sudo systemctl enable --now firewalld
```

### Errors - Then Check if it's running:
```bash
sudo firewall-cmd --state  # Output expected: "running"
```

### Errors - Then Verify zones:
```bash
sudo firewall-cmd --get-active-zones
```

<br><br> 

# OPEN-SNITCH GUI
<hr>

### Install & Activate opensnitch so that you can control the firewall very detailed!
_Coming soon..._
- [ ] Installing...
- [ ] Setup...
- [ ] Daily Use...

