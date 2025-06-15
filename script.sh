#!/bin/bash

# =====================================================================
# macOS LAUNCHPAD 
# =====================================================================
# Name: macOS Launchpad 
# Version: 1.0 - 2025
# Description: Advanced script for managing Launchpad behavior in macOS
#              by modifying SpotlightUI.plist settings
# Author: Semnykcze
# GitHub: 
# =====================================================================

# Clear screen first
clear

# =====================================================================
# COLOR SCHEME AND FORMATTING
# =====================================================================
readonly RED='\033[1;31m'
readonly GREEN='\033[1;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[1;34m'
readonly CYAN='\033[1;36m'
readonly PURPLE='\033[1;35m'
readonly WHITE='\033[1;37m'
readonly BOLD='\033[1m'
readonly UNDERLINE='\033[4m'
readonly RESET='\033[0m'
readonly BG_BLUE='\033[44m'

# =====================================================================
# CONFIGURATION
# =====================================================================
readonly PLIST_FILE="/Library/Preferences/FeatureFlags/Domain/SpotlightUI.plist"
readonly BACKUP_DIR="$HOME/macOS_Launchpad_Backups"
readonly SCRIPT_VERSION="1.0"
readonly MIN_MACOS_VERSION=26 # Minimum supported macOS version
readonly MAX_MACOS_VERSION=26 # Maximum supported macOS version

# =====================================================================
# OUTPUT FORMATTING FUNCTIONS
# =====================================================================
print_header() {
    echo -e "\n${BG_BLUE}${WHITE}${BOLD} ${UNDERLINE}$1${RESET}${BG_BLUE}${WHITE}${BOLD} ${RESET}"
    echo -e "${CYAN}${BOLD}════════════════════════════════════════════════════════${RESET}"
}

print_section() {
    echo -e "\n${BLUE}${BOLD}▶ $1${RESET}"
    echo -e "${BLUE}────────────────────────────────────────────────────────${RESET}"
}

print_success() {
    echo -e "${GREEN}${BOLD}✓${RESET} ${GREEN}$1${RESET}"
}

print_warning() {
    echo -e "${YELLOW}${BOLD}⚠${RESET} ${YELLOW}$1${RESET}"
}

print_error() {
    echo -e "${RED}${BOLD}!${RESET} ${RED}$1${RESET}"
}

print_info() {
    echo -e "${PURPLE}${BOLD}ℹ${RESET} ${CYAN}$1${RESET}"
}

# =====================================================================
# BANNER DISPLAY
# =====================================================================
show_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo -e "╔══════════════════════════════════════════════════════╗"
    echo -e "║                                                      ║"
    echo -e "║   ${YELLOW}macOS 26 Launchpad Restoration Tool${CYAN}                          ║"
    echo -e "║   ${WHITE}Version: $SCRIPT_VERSION - 2025${CYAN}                               ║"
    echo -e "║                                                      ║"
    echo -e "╚══════════════════════════════════════════════════════╝${RESET}"
    echo ""
}

# =====================================================================
# SYSTEM COMPATIBILITY CHECK
# =====================================================================
check_system_compatibility() {
    print_header "SYSTEM COMPATIBILITY CHECK"
    
    local os_version=$(sw_vers -productVersion)
    local os_major=$(echo "$os_version" | cut -d. -f1)
    
    print_info "Detected macOS version: $os_version"
    
    # Check compatibility (macOS 26)
    if [ "$os_major" -lt "$MIN_MACOS_VERSION" ] || [ "$os_major" -gt "$MAX_MACOS_VERSION" ]; then
        print_error "This tool is designed for macOS $MIN_MACOS_VERSION-$MAX_MACOS_VERSION only."
        print_error "Your current macOS version ($os_version) is not supported."
        print_info "Exiting for system safety."
        exit 1
    fi
    
    print_success "macOS $os_version is supported. Continuing..."
}

# =====================================================================
# IMPORTANT WARNING DISPLAY
# =====================================================================
show_warning() {
    print_header "IMPORTANT WARNING"
    
    print_warning "${BOLD}YOU ARE USING THIS TOOL AT YOUR OWN RISK!${RESET}"
    echo ""
    print_info "This script modifies macOS system files and requires administrator privileges."
    print_info "Improper use may cause system instability or unexpected behavior."
    echo ""
    print_warning "• Always create a system backup before use"
    print_warning "• Author is not responsible for any damage caused by this tool"
    print_warning "• Make sure you understand what this script does"
    print_warning "• Use only if you accept full responsibility for consequences"
    echo ""
    
    print_section "About Launchpad Manager"
    print_info "This script manages Launchpad behavior by modifying SpotlightUI.plist"
    print_info "It can restore the classic Launchpad or revert to default behavior"
    print_error "REQUIRES MAC RESTART AFTER ANY OPERATION TO TAKE EFFECT!"
}

# =====================================================================
# CONFIGURATION DISPLAY
# =====================================================================
show_configuration() {
    print_section "CONFIGURATION"
    
    print_info "Settings file: ${YELLOW}$PLIST_FILE${RESET}"
    print_info "Backup directory: ${YELLOW}$BACKUP_DIR${RESET}"
    print_info "Script version: ${YELLOW}$SCRIPT_VERSION${RESET}"
}

# =====================================================================
# SUDO PRIVILEGES
# =====================================================================
get_sudo_privileges() {
    print_info "Administrator privileges required for system file modification."
    print_info "Please enter your password when prompted."
    
    if ! sudo -v; then
        print_error "Failed to obtain administrator privileges."
        print_error "Make sure you have admin rights and try again."
        return 1
    fi
    
    print_success "Administrator privileges obtained."
    return 0
}

# =====================================================================
# ACTIVATE OLD LAUNCHPAD
# =====================================================================
activate_old_launchpad() {
    print_section "ACTIVATING OLD LAUNCHPAD"
    
    print_info "This will restore the classic Launchpad behavior."
    echo ""
    read -p "Do you want to continue? (y/N): " confirm
    
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
        print_info "Operation cancelled by user."
        return 1
    fi
    
    echo ""
    if ! get_sudo_privileges; then
        return 1
    fi
    
    # Create directory structure
    print_info "Creating required directory structure..."
    if ! sudo mkdir -p "$(dirname "$PLIST_FILE")"; then
        print_error "Failed to create directory structure."
        return 1
    fi
    
    # Write Launchpad settings
    print_info "Writing Launchpad configuration..."
    if ! sudo defaults write "$PLIST_FILE" SpotlightPlus -dict Enabled -bool false; then
        print_error "Failed to write Launchpad settings."
        return 1
    fi
    
    print_success "Old Launchpad has been successfully activated!"
    print_warning "RESTART YOUR MAC NOW for changes to take effect."
    
    return 0
}

# =====================================================================
# DEACTIVATE OLD LAUNCHPAD
# =====================================================================
deactivate_old_launchpad() {
    print_section "DEACTIVATING OLD LAUNCHPAD"
    
    print_info "This will restore the default Launchpad behavior."
    echo ""
    read -p "Do you want to continue? (y/N): " confirm
    
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
        print_info "Operation cancelled by user."
        return 1
    fi
    
    echo ""
    if ! get_sudo_privileges; then
        return 1
    fi
    
    if [ -f "$PLIST_FILE" ]; then
        print_info "Removing Launchpad configuration file..."
        if ! sudo rm "$PLIST_FILE"; then
            print_error "Failed to remove configuration file."
            return 1
        fi
        print_success "Launchpad configuration file removed successfully!"
    else
        print_info "Configuration file not found - probably already in default state."
    fi
    
    print_success "Launchpad has been restored to default behavior!"
    print_warning "RESTART YOUR MAC NOW for changes to take effect."
    
    return 0
}

# =====================================================================
# RISK CONFIRMATION
# =====================================================================
ask_risk_confirmation() {
    while true; do
        echo ""
        read -p "Do you understand and accept the risks? (y/N): " response
        
        case "$response" in
            [yY]|[yY][eE][sS])
                print_success "Risks accepted. Proceeding with application..."
                clear
                return 0
                ;;
            [nN]|[nN][oO]|"")
                print_info "Operation cancelled. Exiting safely."
                exit 0
                ;;
            *)
                print_warning "Please answer 'y' for yes or 'n' for no."
                ;;
        esac
    done
}

# =====================================================================
# APPLICATION RUNNER
# =====================================================================
run_application() {
    # Check system compatibility
    check_system_compatibility
    
    # Display configuration
    show_configuration
    
    # Show main menu
    show_main_menu
    
    echo ""
    print_success "Operation completed successfully!"
    print_info "Thank you for using macOS Launchpad Manager."
}

# =====================================================================
# MAIN PROGRAM FUNCTION
# =====================================================================
main() {
    # Show welcome banner
    show_banner
    
    # Show important warnings
    show_warning
    
    # Ask for risk confirmation
    ask_risk_confirmation
    
    # Run the main application
    run_application
}

# =====================================================================
# MAIN MENU
# =====================================================================
show_main_menu() {
    while true; do
        print_header "MAIN MENU"
        
        echo -e "${CYAN}1.${RESET} Activate Old Launchpad ${YELLOW}(restore classic behavior)${RESET}"
        echo -e "${CYAN}2.${RESET} Deactivate Old Launchpad ${YELLOW}(return to default)${RESET}"
        echo -e "${CYAN}3.${RESET} Exit Program"
        echo ""
        
        read -p "Enter your choice (1-3): " choice
        echo ""
        
        case "$choice" in
            1)
                if activate_old_launchpad; then
                    break
                fi
                echo ""
                ;;
            2)
                if deactivate_old_launchpad; then
                    break
                fi
                echo ""
                ;;
            3)
                print_info "Program exited without making changes."
                exit 0
                ;;
            *)
                print_error "Invalid choice. Please enter a number 1-3."
                echo ""
                ;;
        esac
        
        # Pause before showing menu again
        read -p "Press Enter to continue..."
        echo ""
    done
}

# =====================================================================
# SCRIPT EXECUTION
# =====================================================================
# Trap to ensure clean exit
trap 'echo -e "\n${YELLOW}Script interrupted by user.${RESET}"; exit 130' INT

# Run main program
main

exit 0
