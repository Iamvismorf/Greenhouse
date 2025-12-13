//todo: missing icons the first time overview
//todo: mouse interaction
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import "scratchpad"
import qs.config.utilWidgets
import qs.custom
import qs.services
import "bar"
import "osd"
import "osd/notifications"
import "utilWidgets"

Variants {
    model: Quickshell.screens
    Scope {
        required property ShellScreen modelData
        GlobalShortcut {
            name: "toggleOverview"
            onPressed:
            // wsOverview.shouldBeActive = !wsOverview.shouldBeActive;
            // Hyprland.dispatch("togglespecialworkspace penis");
            // testldr.active = !testldr.active;
            {}
        }
        // GlobalShortcut {
        //     name: "toggleScratchpad"
        //     onPressed: {
        //         Hyprland.dispatch("togglespecialworkspace magic");
        //         if (!scratchpad.active) {
        //             scratchpad.active = true;
        //         } else {
        //             scratchpad.opacity = !scratchpad.opacity;
        //         }
        //     }
        // }

        // WlrLayershell {
        //     layer: WlrLayer.Bottom
        //     anchors.right: true
        //     anchors.top: true
        //     anchors.bottom: true
        //     anchors.left: true
        //     color: "transparent"
        //     exclusionMode: ExclusionMode.Ignore
        //     OnScreenClock {
        //         id: onscreenclock
        //         // z: -999
        //         anchors.right: parent.right
        //         anchors.top: parent.top
        //         anchors.margins: 128
        //         DragHandler {
        //             onActiveChanged: {
        //                 if (active) {
        //                     onscreenclock.anchors.right = undefined;
        //                     onscreenclock.anchors.top = undefined;
        //                 }
        //             }
        //         }
        //     }
        // }
        StyledPanelWindow {
            id: root

            // WlrLayershell.layer: WlrLayer.Top
            // mask: region
            WlrLayershell.layer: WlrLayer.Bottom
            exclusiveZone: bar.implicitWidth
            implicitWidth: modelData.width
            anchors {
                top: true
                left: true
                bottom: true
            }

            // mask: (root.WlrLayershell.layer == WlrLayer.Top) ? region : null
            //
            // property int length: Landhypr.focusedWorkspace?.toplevels?.values.length ?? -1
            // onLengthChanged: {
            //     if (length > 0) {
            //         root.WlrLayershell.layer = WlrLayer.Top;
            //     } else if (length == 0) {
            //         root.WlrLayershell.layer = WlrLayer.Bottom;
            //     }
            // }
            MouseArea {
                id: cat
                anchors.fill: parent
                hoverEnabled: true
                onClicked: m => {
                    let effectComponent = Qt.createComponent("ClickEffect.qml");
                    if (effectComponent.status === Component.Ready) {
                        effectComponent = effectComponent.createObject(root.contentItem);
                        effectComponent.x = m.x - effectComponent.width / 2; // Center horizontally
                        effectComponent.y = m.y - effectComponent.height;
                    }
                }
            }

            Bar {
                id: bar
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            OnScreenClock {
                id: onscreenclock
                z: -999
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 128
                DragHandler {
                    onActiveChanged: {
                        if (active) {
                            onscreenclock.anchors.right = undefined;
                            onscreenclock.anchors.top = undefined;
                        }
                    }
                }
            }
            // Loader {
            //     id: scratchpad
            //     z: -1000
            //     active: false
            //     opacity: active
            //     visible: opacity
            //     Behavior on opacity {
            //         NumberAnimation {}
            //     }
            //     anchors.centerIn: parent
            //     anchors.fill: parent
            //     sourceComponent: Scratchpad {}
            // }
        }
        WlrLayershell {
            layer: WlrLayer.Overlay
            mask: Region {
                id: region
                Region {
                    item: volumeosd.item
                }
                Region {
                    item: keyboardosd.item
                }
                Region {
                    item: notifPanel.item?.contentItem ? notifPanel.item.contentItem : notifPanel.item
                }
                Region {
                    // item: wsOverview.item ? wsOverview : null
                    item: wsOverview
                }
                // Region {
                //     item: penis
                // }
                Region {
                    item: logoutpan
                }
            }
            anchors {
                right: true
                left: true
                bottom: true
                top: true
            }
            exclusionMode: ExclusionMode.Ignore
            // exclusiveZone: 0
            color: "transparent"
            VolumeOsd {
                id: volumeosd
                anchors.centerIn: parent
            }
            KeyboardOsd {
                id: keyboardosd
                anchors.centerIn: parent
            }
            NotificationPanel {
                id: notifPanel
                anchors.top: parent.top
                anchors.topMargin: 24
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Overview {
                id: wsOverview
                anchors.right: parent.right
                anchors.rightMargin: 200
                anchors.verticalCenter: parent.verticalCenter
                screen: modelData
                leftExcludedZone: bar.implicitWidth
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            wsOverview.state = "opened";
                        } else {
                            wsOverview.state = "";
                        }
                    }
                }
            }

            Logout {
                id: logoutpan
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            logoutpan.state = "opened";
                        } else {
                            logoutpan.state = "";
                        }
                    }
                }
            }
            // Loader {
            //     id: wsOverview
            //     active: false
            //     visible: active
            //     onLoaded: {
            //         anchors.rightMargin = -item.implicitWidth;
            //         start = -item.implicitWidth;
            //     }
            //     // anchors.rightMargin: 32
            //     property real start
            //     property bool shouldBeActive: false
            //     HoverHandler {
            //         onHoveredChanged: {
            //             if (hovered) {
            //                 wsOverview.shouldBeActive = true;
            //             } else {
            //                 wsOverview.shouldBeActive = false;
            //             }
            //         }
            //     }
            //     // scale: 0.8
            //
            //     states: [
            //         State {
            //             name: "open"
            //             when: wsOverview.shouldBeActive
            //             PropertyChanges {
            //                 wsOverview.active: true
            //                 wsOverview.anchors.rightMargin: 20
            //                 wsOverview.scale: 1
            //             }
            //         }
            //     ]
            //     transitions: [
            //         Transition {
            //             from: "open"
            //             to: ""
            //             SequentialAnimation {
            //                 SequentialAnimation {
            //                     // NumberAnimation {
            //                     //     target: wsOverview
            //                     //     property: "scale"
            //                     //     duration: 600
            //                     //     easing.bezierCurve: [0.411, 0.015, 0.26, 0.912, 1, 1]
            //                     // }
            //                     NumberAnimation {
            //                         target: wsOverview.anchors
            //                         property: "rightMargin"
            //                         to: wsOverview.start
            //                         duration: 600
            //                         easing.bezierCurve: [0.411, 0.015, 0.26, 0.912, 1, 1]
            //                     }
            //                     //add opacity fade
            //                 }
            //                 PropertyAction {
            //                     target: wsOverview
            //                     property: "active"
            //                 }
            //             }
            //         },
            //         Transition {
            //             from: ""
            //             to: "open"
            //             SequentialAnimation {
            //                 PropertyAction {
            //                     target: wsOverview
            //                     property: "active"
            //                 }
            //                 SequentialAnimation {
            //                     NumberAnimation {
            //                         target: wsOverview.anchors
            //                         property: "rightMargin"
            //                         duration: 600
            //                         easing.bezierCurve: [0.411, 0.015, 0.26, 0.912, 1, 1]
            //                     }
            //                     // NumberAnimation {
            //                     //     target: wsOverview
            //                     //     property: "scale"
            //                     //     duration: 600
            //                     //     easing.bezierCurve: [0.411, 0.015, 0.26, 0.912, 1, 1]
            //                     // }
            //                 }
            //             }
            //         }
            //     ]
            //     anchors.verticalCenter: parent.verticalCenter
            //     anchors.right: parent.right
            //     sourceComponent: WorkspaceOverview {
            //         id: sth
            //         screen: modelData
            //         excludedZoneX: bar.implicitWidth
            //     }
            // }
        }
        // WlrLayershell {
        //     id: bottompan
        //     exclusiveZone: implicitHeight
        //     anchors.right: true
        //     anchors.left: true
        //     anchors.bottom: true
        //     implicitHeight: 4
        //     layer: WlrLayer.Background
        //     color: "transparent"
        // }
        // WlrLayershell {
        //     id: rightpan
        //     anchors.right: true
        //     anchors.top: true
        //     anchors.bottom: true
        //     implicitWidth: 4
        //     exclusiveZone: implicitWidth
        //     layer: WlrLayer.Top
        //     color: "transparent"
        //     // Rectangle {
        //     //     id: dick
        //     //     radius: 4
        //     //     color: Colors.foreground
        //     //     anchors.verticalCenter: parent.verticalCenter
        //     //     anchors.left: parent.left
        //     //     anchors.right: parent.right
        //     //     implicitHeight: 256
        //     //     HoverHandler {
        //     //         onHoveredChanged: {
        //     //             if (hovered) {
        //     //                 wsOverview.shouldBeActive = true;
        //     //             } else {
        //     //                 wsOverview.shouldBeActive = false;
        //     //             }
        //     //         }
        //     //     }
        //     // }
        // }
    }
}
