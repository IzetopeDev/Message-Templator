#!/bin/bash

# 1. Bridge Diagnostic Check
# Since we are using ADB_SERVER_SOCKET, we check if the Host is listening.
echo "--- 🔌 Checking ADB Bridge ---"

# We try to run a simple adb command.
# If it fails, it usually means the Windows Host isn't running 'adb -a nodaemon server'
if adb devices 2>&1 | grep -q "List of devices"; then
    echo "ADB Bridge is ACTIVE. You are connected to the Host's ADB server."
else
    echo "ADB Bridge is DOWN."
    echo "The container cannot see your Windows ADB Server."
    echo "ACTION REQUIRED: Open PowerShell on Windows and run:"
    echo "  ./adb kill-server"
    echo "  ./adb -a nodaemon server"
fi

# 2. Navigate to project
# Ensure this matches your mount path (/workspaces/<folder>)
cd /workspaces/Message-Templator/templator || echo "Warning: Could not find project folder"

# 3. Git Config
git config --global --add safe.directory '*'

# 4. Flutter Setup
# 'flutter doctor' can be slow. Comment out if not needed every time.
flutter doctor
flutter pub get

# 5. Run next script (Execute only if it exists)
if [ -f "/home/vscode/container_config/dev-config.sh" ]; then
    /home/vscode/container_config/dev-config.sh
fi