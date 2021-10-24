#!/bin/bash 

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${DIR}"/../.env

clear

TOTAL_STEPS=3
CURRENT_STEP=0

echo -e "${COLOR_GREEN} Welcome to ${PROJECT_NAME} installer! ${COLOR_GREEN} \n\n\n"
echo -e "${COLOR_GREEN} Preparing for installation..."

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Cloning API and Front applications... \n"

if [[ -d ${API_DIR} ]]; then
  cd "${API_DIR}"
  git pull origin "${API_GIT_BRANCH}"
  cd "${DIR}"/..
else
  git clone --single-branch --branch "${API_GIT_BRANCH}" "${API_GIT_REPO}" "${API_DIR}"
fi

if [[ -d ${FRONT_DIR} ]]; then
  cd "${FRONT_DIR}"
  git pull origin "${FRONT_GIT_BRANCH}"
  cd "${DIR}"/..
else
  git clone --single-branch --branch "${FRONT_GIT_BRANCH}" "${FRONT_GIT_REPO}" "${FRONT_DIR}"
fi

echo -e "\n\n\n"

CURRENT_STEP=$((CURRENT_STEP + 1))

echo -e "${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Installing packages. \n\n\n"

cd "${API_DIR}"
npm install

cd "${DIR}"/..

cd "${FRONT_DIR}"
npm install
cd "${DIR}"/..


CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Restarting containers...\n\v${COLOR_NONE}"
docker-compose down
docker-compose pull
docker-compose up -d --remove-orphans

