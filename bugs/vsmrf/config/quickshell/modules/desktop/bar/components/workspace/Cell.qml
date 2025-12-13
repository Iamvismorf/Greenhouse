//todo: listview highligh animation too rapid
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config.bar
import qs.custom
import qs.config
import Quickshell.Widgets

WrapperMouseArea {
    id: cat
    required property int index
    required property int offset
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    property real barWidth
    property real arrowSize
    resizeChild: false
    property point mainPoint
    onPressed: {
        if (Landhypr.focusedWorkspace.id != root.wsId) {
            Landhypr.dispatch(`workspace ${root.wsId}`);
        }
    }
    Component.onCompleted: Qt.callLater(function () {
        cat.mainPoint = Qt.binding(function () {
            return cat.mapFromItem(notRoot, notRegular.x, notRegular.y);
        });
    })
    Item {
        implicitWidth: cat.barWidth
        implicitHeight: notRoot.implicitHeight
        Item {
            id: notRoot
            implicitWidth: Workspacescfg.cell.focusedTick - cat.arrowSize
            implicitHeight: root.implicitHeight
            anchors.horizontalCenter: parent.horizontalCenter

            ColumnLayout {
                id: root
                property int wsId: index + 1 + cat.offset
                function isCurrentWs() {
                    if (root.wsId == Landhypr.focusedWorkspace?.id) {
                        return true;
                    }
                    return false;
                }

                spacing: 4
                Repeater {
                    model: 2
                    delegate: RegularTick {}
                }
                MainTick {
                    id: notRegular
                }
                Repeater {
                    model: 3
                    delegate: RegularTick {}
                }
            }
        }
    }
    component RegularTick: Rectangle {
        height: 2
        implicitWidth: Workspacescfg.cell.regularTick
        color: Workspacescfg.cell.regularTickColor
    }
    component MainTick: Rectangle {
        id: tick
        implicitHeight: 2
        state: ""
        implicitWidth: Workspacescfg.cell.unfocusedTick
        color: Workspacescfg.cell.unfocusedTickColor
        states: [
            State {
                name: "focused"
                when: root.isCurrentWs()
                PropertyChanges {
                    target: tick
                    implicitWidth: Workspacescfg.cell.focusedTick
                    color: Workspacescfg.cell.focusedTickColor
                }
                PropertyChanges {
                    target: wsIdTxt
                    opacity: 1
                }
            },
            State {
                name: "hovered"
                when: cat.containsMouse
                PropertyChanges {
                    target: tick
                    implicitWidth: Workspacescfg.cell.focusedTick
                    color: Workspacescfg.cell.focusedTickColor
                }
                PropertyChanges {
                    target: wsIdTxt
                    opacity: 0
                }
            }
        ]
        transitions: [
            Transition {
                to: "focused"
                reversible: true
                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnimation {
                            property: "implicitWidth"
                            duration: 400
                        }
                        ColorAnimation {
                            duration: 400
                        }
                    }
                    NumberAnimation {
                        property: "opacity"
                        duration: 400
                    }
                }
            },
            Transition {
                to: "hovered"
                reversible: true
                NumberAnimation {
                    property: "implicitWidth"
                    duration: 400
                }
                ColorAnimation {
                    duration: 400
                }
            }
        ]
        StyledText {
            id: wsIdTxt
            opacity: 0
            text: root.wsId
            font.pointSize: Fontcfg.small
            x: tick.width / 2
            y: tick.height * 2
        }
    }
}
