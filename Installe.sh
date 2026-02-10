#!/bin/bash

# ===== COLORS =====
RED='\033[1;31m'
NC='\033[0m'

# ===== SMOOTH LOADING =====
smooth_load() {
    local message=$1
    echo -ne "${RED}${message} "
    for i in {1..10}; do
        echo -ne "■"
        sleep 0.1
    done
    echo -e "${NC}"
}

logo() {
    clear
    echo -e "${RED}"
    echo " ██████╗██╗      █████╗ ███████╗███████╗██╗ █████╗ ██╗          ██╗      █████╗ ██████╗ ██████╗ ███████╗██████╗ "
    echo "██╔════╝██║     ██╔══██╗██╔════╝██╔════╝██║██╔══██╗██║          ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗"
    echo "██║     ██║     ███████║███████╗███████╗██║███████║██║          ██║     ███████║██║  ██║██║  ██║█████╗  ██████╔╝"
    echo "██║     ██║     ██╔══██║╚════██║╚════██║██║██╔══██║██║          ██║     ██╔══██║██║  ██║██║  ██║██╔══╝  ██╔══██╗"
    echo "╚██████╗███████╗██║  ██║███████║███████║██║██║  ██║███████╗     ███████╗██║  ██║██████╔╝██████╔╝███████╗██║  ██║"
    echo " ╚═════╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝     ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝"
    echo -e "${NC}"
}

# ===== BLUEPRINT SUB-MENU =====
blueprint_menu() {
    while true; do
        logo
        echo -e "${RED}--- BLUEPRINT + THEMES + ADDONS ---${NC}"
        echo "1) Download Blueprint Framework"
        echo "2) Install Themes"
        echo "3) Install Addons"
        echo "4) Back to Main Menu"
        echo ""
        read -p "Select Sub-Option: " bopt
        case $bopt in
            1)
                smooth_load "Downloading Blueprint..."
                cd /var/www/pterodactyl && bash <(curl -sL https://blueprint.zip/install.sh)
                read -p "Press Enter to continue..."
                ;;
            2)
                echo -e "${RED}Fetching Themes...${NC}"
                # Add your specific theme download commands here
                sleep 2
                ;;
            3)
                echo -e "${RED}Fetching Addons...${NC}"
                # Add your specific addon download commands here
                sleep 2
                ;;
            4) break ;;
            *) echo "Invalid choice"; sleep 1 ;;
        esac
    done
}

# ===== MAIN MENU =====
main_menu() {
    logo
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}      Classical_Ladder Ptero-Tool       ${NC}"
    echo -e "${RED}========================================${NC}"
    echo ""
    echo -e "${RED}1) Install Pterodactyl Panel${NC}"
    echo -e "${RED}2) Install Pterodactyl Wings${NC}"
    echo -e "${RED}3) Blueprint + Themes + Addons${NC}"
    echo -e "${RED}4) Cloudflare Tunnel Setup${NC}"
    echo -e "${RED}5) Tailscale Setup (Auto-Up)${NC}"
    echo -e "${RED}0) Exit${NC}"
    echo ""
    read -p "Select Option: " opt
}

# ===== MAIN LOOP =====
while true; do
    main_menu
    case $opt in
        1)
            smooth_load "Starting Panel Install..."
            bash <(curl -s https://pterodactyl-installer.se)
            ;;
        2)
            smooth_load "Starting Wings Install..."
            bash <(curl -s https://pterodactyl-installer.se)
            ;;
        3)
            blueprint_menu
            ;;
        4)
            echo -e "${RED}>>> CLOUDFLARE SETUP <<<${NC}"
            if ! command -v cloudflared &> /dev/null; then
                curl -fsSL https://pkg.cloudflare.com/install.sh | sudo bash
                sudo apt install cloudflared -y
            fi
            read -p "Paste your Tunnel Token: " cf_token
            if [[ -z "$cf_token" || ${#cf_token} -lt 20 ]]; then
                echo -e "${RED}ERROR: That token looks invalid! Try again.${NC}"
                sleep 3
            else
                sudo cloudflared service install "$cf_token" && echo -e "${RED}CONNECTED!${NC}" || echo -e "${RED}FAILED TO CONNECT${NC}"
                sleep 2
            fi
            ;;
        5)
            smooth_load "Installing Tailscale..."
            curl -fsSL https://tailscale.com/install.sh | sh
            sudo tailscale up
            echo -e "${RED}Tailscale is Online.${NC}"
            sleep 2
            ;;
        0) exit ;;
        *) echo "Invalid Option"; sleep 1 ;;
    esac
done
