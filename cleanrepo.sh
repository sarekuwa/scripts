#!/bin/bash

if [ ! -f .gitignore ]; then
    touch .gitignore
fi
echo "cleanrepo.sh" >> .gitignore

GIT_DIR=.git

function cleanRepo() {
  git checkout main
  git checkout --orphan temp_branch
  git add -A
  git commit -m "Initial commit - clean history"
  git branch -D main
  git branch -m main
  git push -f origin main
  git log --oneline
}

function manageMenu() {
  echo "This script would reset all your repository!"
  echo "What do you want to do?"
  echo "   1) Clean"
  echo "   2) Exit"

until [[ ${MENU_OPTION} =~ ^[1-5]$ ]]; do
		read -rp "Select an option [1-2]: " MENU_OPTION
	done

	case "${MENU_OPTION}" in
	1)
		cleanRepo
		;;
	2) 
                exit 0
                ;;
        esac
}

if [[ -e "${GIT_DIR}" ]]; then
	manageMenu
fi
