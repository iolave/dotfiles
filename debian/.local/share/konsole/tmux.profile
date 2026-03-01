[General]
Command=/usr/bin/sh -ilc "tmux attach &> /dev/null || sh .config/tmux/create-sessions.sh && tmux attach"
Name=tmux
Parent=FALLBACK/

[Keyboard]
KeyBindings=macos
