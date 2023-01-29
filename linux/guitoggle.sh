#!/bin/bash
# A simple script to switch between CLI and GUI
# Ludovic Agathe <ludovic.agathe@gmail.com> - 26 January 2023

MY_DESKTOP=$(sudo systemctl get-default);

if [[ $MY_DESKTOP == multi-user.target ]]; then
  echo "Using CLI";
  sudo systemctl set-default graphical;
  if [[ ! $(sudo systemctl get-default) == graphical.target ]]; then
    echo "There was a problem and the system was not changed";
    unset MY_DESKTOP;
    exit 1;
  fi;
  echo "Switched to Desktop successfully";
fi;
if [[ $MY_DESKTOP == graphical.target ]]; then
  echo "Using Desktop";
  sudo systemctl set-default multi-user;
  if [[ ! $(sudo systemctl get-default) == multi-user.target ]]; then
    echo "There was a problem and the system was not changed"
    unset MY_DESKTOP;
    exit 1;
  fi;
  echo "Switched to CLI successfully";
fi;

read -p "A restart is required for changes to take effect. Restart now? (y/n): " MY_DESKTOP;

if [[ $MY_DESKTOP == y || $MY_DESKTOP == Y ]]; then
  unset MY_DESKTOP;
  sudo reboot;
fi;

unset MY_DESKTOP;
exit 0;
