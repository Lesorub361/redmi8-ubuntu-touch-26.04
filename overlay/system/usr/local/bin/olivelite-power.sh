#!/bin/sh
CMD_FILE=/tmp/olivelite-power.cmd
[ -f "$CMD_FILE" ] || exit 0
ACT=$(cat "$CMD_FILE" 2>/dev/null | tr -d "\r\n ")
rm -f "$CMD_FILE"
sync
case "$ACT" in
    poweroff) exec /usr/bin/systemctl poweroff ;;
    reboot) exec /usr/bin/systemctl reboot ;;
    recovery) /usr/bin/systemctl reboot --reboot-argument=recovery 2>/dev/null || /usr/sbin/reboot recovery ;;
    bootloader|fastboot) /usr/bin/systemctl reboot --reboot-argument=bootloader 2>/dev/null || /usr/sbin/reboot bootloader ;;
esac
