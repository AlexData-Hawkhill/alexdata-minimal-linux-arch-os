## 🐧Language and Locale (multi lingual OS)🐧  

🇬🇧 English UI (LANG=en_US.UTF-8)  
🇳🇴 Norwegian regional settings (dates, times, currency, keyboard)  

(_ps: you may set only one language by using this guide too - simply skip the norwegian lines_)  
[Here is a .sh script you can use to set mixed NO/US locales faster](/scripts/set-mixed-locale-no-en.sh)  

<br>

## Set Locale (OS Language)
```bash
nano /etc/locale.gen                        # Edit this file to edit the OS language.
```
```Uncomment: "en_US.UTF-8 UTF-8" line       # This enables US English language for the OS.```

```bash
locale-gen                                  # Generate locales to be used in the OS.
```
```bash
echo "LANG=en_US.UTF-8" > /etc/locale.conf  # Add this info to locale file too.
```

<br>

## Set Keyboard Layout (Persistent)
```
echo "KEYMAP=no" /etc/vconsole.conf       # Copy here so that console also uses this layout.
```

<br>

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

<br>

## STEP 1: CHECK THE GENERATED NORWEGIAN LOCALE 🇳🇴  
Is Norwegian locale generated?  
```bash
locale -a | grep -i no
```  
```bash
locale -a | grep -i nb
```  

**Expected output:**  
> nb_NO.utf8  
> nn_NO.utf8  

### If the no or us locale is missing, generate it!  
Edit locale.gen file:  
```bash
sudo nano /etc/locale.gen
```  

### Uncomment these two lines in locale.gen file:  
```en_US.UTF-8 UTF-8    # English```  
```nb_NO.UTF-8 UTF-8    # Norwegian```  

### Generate locales:  
```bash
sudo locale-gen
```  

### Verify generated locale:  
```bash
locale -a | grep nb
```  

## STEP 2: MIXED LOCALE CONFIG 🇬🇧🇳🇴  
Edit system locale:  
```bash
sudo nano /etc/locale.conf
```  

### Add this first:  
```
System language: English  
LANG=en_US.UTF-8  
```

### Then this - Regional formats: Norwegian🇳🇴 
```
LC_TIME=nb_NO.UTF-8  
LC_NUMERIC=nb_NO.UTF-8  
LC_MONETARY=nb_NO.UTF-8  
LC_MEASUREMENT=nb_NO.UTF-8  
LC_PAPER=nb_NO.UTF-8  
```

### Also - Keep English for messages/collation🇬🇧:  
```
LC_MESSAGES=en_US.UTF-8  
LC_COLLATE=en_US.UTF-8  
```

<br>

## STEP 3: SYSTEM-WIDE ENVIRONMENT  
For GUI apps that don't read .bashrc:  
```sudo nano /etc/environment```   
Add to the file:  
```
LANG=en_US.UTF-8  
LC_TIME=nb_NO.UTF-8  
LC_NUMERIC=nb_NO.UTF-8  
LC_MONETARY=nb_NO.UTF-8  
LC_MEASUREMENT=nb_NO.UTF-8  
```

<br>

## STEP 4: KDE PLASMA SPECIFIC 🖥️  
KDE has its own locale settings:  
```nano ~/.config/plasma-localerc```  
Add/modify these lines in the file:  
```
ini[Formats]  
LANG=en_US.UTF-8  
LC_TIME=nb_NO.UTF-8  
LC_NUMERIC=nb_NO.UTF-8  
LC_MONETARY=nb_NO.UTF-8  
LC_MEASUREMENT=nb_NO.UTF-8  
```

<br>

## STEP 5: CLEAN UP YOUR HOME FOLDERS .BASHRC  
Your .bashrc file should have:  
At the TOP (before the `[[ $- != *i* ]]` line (if present)):  

### Only set these in .bashrc if not set by the system:
```
export LANG="${LANG:-en_US.UTF-8}"  
export LC_TIME="${LC_TIME:-nb_NO.UTF-8}"  
export LC_NUMERIC="${LC_NUMERIC:-nb_NO.UTF-8}"  
export LC_MONETARY="${LC_MONETARY:-nb_NO.UTF-8}"  
export LC_MEASUREMENT="${LC_MEASUREMENT:-nb_NO.UTF-8}"  
```
This prevents overriding system settings if already correct!  

<br>

## More info on what each locale line does:
```
LANG=en_US.UTF-8            # Default language for everything  
LC_TIME=nb_NO.UTF-8         # Date/time format (24-hour, DD.MM.YYYY)  
LC_NUMERIC=nb_NO.UTF-8      # Number format (1.234,56 vs 1,234.56)  
LC_MONETARY=nb_NO.UTF-8     # Currency (kr vs $)  
LC_MEASUREMENT=nb_NO.UTF-8  # Metric vs Imperial  
LC_PAPER=nb_NO.UTF-8        # Paper size (A4 vs Letter)  
LC_MESSAGES=en_US.UTF-8     # UI messages (keep English!)  
LC_COLLATE=en_US.UTF-8      # Sorting order (files/folders/text) (keep English!)  
```

### About "C" and "POSIX" IN "locale -a" output:
```bash
locale -a
```  
```C          # ← This is ALWAYS here! Can't remove it!```  
```C.utf8     # ← UTF-8 version of C```    
```POSIX      # ← Same as C - Unix base locale.```  
```en_US.utf8 # NORWEGAIN - ADDED BY USER``` 
```nb_NO.utf8 # ENGLISH - ADDED BY USER OR DEFAULT```

### The "C" locale - What is it:  
> = Default POSIX locale  
> = Minimal/fallback   
> = Can't be removed (it's built-in!)  
> = Not a problem (just ignore it!)  

You CAN'T edit this `locale -a` list directly - it's generated from installed locales!  
(_Use the methods above to change languages and locale - if need be_)  

<br>


