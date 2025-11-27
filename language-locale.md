## Set Locale (OS Language)
```
nano /etc/locale.gen                        # OK Edit this file to edit the OS language.
# Uncomment: "en_US.UTF-8 UTF-8" line       # This enables US English language for the OS.
locale-gen                                  # OK Generate locales to be used in the OS.
echo "LANG=en_US.UTF-8" > /etc/locale.conf  # OK Add this info to locale file too.
```

## Set Keyboard Layout (Persistent)
```
echo "KEYMAP=no" > /etc/vconsole.conf       # OK Copy here so that console also uses this layout.
```

## Check Your Locale (Anything language related)
```
localectl      # Show OS language and keyboard layout.
```
```
locale -a       # Show details about UTF8.
```
```
locale       # Show all language related settings.
```

(below has yet to be properly edited - ongoing)  

Your goal:

✅ English UI (LANG=en_US.UTF-8)
✅ Norwegian regional settings (dates, times, currency)


STEP 1: CHECK NORWEGIAN LOCALE 🇳🇴
bash# Is Norwegian locale generated?
locale -a | grep -i no
locale -a | grep -i nb
```

**Expected output:**
```
nb_NO.utf8
nn_NO.utf8
If missing, generate it:
bash# Edit locale.gen:
sudo nano /etc/locale.gen

# Uncomment these lines:
en_US.UTF-8 UTF-8
nb_NO.UTF-8 UTF-8

# Generate locales:
sudo locale-gen

# Verify:
locale -a | grep nb

STEP 2: MIXED LOCALE CONFIG 🇬🇧🇳🇴
Edit system locale:
bashsudo nano /etc/locale.conf
Add this:
bash# System language: English
LANG=en_US.UTF-8

# Regional formats: Norwegian
LC_TIME=nb_NO.UTF-8
LC_NUMERIC=nb_NO.UTF-8
LC_MONETARY=nb_NO.UTF-8
LC_MEASUREMENT=nb_NO.UTF-8
LC_PAPER=nb_NO.UTF-8

# Keep English for messages/collation:
LC_MESSAGES=en_US.UTF-8
LC_COLLATE=en_US.UTF-8

STEP 3: SYSTEM-WIDE ENVIRONMENT 🌐
For GUI apps that don't read .bashrc:
bashsudo nano /etc/environment
Add:
bashLANG=en_US.UTF-8
LC_TIME=nb_NO.UTF-8
LC_NUMERIC=nb_NO.UTF-8
LC_MONETARY=nb_NO.UTF-8
LC_MEASUREMENT=nb_NO.UTF-8

STEP 4: KDE PLASMA SPECIFIC 🖥️
KDE has its own locale settings:
bashnano ~/.config/plasma-localerc
Add/modify:
ini[Formats]
LANG=en_US.UTF-8
LC_TIME=nb_NO.UTF-8
LC_NUMERIC=nb_NO.UTF-8
LC_MONETARY=nb_NO.UTF-8
LC_MEASUREMENT=nb_NO.UTF-8

STEP 5: CLEAN UP .BASHRC 🧹
Your .bashrc should have:
bash# At the TOP (before [[ $- != *i* ]] line):

# Only set if not already set by system:
export LANG="${LANG:-en_US.UTF-8}"
export LC_TIME="${LC_TIME:-nb_NO.UTF-8}"
export LC_NUMERIC="${LC_NUMERIC:-nb_NO.UTF-8}"
export LC_MONETARY="${LC_MONETARY:-nb_NO.UTF-8}"
export LC_MEASUREMENT="${LC_MEASUREMENT:-nb_NO.UTF-8}"
This prevents overriding system settings if already correct!

ABOUT "C" IN locale -a: 📝
bashlocale -a
C          # ← This is ALWAYS here! Can't remove it!
C.utf8     # ← UTF-8 version of C
POSIX      # ← Same as C
en_US.utf8
nb_NO.utf8
The "C" locale:

= Default POSIX locale
= Minimal/fallback
= Can't be removed (it's built-in!)
= Not a problem (just ignore it!)

You CAN'T edit this list directly - it's generated from installed locales!
