#!/bin/bash

# ===== COLORS =====
RED='\033[1;31m'
NC='\033[0m'

# ===== LOGO =====
logo() {
clear
echo -e "${RED}"
echo " ██████╗██╗      █████╗ ███████╗███████╗██╗ █████╗ ██╗         ██╗      █████╗ ██████╗ ██████╗ ███████╗██████╗ "
echo "██╔════╝██║     ██╔══██╗██╔════╝██╔════╝██║██╔══██╗██║         ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗"
echo "██║     ██║     ███████║███████╗███████╗██║███████║██║         ██║     ███████║██║  ██║██║  ██║█████╗  ██████╔╝"
echo "██║     ██║     ██╔══██║╚════██║╚════██║██║██╔══██║██║         ██║     ██╔══██║██║  ██║██║  ██║██╔══╝  ██╔══██╗"
echo "╚██████╗███████╗██║  ██║███████║███████║██║██║  ██║███████╗    ███████╗██║  ██║██████╔╝██████╔╝███████╗██║  ██║"
echo " ╚═════╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝    ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
}

# ===== MAIN MENU =====
main_menu() {
logo
echo -e "${RED}========================================${NC}"
echo -e "${RED}        Classcial_Ladder Installer       ${NC}"
echo -e "${RED}========================================${NC}"
echo ""
echo -e "${RED}1) Install Pterodactyl Panel${NC}"
echo -e "${RED}2) Install Pterodactyl Wings${NC}"
echo -e "${RED}3) Add Blueprint + Themes + Addons${NC}"
echo -e "${RED}4) Cloudflare Setup${NC}"
echo -e "${RED}5) Tailscale Setup${NC}"
echo -e "${RED}0) Exit${NC}"
echo ""
read -p "Select Option: " opt
}

# ===== TAILSCALE MENU =====
tailscale_menu() {
clear
echo -e "${RED}====== Tailscale Setup ======${NC}"
echo ""
echo "1) Install Fresh Tailscale"
echo "2) Uninstall Tailscale Completely"
echo "3) Back to Main Menu"
echo ""
read -p "Choose Option: " ts
}

# ===== LOOP =====
while true; do
main_menu

case $opt in

1)
echo -e "${RED}Installing Pterodactyl Panel...${NC}"
bash <(curl -s https://pterodactyl-installer.se)
;;

2)
echo -e "${RED}Installing Wings...${NC}"
bash <(curl -s https://pterodactyl-installer.se)
;;

3)
echo -e "${RED}Installing Blueprint Framework...${NC}"
bash <(curl -s https://raw.githubusercontent.com/BlueprintFramework/framework/main/install.sh)
;;

4)
echo -e "${RED}Installing Cloudflare Tunnel...${NC}"
curl -fsSL https://pkg.cloudflare.com/install.sh | sudo bash
sudo apt install cloudflared -y
echo -e "${RED}Run: cloudflared tunnel login${NC}"
sleep 3
;;

5)
while true; do
tailscale_menu
case $ts in

1)
echo -e "${RED}Installing Tailscale...${NC}"
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
sleep 2
;;

2)
echo -e "${RED}Removing Tailscale Completely...${NC}"
sudo systemctl stop tailscaled
sudo apt purge tailscale -y
sudo rm -rf /var/lib/tailscale
echo "Tailscale removed!"
sleep 2
;;

3)
break
;;

*)
echo "Invalid Option"
sleep 1
;;
esac
done
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
