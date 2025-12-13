import QtQuick
import qs.custom
import qs.config.bar
import Quickshell.Widgets

Item {
    implicitWidth: OsIconcfg.iconSize
    implicitHeight: OsIconcfg.iconSize
    NerdFontText {
        id: osIcon
        text: "󱄅"
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: OsIconcfg.iconSize
    }
}
