#!/bin/bash

# ===== COLORS =====
RED='\033[1;31m'
NC='\033[0m'

# ===== HELPER FUNCTIONS =====
slow_load() {
    echo -ne "${RED}Loading... [■□□□□] 20%\r"
    sleep 0.5
    echo -ne "${RED}Loading... [■■□□□] 40%\r"
    sleep 0.5
    echo -ne "${RED}Loading... [■■■□□] 60%\r"
    sleep 0.5
    echo -ne "${RED}Loading... [■■■■□] 80%\r"
    sleep 0.5
    echo -ne "${RED}Loading... [■■■■■] 100%\r"
    echo -e "${NC}\n"
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

# ===== MAIN MENU =====
main_menu() {
    logo
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}         Classcial_Ladder Installer     ${NC}"
    echo -e "${RED}========================================${NC}"
    echo ""
    echo -e "${RED}1) Install Pterodactyl Panel (Custom Domain)${NC}"
    echo -e "${RED}2) Install Pterodactyl Wings${NC}"
    echo -e "${RED}3) Blueprint Framework & Addons${NC}"
    echo -e "${RED}4) Cloudflare Tunnel Setup${NC}"
    echo -e "${RED}5) Tailscale Setup${NC}"
    echo -e "${RED}0) Exit${NC}"
    echo ""
    read -p "Select Option: " opt
}

# ===== LOGIC =====
while true; do
    main_menu
    case $opt in

        1)
            read -p "Enter the domain for your panel (e.g. panel.example.com): " domain
            echo -e "${RED}Preparing installation for $domain...${NC}"
            slow_load
            # This uses the official community script but passes the install command
            bash <(curl -s https://pterodactyl-installer.se) <<EOF
0
$domain
Europe/London
admin@$domain
admin
admin
Admin
User
password
EOF
            ;;

        3)
            echo -e "${RED}Starting Blueprint Installer...${NC}"
            slow_load
            # Automated Blueprint Install
            cd /var/www/pterodactyl && bash <(curl -sL https://blueprint.zip/install.sh)
            echo -e "${RED}Blueprint installed. Returning to menu...${NC}"
            sleep 2
            ;;

        4)
            echo -e "${RED}Installing Cloudflared...${NC}"
            curl -fsSL https://pkg.cloudflare.com/install.sh | sudo bash
            sudo apt install cloudflared -y
            read -p "Paste your Cloudflare Tunnel Token: " tunnel_token
            sudo cloudflared service install $tunnel_token
            echo -e "${RED}CONNECTED! Cloudflare Tunnel is running.${NC}"
            sleep 3
            ;;

        5)
            echo -e "${RED}Installing Tailscale...${NC}"
            slow_load
            curl -fsSL https://tailscale.com/install.sh | sh
            echo -e "${RED}Authenticating...${NC}"
            sudo tailscale up
            echo -e "${RED}Tailscale is now UP.${NC}"
            sleep 2
            ;;

        0)
            echo -e "${RED}Goodbye!${NC}"
            exit
            ;;

        *)
            echo "Invalid Option"
            sleep 1
            ;;
    esac
done
