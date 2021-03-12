source "${DIR}"/../.env

clear

TOTAL_STEPS=2
CURRENT_STEP=0

CURRENT_STEP=$((CURRENT_STEP + 1))

echo -e "${COLOR_GREEN} Kill previous node sessions."

if [[ lsof -i -P -n | grep :4000 != "" ]]; then
	killall node -9
fi
