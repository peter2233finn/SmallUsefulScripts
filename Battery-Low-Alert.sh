while true; do p=$(acpi|awk '{print $4}'|grep -o "^.."); if [ $p -lt 20 ]; then speak "Battery Low"; fi;sleep 5; done
# espeak is necessary. 20 is the battery % to trigger alert
