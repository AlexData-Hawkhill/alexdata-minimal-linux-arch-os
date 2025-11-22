# POLKIT - HANDLES SECURITY IN LINUX
Polkit Handles Firewall - Mounted Disks - And More...  
If the PolicyKit stops working for unknown reasons, you will get weird errors like:  
![Image of one of many possible polkit errors](/images/polkit-error-1.webp)

<br><br>

## CHECK LIST FOR WHEN YOU GET A POLKIT ERROR:

### 1. Check if polkit daemon is running:
```bash
systemctl status polkit
```

### 2. Check if KDE's authentication agent is running:
```bash
ps aux | grep polkit-kde-authentication-agent
```

### 3. Check what user it's running as:
```bash
ps aux | grep polkit | grep -v grep
```

### 4. Check if dbus session is working:
```bash
echo $DBUS_SESSION_BUS_ADDRESS
```

### 5. Check mounted filesystems:
```bash
mount | grep SHARED-LINUX
```

### 6. Check permissions on the mount point:
```bash
ls -la /run/media/$USER/
```

Or wherever your "SHARED-LINUX" drive, partition or filesystem is mounted.  
Check with:   
```bash
lsblk -f          # Easy to read!
```
```bash
df -kh            # Easy to read!
```
```bash
sudo parted -l    # Easy to read!
```
```bash
fdisk -l           # Harder to read!
```
```bash
mount              # Harder to read!
```

# Restart the POLKIT to make things work again:
```bash
sudo systemctl restart polkit
```
