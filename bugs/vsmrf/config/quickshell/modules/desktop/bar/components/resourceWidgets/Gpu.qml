import Quickshell
import QtQuick
import Vixhardware as VH

CircularProgressIndicator {
    id: root
    //todo: fix this
    value: VH.Gpu.sockets[0].gpus[0].gfx / 100
    iconSauce: Quickshell.iconPath(Quickshell.shellPath("assets/gpu.svg"))
    iconSize: 18
}
