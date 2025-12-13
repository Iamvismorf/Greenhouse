//https://forum.qt.io/topic/144070/qt6-color-svg-using-multieffect/14
//https://forum.qt.io/topic/159818/qt-6-8-vectorimage-and-color-colorization-issues-with-multieffect/2
import QtQuick
import QtQuick.Effects
import Quickshell.Widgets

Item {
    id: root
    required property string sauce
    required property color fillColor
    property int size: 28
    implicitWidth: keyboardIcon.implicitWidth
    implicitHeight: keyboardIcon.implicitHeight
    IconImage {
        id: keyboardIcon
        implicitSize: root.size
        source: root.sauce
    }
    MultiEffect {
        source: keyboardIcon
        anchors.fill: keyboardIcon
        brightness: 1
        colorization: 1
        colorizationColor: root.fillColor
    }
}
