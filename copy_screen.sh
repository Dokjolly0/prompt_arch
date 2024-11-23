#!/bin/bash
gnome-screenshot -a -f /tmp/screenshot.png
xclip -selection clipboard -t image/png -i /tmp/screenshot.png
rm /tmp/screenshot.png