#!/usr/bin/env python3
import time
SRC = "/sys/class/leds/lcd-backlight/brightness"
DST = "/sys/devices/virtual/ktd3137/ktd/ktd_brightness_reg"
last = None
while True:
    try:
        with open(SRC) as f:
            v = int(f.read().strip())
        if v != last:
            hw = 0 if v <= 0 else max(1, min(255, int(round(v * 255.0 / 255.0))))
            with open(DST, "w") as f:
                f.write(str(hw))
            last = v
    except Exception:
        pass
    time.sleep(0.08)
