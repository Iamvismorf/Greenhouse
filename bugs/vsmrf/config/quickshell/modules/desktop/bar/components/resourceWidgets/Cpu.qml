import QtQuick
import QtQuick.Controls
import qs.services
import Quickshell
import Vixhardware as VH
import qs.custom
import QtQuick.Layouts
import QtQuick.VectorImage

CircularProgressIndicator {
    id: root
    value: VH.Cpu.utilized
    iconSize: 16
    iconSauce: Quickshell.iconPath(Quickshell.shellPath("assets/cpu.svg"))
}
