import QtQuick
import qs.services
import Quickshell

Image {
    fillMode: Image.PreserveAspectFit
    source: Quickshell.iconPath(Quickshell.shellPath("assets/eyePink.jpeg"))
    sourceSize.width: parent.width
    sourceSize.height: parent.height
    asynchronous: true
}
