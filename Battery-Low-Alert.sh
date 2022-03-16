while true; do p=$(acpi|awk '{print $4}'|grep -o "^.."); [ $p -lt 30 ] && (s=$(acpi|tr -d ','|awk '{print $3}'); [ "$s" = "Discharging" ] && espeak "Battery Low"); sleep 5; done
# espeak is necessary. 20 is the battery % to trigger alert
