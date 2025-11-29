#!/bin/bash
#!/
# PUT THIS SCRIPT INSIDE A PYTHON VENV PROJECT FOLDER
# THIS SCRIPT WILL SECURELY START THAT PYTHON VENV FOR YOU AUTOMATICALLY
# ALSO PERFORMS A FEW PATH TESTS SO YOU CAN MAKE SURE IT IS RUNNING THE VENV CORRECTLY
# WORKS ON: KDE (Konsole), GNOME, XFCE, Alpine Linux, and fallback to xterm

# Change to script directory
cd "$(dirname "$0")"

# Set variables
CURRENT_FOLDER="$(pwd)"
THE_VENV_FOLDER="$(cd "$(dirname "$0")" && pwd)"  # Get absolute path

# Get current folder name (project name) - MUCH SIMPLER THAN WINDOWS LOOP!
PROJECT_VENV_NAME="$(basename "$CURRENT_FOLDER")"

# Display info
echo "THIS SCRIPT RUNS FROM A FOLDER CALLED '$PROJECT_VENV_NAME' ON YOUR SYSTEM"
echo ""
echo "You Are Starting This PYTHON VIRTUAL VENV $PROJECT_VENV_NAME From This Folder"
echo "$THE_VENV_FOLDER"
echo ""
echo "The Python VENV Folder Detected Will Be Automatically ACTIVATED In..."
sleep 3

# AUTO-DETECT WHICH TERMINAL EMULATOR TO USE
if command -v konsole &>/dev/null; then
    # KDE Plasma (AlexData's main system - Arch minimal 822 packages!)
    TERMINAL_CMD="konsole --hold -e"
    echo "Detected: Konsole (KDE Plasma)"
elif command -v xfce4-terminal &>/dev/null; then
    # XFCE (Alpine Linux desktop environment)
    TERMINAL_CMD="xfce4-terminal --hold -e"
    echo "Detected: XFCE Terminal (Alpine)"
elif command -v gnome-terminal &>/dev/null; then
    # GNOME (Ubuntu and similar)
    TERMINAL_CMD="gnome-terminal --"
    echo "Detected: GNOME Terminal"
elif command -v kitty &>/dev/null; then
    # Kitty terminal (Hello Kitty! ha ha!)
    TERMINAL_CMD="kitty"
    echo "Detected: Kitty Terminal"
elif command -v xterm &>/dev/null; then
    # Fallback - xterm is almost always available
    TERMINAL_CMD="xterm -hold -e"
    echo "Detected: xterm (fallback)"
else
    echo "ERROR: No terminal emulator found!"
    echo "Please install one of: konsole, xfce4-terminal, gnome-terminal, xterm"
    exit 1
fi

# Open new terminal window with venv activated
$TERMINAL_CMD bash -c "
    cd '$THE_VENV_FOLDER' && \
    echo 'Starting Up VIRTUAL VENV Project: $PROJECT_VENV_NAME' && \
    echo '$THE_VENV_FOLDER' && \
    source '$PROJECT_VENV_NAME/bin/activate' && \
    echo '' && \
    echo '' && \
    echo 'Current Modules' && \
    pip list && \
    echo '' && \
    echo 'Current Machine And User' && \
    whoami && \
    echo '' && \
    echo 'Current Python PATHs' && \
    which python && \
    echo '' && \
    echo 'Current Pip PATHs' && \
    which pip && \
    echo '' && \
    echo 'Current Project Files' && \
    ls -1 *.py 2>/dev/null || echo 'No .py files found' && \
    echo '' && \
    echo 'python' && \
    echo '' && \
    echo 'Running VIRTUAL VENV Project: $PROJECT_VENV_NAME' && \
    echo '$CURRENT_FOLDER' && \
    echo '' && \
    echo 'POSSIBLE ADDITIONAL PATH TEST1' && \
    pip freeze && \
    echo 'POSSIBLE ADDITIONAL PATH TEST2' && \
    python -c 'import sys; print(sys.executable)' && \
    echo '' && \
    echo 'VENV Ready! Type commands or run your scripts!' && \
    exec bash
"

# MAKE-THIS-SCRIPT-EXECUTABLE:
# bashchmod +x clean-temp-files.sh

# RUN-SCRIPT-IN-TERMINAL:
# ./clean-temp-files.sh
# sh clean-temp-files.sh

# --------------------------------------------------------
# This Script Was Invented By AlexData for Windows In 2025
# Translated To Bash By AlexData & Claude In 2025
# Added Auto-Detection For Linux Multi-System Support !!!!!
# --------------------------------------------------------
