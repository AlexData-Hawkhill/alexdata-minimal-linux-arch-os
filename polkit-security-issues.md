# POLKIT - HANDLES SECURITY IN LINUX
Polkit Handles Firewall - Mounted Disks - And More...  
If the PolicyKit stops working for unknown reasons, you will get weird errors like:

<br>

**_Errors when accessing mounted disks_**
![Another image of a polkit error](/images/polkit-error-1.webp)

<br>

**_Errors when accessing network firewall settings_**
![Another image of a polkit error](/images/polkit-error-2.webp)

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

### FIX 1 - THE POLKIT OR POLKIT AGENT ISSUES  
Restart the POLKIT to perhaps get things working again:  
```bash
sudo systemctl restart polkit
```

### FIX 2 - RESTART AUTHENTICATION AGENT (Not the polkit daemon!):
The issue isn't likely the polkit (the daemon itself), it's the authentication agent (the GUI popup handler)!
Kill any existing agents:  
```bash
killall polkit-kde-authentication-agent-1
```

Start the policy kit agent again:  
```bash
/usr/lib/polkit-kde-authentication-agent-1 &
```
Test by clicking "SHARED-LINUX" (or your problematic filesystem/drive) again in Dolphin:  


### FIX 3 - DBUS SESSION ISSUE:  
If the agent can't communicate with the polkit itself, it might be a D-Bus issue:  
Check if D-Bus session exists:  
```bash
echo $DBUS_SESSION_BUS_ADDRESS    # Expected result: "unix:path=/run/user/1000/bus" or very similar!
```

If the DBUS OUTPUT is empty or wrong, then export DBUS (explain why later?):  
```bash
export $(dbus-launch)
```

Restart the polkit agent again:  
```bash
killall polkit-kde-authentication-agent-1
```
```bash
/usr/lib/polkit-kde-authentication-agent-1 &
```

<!--
test accessing the mount again...if error, then likely this error
polkit-err-3  fits around here
-->


FIX 4 - MOUNT PERMISSION ISSUE:  
Maybe SHARED-LINUX is mounted with wrong ownership:  
bash# Find where it's mounted (these commands will show you - if it is mounted anywhere):  
```bash
mount | grep -i shared
```
```bash
df -kh
```
```bash
lsblk
```
Example output might show (PS: ONLY IF YOUR FILESYSTEM IS MOUNTED):  
> /dev/sdb1 on /run/media/alexdata/SHARED-LINUX type ext4 (rw,nosuid,nodev,relatime,uid=0,gid=0)  

### FIX 4 - MOUNT PERMISSION ISSUE:
Maybe SHARED-LINUX is mounted with wrong ownership:

**Find where it's mounted:**
```bash
mount | grep -i shared
df -kh
lsblk
```

**Example output (if mounted):**
```
/dev/sdb1 on /run/media/alexdata/SHARED-LINUX type ext4 (rw,nosuid,nodev,relatime,uid=0,gid=0)
```

**Fix ownership:**
```bash
# Check ownership:
ls -la /run/media/alexdata/

# If owned by root, remount with your user:
sudo umount /run/media/alexdata/SHARED-LINUX
sudo mount -o uid=1000,gid=1000 /dev/sdb1 /run/media/alexdata/SHARED-LINUX
```

---

### FIX 5 - POLKIT RULES FOR UDISKS (Advanced):
⚠️ Only use if previous fixes didn't work!

Create a rule to allow your user to mount without password:
```bash
# Create polkit rule:
sudo nano /etc/polkit-1/rules.d/50-udisks.rules
```

**Add this JavaScript code:**
```javascript
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount" &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});

polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
```

**Save and reload polkit:**
```bash
sudo systemctl restart polkit
```

---

### FIX 6 - CHECK FILESYSTEM TYPE:
```bash
# Check filesystem type:
lsblk -f | grep -i shared
```

**If it's NTFS or exFAT:**
```bash
sudo pacman -S ntfs-3g exfatprogs
```

**If it's ext4 with wrong permissions:**
```bash
sudo chown -R alexdata:alexdata /path/to/SHARED-LINUX
```

---

### DEBUG SCRIPT - COMPREHENSIVE CHECK:

Create a diagnostic script:
```bash
nano ~/debug-polkit.sh
```

**Add this code:**
```bash
#!/bin/bash
echo "=== POLKIT SHARED-LINUX DEBUG ==="
echo ""

echo "1. PolicyKit daemon status:"
systemctl status polkit | grep "Active:"

echo ""
echo "2. Authentication agents running:"
ps aux | grep polkit-kde | grep -v grep

echo ""
echo "3. D-Bus session:"
echo "DBUS_SESSION_BUS_ADDRESS: $DBUS_SESSION_BUS_ADDRESS"

echo ""
echo "4. SHARED-LINUX mount info:"
mount | grep -i shared

echo ""
echo "5. Mount point permissions:"
df | grep -i shared | awk '{print $6}' | xargs ls -lad

echo ""
echo "6. Your user groups:"
groups

echo ""
echo "7. PolicyKit can-do test:"
pkcheck --action-id org.freedesktop.udisks2.filesystem-mount --process $$ 2>&1

echo ""
echo "=== END DEBUG ==="
```

**Make file executable - and run it:**
```bash
chmod +x ~/debug-polkit.sh
./debug-polkit.sh
```

---

### MOST LIKELY SOLUTION:
Based on typical errors, the authentication agent usually died or wasn't started properly!

**Quick test:**
```bash
# 1. Kill and restart agent:
killall polkit-kde-authentication-agent-1
/usr/lib/polkit-kde-authentication-agent-1 &

# 2. Try accessing SHARED-LINUX in Dolphin again

# 3. If you get a password prompt → SUCCESS! ✅
# 4. If still no prompt → Run debug script above
```

## WHY `systemctl restart polkit` DIDN'T WORK:

**Architecture explanation:**
```
polkit (daemon)           ← You restarted this (backend)
    ↓
polkit-kde-agent (GUI)    ← But THIS needs restarting (frontend)
    ↓
Dolphin (file manager)    ← This asks the agent for auth
```

**The problem:** You restarted the backend, but the frontend (GUI agent) was still broken!

**The solution:**
```bash
killall polkit-kde-authentication-agent-1
/usr/lib/polkit-kde-authentication-agent-1 &
```

Then click SHARED-LINUX in Dolphin again!


<!-- SAME AS ABOVE BUT WITHOUT MDD FORMATTING
# Check ownership of mount point:
ls -la /run/media/alexdata/

# If owned by root, remount with your user:
sudo umount /run/media/alexdata/SHARED-LINUX
sudo mount -o uid=1000,gid=1000 /dev/sdb1 /run/media/alexdata/SHARED-LINUX

FIX 5 - POLKIT RULES FOR UDISKS (Mounting disks):
Create a rule to allow your user to mount without password:
bash# Create polkit rule:
sudo nano /etc/polkit-1/rules.d/50-udisks.rules
Add:
javascriptpolkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount" &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});

polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
Save and reload polkit:
bashsudo systemctl restart polkit

FIX 6 - CHECK WHAT FILESYSTEM TYPE:
bash# Check filesystem type:
lsblk -f | grep -i shared

# If it's NTFS or exFAT:
sudo pacman -S ntfs-3g exfatprogs

# If it's ext4 with wrong permissions:
sudo chown -R alexdata:alexdata /path/to/SHARED-LINUX

DEBUG SCRIPT - COMPREHENSIVE CHECK:
bash#!/bin/bash
echo "=== POLKIT SHARED-LINUX DEBUG ==="
echo ""

echo "1. PolicyKit daemon status:"
systemctl status polkit | grep "Active:"

echo ""
echo "2. Authentication agents running:"
ps aux | grep polkit-kde | grep -v grep

echo ""
echo "3. D-Bus session:"
echo "DBUS_SESSION_BUS_ADDRESS: $DBUS_SESSION_BUS_ADDRESS"

echo ""
echo "4. SHARED-LINUX mount info:"
mount | grep -i shared

echo ""
echo "5. Mount point permissions:"
df | grep -i shared | awk '{print $6}' | xargs ls -lad

echo ""
echo "6. Your user groups:"
groups

echo ""
echo "7. PolicyKit can-do test:"
pkcheck --action-id org.freedesktop.udisks2.filesystem-mount --process $$ 2>&1

echo ""
echo "=== END DEBUG ==="
Save as debug-polkit.sh, run:
bashchmod +x debug-polkit.sh
./debug-polkit.sh

MOST LIKELY SOLUTION:
Based on the error, I bet the authentication agent died or wasn't started properly!
Quick Test:
bash# 1. Kill and restart agent:
killall polkit-kde-authentication-agent-1
/usr/lib/polkit-kde-authentication-agent-1 &

# 2. Try accessing SHARED-LINUX in Dolphin again

# 3. If you get a password prompt → SUCCESS!
# 4. If still no prompt → Run debug script above
```


## **WHY `systemctl restart polkit` DIDN'T WORK:**
```
polkit (daemon)           ← You restarted this (backend)
    ↓
polkit-kde-agent (GUI)    ← But THIS needs restarting (frontend)
    ↓
Dolphin (file manager)    ← This asks the agent for auth
You restarted the backend, but the frontend (GUI agent) was still broken!

TRY THIS FIRST:
bashkillall polkit-kde-authentication-agent-1
/usr/lib/polkit-kde-authentication-agent-1 &
Then click SHARED-LINUX in Dolphin again!
-->
