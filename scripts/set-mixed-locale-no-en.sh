#!/bin/bash
# Fix locale for Qt/Python apps

# MAKE-THIS-SCRIPT-EXECUTABLE:
# bashchmod +x clean-temp-files.sh

# RUN-SCRIPT-IN-TERMINAL:
# ./clean-temp-files.sh
# sh clean-temp-files.sh

echo "Fixing locale configuration..."

# 1. Generate Norwegian locale if missing
if ! locale -a | grep -q nb_NO; then
    echo "Generating Norwegian locale..."
    sudo sed -i 's/^#nb_NO.UTF-8/nb_NO.UTF-8/' /etc/locale.gen
    sudo locale-gen
fi

# 2. Set mixed locale in /etc/locale.conf
echo "Setting mixed locale..."
sudo tee /etc/locale.conf > /dev/null << 'EOF'
LANG=en_US.UTF-8
LC_TIME=nb_NO.UTF-8
LC_NUMERIC=nb_NO.UTF-8
LC_MONETARY=nb_NO.UTF-8
LC_MEASUREMENT=nb_NO.UTF-8
LC_PAPER=nb_NO.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_COLLATE=en_US.UTF-8
EOF

# 3. Set system-wide environment
echo "Setting /etc/environment..."
sudo tee -a /etc/environment > /dev/null << 'EOF'
LANG=en_US.UTF-8
LC_TIME=nb_NO.UTF-8
LC_NUMERIC=nb_NO.UTF-8
LC_MONETARY=nb_NO.UTF-8
EOF

echo "Done! Please reboot for changes to take effect."
echo "After reboot, run: 'locale', 'locale -a' and 'localectl'"
echo "Should now show Norwegian for time/numeric/monetary!"
