#!/bin/bash

# Termux URL Opener - Installation Script
# This script installs termux-url-opener to /system/bin or /bin

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Termux URL Opener - Installation Script    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Check if running in Termux
if [ ! -d "/data/data/com.termux" ]; then
    echo -e "${RED}✗ Error: This script must be run in Termux${NC}"
    exit 1
fi

# Source directory
SCRIPT_DIR=""$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)""
SOURCE_FILE="$SCRIPT_DIR/termux_dl.sh"

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}✗ Error: termux_dl.sh not found in $SCRIPT_DIR${NC}"
    exit 1
fi

# Installation directories to try
INSTALL_DIRS=(
    "/data/data/com.termux/files/usr/bin"
    "$PREFIX/bin"
)

INSTALLED=false

for INSTALL_DIR in "${INSTALL_DIRS[@]}"; do
    if [ -d "$INSTALL_DIR" ] && [ -w "$INSTALL_DIR" ]; then
        echo -e "${YELLOW}→ Installing to: $INSTALL_DIR${NC}"
        
        # Copy the script
        cp "$SOURCE_FILE" "$INSTALL_DIR/termux-url-opener"
        
        # Make it executable
        chmod +x "$INSTALL_DIR/termux-url-opener"
        
        # Verify installation
        if [ -x "$INSTALL_DIR/termux-url-opener" ]; then
            echo -e "${GREEN}✓ Successfully installed termux-url-opener${NC}"
            echo -e "${GREEN}✓ Location: $INSTALL_DIR/termux-url-opener${NC}"
            INSTALLED=true
            break
        fi
    fi
done

if [ "$INSTALLED" = false ]; then
    echo -e "${RED}✗ Error: Could not find a writable installation directory${NC}"
    echo -e "${YELLOW}Please ensure you have proper permissions in Termux${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}╔═════════════════════════════════════��══════════╗${NC}"
echo -e "${GREEN}║         Installation Complete! 🎉              ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo "Usage:"
echo -e "  ${BLUE}termux-url-opener <URL>${NC}"
echo ""
echo "Examples:"
echo -e "  ${BLUE}termux-url-opener https://www.instagram.com/p/xyz${NC}"
echo -e "  ${BLUE}termux-url-opener https://www.tiktok.com/@user/video/123${NC}"
echo -e "  ${BLUE}termux-url-opener https://www.youtube.com/watch?v=xyz${NC}"
echo ""
echo "To uninstall:"
echo -e "  ${BLUE}rm $INSTALL_DIR/termux-url-opener${NC}"
echo ""