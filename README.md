# The idea for this project is a shell for archlinux+hyprland, aiming for it to be modular and with auto theming based on wallpaper.

## The bar:
- On the right basic things: workspace indicators, clock, system info, wifi, bluetooth
- Now whats interesting:
On the middle there will be some text(middletext) and on the left theres a bar (inputbar), these are basically connected;
By default on the input bar there will be buttons for audio control and in the middle text a default text and if audio is playing, whats playing.
By pressing a combination of buttons the input bar can change into various modes like super+l for launch mode, where it will basically act as wofi or super+/ for command mode where you can input a custom comand that will be pre-coded, for example "system" to open a terminal with btop, or "suspend" to suspend pc etc.. The middletext should change to tell what mode youre in. it should return to the default after doing whatever.


## Structure:
- `shell.qml` - root shell, layers and IPC
- `config/` - shared config and theme
- `components/` - reusable QML components
- `modules/bar/left/` - input bar, audio controls and mode inputs
- `modules/bar/center/` - middle status text
- `modules/bar/right/` - stats, network, bluetooth, workspaces and clock
- `modules/wallpaper/` - wallpaper background layer
- `services/audio/` - audio and media state
- `services/input/` - mode and command state
- `services/system/` - stats, network and bluetooth state
- `services/theme/` - wallpaper state and auto-theming

## Wallpaper changer:
- Cycle with SUPER+W; choice saved to `~/.cache/inash-wallpaper`

## Notifications:
- To do

## ..

## Extra
pkill -f "qs -c inashell"
