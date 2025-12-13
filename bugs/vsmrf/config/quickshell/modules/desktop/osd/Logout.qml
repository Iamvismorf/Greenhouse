import qs.custom
import QtQuick.Layouts
import qs.services
import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
    id: root
    signal confirmPopup(proc: var)
    states: State {
        name: "opened"
        PropertyChanges {
            root.implicitHeight: row.implicitHeight + 2 * row.anchors.margins
            root.color: Colors.background
        }
    }
    transitions: [
        Transition {
            from: ""
            to: "opened"
            SequentialAnimation {
                ColorAnimation {
                    property: "color"
                    duration: 175
                }
                NumberAnimation {
                    property: "implicitHeight"
                    easing.bezierCurve: [0.242, 1.9, 0.586, 1.193, 1, 1]
                    duration: 600
                }
            }
        },
        Transition {
            from: "opened"
            to: ""
            SequentialAnimation {
                NumberAnimation {
                    property: "implicitHeight"
                    easing.bezierCurve: [0.242, 1.9, 0.586, 1.193, 1, 1]
                    duration: 600
                }
                ColorAnimation {
                    property: "color"
                    duration: 175
                }
            }
        }
    ]

    implicitWidth: row.implicitWidth + 2 * row.anchors.rightMargin
    implicitHeight: 4
    topRightRadius: 16
    topLeftRadius: 16
    color: Colors.foreground
    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 18
        anchors.rightMargin: spacing
        anchors.leftMargin: spacing
        spacing: 36
        ThisSvgIcon {
            sauce: Quickshell.iconPath(Quickshell.shellPath("assets/off.svg"))
            action: ThisProc {
                id: shutdown
                // command: ["shutdown", "now"]
                command: ["echo", "shutingdown"]
            }
        }
        ThisSvgIcon {
            sauce: Quickshell.iconPath(Quickshell.shellPath("assets/reboot.svg"))
            action: ThisProc {
                id: restart
                // command: ["restart"]
                command: ["echo", "restarting"]
            }
        }
        ThisSvgIcon {
            sauce: Quickshell.iconPath(Quickshell.shellPath("assets/moon.svg"))
            action: ThisProc {
                id: sleep
                // command: ["systemctl", "suspend"]
                command: ["echo", "sthwrong"]
            }
        }
        ThisSvgIcon {
            sauce: Quickshell.iconPath(Quickshell.shellPath("assets/logout.svg"))
            action: ThisProc {
                id: logout
                // command: ["uwsm", "stop"]
                command: ["echo", "stoppls"]
            }
        }
    }
    component ThisProc: Process {
        running: false
        stdout: StdioCollector {
            onStreamFinished: console.log(this.text)
        }
    }
    component ThisSvgIcon: SvgIcon {
        id: shit
        size: 36
        fillColor: mouse.pressed ? Colors.darkerForeground : Colors.foreground
        required property Process action
        Behavior on fillColor {
            ColorAnimation {
                duration: 175
            }
        }
        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                root.confirmPopup(shit.action);
            }
        }
    }
}
