# 🐧 Admin rights on Linux - Sudo, SU, [and DoAs] 🐧
Learn how to gain Administrator access in Linux.  
Also figure out how to fix Administrator access when it's broken - or not properly working.  
So this document is basically "**anything su or sudo related**" (_I may also include DoAs info eventually_).

<br>

### CRITICAL ISSUE: SUDO PASSWORD NOT WORKING!
If you see this in your terminal:
> Sudo: 3 incorrect password attempts
This is serious! Your sudo access is somehow broken!
Or... You had "caps lock" turned on - or your entire "keyboard layout" was somehow changed.  

<br>

# QUICK DIAGNOSTICS - WHILE STILL ROOT:
Check CAPS LOCK first! Type your password in a text program, and see if it comes out as expected! 

### 1. Try logging in as root with "su -".  
```bash
su -
```
If you get in then you're already su - as root, let's check what happened:  

### 2. Check if your user is still in wheel group (group that gives you root/admin access when writing sudo):  
```bash
groups alexdata    # Try with your own normal username!
```

### 3. Check sudo configuration:
```bash
cat /etc/sudoers | grep wheel
```

###  4. Check if password is locked:
```bash
passwd -S alexdata    # Try with your own normal username!
```
Expected output explained:  
alexdata P 2025-11-16 0 99999 7 -1  
         │ │           │ │     │ │  
         │ │           │ │     │ └─ No inactivity lock.  
         │ │           │ │     └─── 7 days warning before expiry.  
         │ │           │ └───────── 99999 days until password expires.  
         │ │           └─────────── Min 0 days between changes.  
         │ └─────────────────────── Last changed: Nov 16, 2025.  
         └───────────────────────── P = Password set and valid.  
           

###  5. Verify PAM is working:
```bash
pamtester -v sudo alexdata authenticate
```

###  6. Check sudo logs:
```bash
journalctl -u sudo | tail -20
```

###  7. Test keyboard layout (as this may lead to typing the wrong password):
copy and paste this into your terminal to test the password there too! Make sure no one is physically watching you as you do this!
```bash
echo "Type your password here (will be fully visible): "; read -r TEST_PASS; echo "You typed: $TEST_PASS"
```

MOST LIKELY CAUSES:  

Keyboard Layout Changed - Check current layout:  
```bash
localectl status
```

If wrong layout, set it to US:  
```bash
localectl set-keymap us
```

Or Norwegian layout in my case:  
```bash
localectl set-keymap no
```

Caps Lock or Num Lock Issues?  
Type your password slowly and carefully - maybe a key is stuck?  

### 8. Password Corruption - While root, simply reset your normal user password:  
```bash
passwd alexdata
```

Type new password twice + enter twice.
Then test the newly changed password:
```bash
exit  # Exit from root (if still logged in as root)
```
```bash
sudo echo "test"  # Try sudo with new password and normal user!
```

<br>

## COMPLETE SUDO DEBUG -SRIPT- IDEA (Run this script as root):
```bash
bash#!/bin/bash
# name the script: "sudo-test.sh"

echo "=== SUDO DEBUG ==="

echo ""
echo "1. User groups:"
groups $USER

echo ""
echo "2. Wheel group in sudoers:"
grep "^%wheel" /etc/sudoers

echo ""
echo "3. Password status:"
passwd -S $USER

echo ""
echo "4. PAM sudo config:"
cat /etc/pam.d/sudo

echo ""
echo "5. Recent sudo attempts:"
journalctl -u sudo --since "1 hour ago" | tail -20

echo ""
echo "6. Check /etc/shadow entry:"
grep "^$USER:" /etc/shadow | cut -d: -f1-2

echo ""
echo "=== END DEBUG ==="
```

<br>

## IMMEDIATE FIX - RESET PASSWORD:
```bash
passwd alexdata # Use your normal username here!
```
Type your new password (or same password again)!  
This will re-hash (regenerate) the password and fix any corruption with it!  

Then test the password:  
```bash
exit    # Exit from root, if still logged in as root!
```
```bash
sudo whoami    # Should show: root (since your user should now have root access)
```

<br>

