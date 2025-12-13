//@ pragma IconTheme Papirus-Dark
//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
import QtQuick
import Quickshell
import qs.services
import Quickshell.Widgets
import Quickshell.Wayland
import qs.modules.desktop
import Quickshell.Hyprland

ShellRoot {
    Desktop {}
}
