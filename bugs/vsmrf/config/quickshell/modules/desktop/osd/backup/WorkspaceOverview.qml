// todo: implement drag and drop
//todo: spacing between windows when ws is not updated
import QtQuick
import Quickshell.Wayland
import Quickshell
import qs.services
import qs.custom
import Quickshell.Hyprland
import Quickshell.Widgets

Rectangle {
    id: root
    FrameAnimation {
        running: true
        onTriggered: {
            // Hyprland.refreshWorkspaces();
            Hyprland.refreshToplevels();
        }
    }
    required property var screen
    property real excludedZoneX: 0
    property real excludedZoneY: 0
    // color: Colors.background
    color: "white"
    // implicitWidth: listview.implicitWidth + spacing * 2
    implicitHeight: listview.implicitHeight + spacing * 2
    property int spacing: 16
    radius: implicitWidth == 4 ? 4 : 20
    topRightRadius: 0
    bottomRightRadius: 0
    property real notscale: 0.10625
    property int highlightBorderWidth: 4
    property int innerPadding: 8
    ListView {
        id: listview
        property int shown: 4
        interactive: false
        property int offset: shown * Math.floor((Landhypr.activeWsId - 1) / shown)
        currentIndex: (Landhypr.activeWsId - 1) % shown
        anchors.centerIn: parent
        model: shown
        spacing: parent.spacing
        implicitWidth: (root.screen.width - root.excludedZoneX) * root.notscale + 2 * root.innerPadding
        implicitHeight: contentHeight
        highlightFollowsCurrentItem: false
        highlight: Rectangle {
            z: 2
            radius: root.radius - root.spacing / 2
            color: "transparent"
            y: listview.currentItem.y
            width: listview.currentItem.width
            height: listview.currentItem.height
            Behavior on y {
                NumberAnimation {
                    duration: 800
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: [0, 0, 0, 1, 1, 1]
                }
            }
            border {
                width: root.highlightBorderWidth
                color: Colors.accent
            }
        }
        delegate: Rectangle {
            //ws container
            id: ws
            radius: root.radius - root.spacing / 2
            implicitWidth: (root.screen.width - root.excludedZoneX) * root.notscale + 2 * root.innerPadding
            implicitHeight: (root.screen.height - root.excludedZoneY) * root.notscale + 2 * root.innerPadding
            color: "transparent"
            property int wsId: index + 1 + listview.offset
            border {
                width: 2
                color: Colors.darkerForeground
            }
            // DropArea {
            //     anchors.fill: parent
            // }

            // onWsIdChanged: wrap.opacity = !wrap.opacity
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (Landhypr.focusedWorkspace.id != ws.wsId) {
                        Landhypr.dispatch(`workspace ${ws.wsId}`);
                    }
                }
            }
            Item {
                id: wsIdText
                implicitWidth: current.implicitWidth
                implicitHeight: current.implicitHeight
                property Item current: text1
                anchors.centerIn: parent
                ThisText {
                    id: text1
                }
                ThisText {
                    id: text2
                }
                TextMetrics {
                    text: ws.wsId
                    font.pointSize: 28
                    onTextChanged: {
                        const next = wsIdText.current === text1 ? text2 : text1;
                        next.text = elidedText;
                        wsIdText.current = next;
                    }
                }
            }
            onWorkspaceChanged: {
                if (!workspace) {
                    destroyAnim.start();
                }
            }
            property HyprlandWorkspace workspace: Landhypr.workspaces.values.find(w => w.id == ws.wsId) ?? null
            onWsIdChanged: {
                destroyAnim.start();
                createAnim.start();
            }
            Content {
                NumberAnimation on opacity {
                    id: destroyAnim
                    to: 0
                    duration: 400
                }
            }
            Content {
                NumberAnimation on opacity {
                    id: createAnim
                    from: 0
                    to: 1
                    duration: 800
                }
            }
        }
    }
    component ThisText: StyledText {
        // opacity: !ws.workspace?.toplevels?.values?.length && wrapper.current == this ? 1 : 0
        opacity: wsIdText.current == this ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
        anchors.centerIn: parent
        color: Colors.darkerForeground
        font.pointSize: 28
    }
    component Content: Item {
        id: wrap
        anchors.fill: parent
        Repeater {
            id: repeater
            //toplevel
            model: ws.workspace?.toplevels
            delegate: ClippingRectangle {
                id: window
                required property HyprlandToplevel modelData
                property var toplevelData: modelData.lastIpcObject
                Drag.active: drug.drag.active
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2
                MouseArea {
                    id: drug
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: {
                        if (modelData.address)
                            Landhypr.dispatch(`focuswindow address:0x${modelData.address}`);
                    }
                    // drag.target: window
                }
                color: "transparent"
                radius: listview.highlightItem.radius - root.innerPadding
                width: Math.min(toplevelData?.size?.[0] * root.notscale, ws.implicitWidth - root.innerPadding * 2)
                height: toplevelData?.size?.[1] * root.notscale
                x: Math.max((toplevelData?.at?.[0] - root.excludedZoneX), 0) * root.notscale + root.innerPadding
                y: (toplevelData?.at?.[1] - root.excludedZoneY) * root.notscale + root.innerPadding
                z: toplevelData.fullscreen ? 2 : toplevelData.floating ? 1 : 0
                scale: width > implicitWidth ? 1 : 0
                Behavior on scale {
                    NumberAnimation {
                        alwaysRunToEnd: true
                        duration: 400
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: [0.05, 0.7, 0.1, 1, 1, 1]
                    }
                }
                Behavior on y {
                    enabled: scale > 0
                    NumberAnimation {}
                }
                Behavior on x {
                    enabled: scale > 0
                    NumberAnimation {}
                }

                ScreencopyView {
                    id: screencopyview
                    live: true
                    anchors.fill: parent
                    captureSource: modelData?.wayland

                    property bool shouldLoadIcon
                    IconImage {
                        id: icon
                        anchors.centerIn: parent
                        backer.asynchronous: true
                        source: Quickshell.iconPath(DesktopEntries.byId(modelData.wayland?.appId)?.icon, true)

                        implicitSize: Math.min(Math.max(window.width, window.height) * 0.2, Math.max(window.width, window.height) * 0.25)
                    }
                    // todo: color quantization
                    // Loader {
                    //     id: fullscreenStateLdr
                    //     property bool shouldBeActive: toplevelData.fullscreen
                    //     active: false
                    //     anchors.top: icon.bottom
                    //     anchors.horizontalCenter: icon.horizontalCenter
                    //     opacity: 0
                    //     scale: 0.9
                    //     states: State {
                    //         name: "active"
                    //         when: fullscreenStateLdr.shouldBeActive
                    //         PropertyChanges {
                    //             fullscreenStateLdr.active: true
                    //             fullscreenStateLdr.opacity: 1
                    //             fullscreenStateLdr.scale: 1
                    //         }
                    //     }
                    //     transitions: [
                    //         Transition {
                    //             from: "active"
                    //             to: ""
                    //
                    //             SequentialAnimation {
                    //                 NumberAnimation {
                    //                     properties: "opacity, scale"
                    //                     duration: 250
                    //                 }
                    //                 PropertyAction {
                    //                     target: fullscreenStateLdr
                    //                     property: "active"
                    //                 }
                    //             }
                    //         },
                    //         Transition {
                    //             from: ""
                    //             to: "active"
                    //
                    //             SequentialAnimation {
                    //                 PropertyAction {
                    //                     target: fullscreenStateLdr
                    //                     property: "active"
                    //                 }
                    //                 NumberAnimation {
                    //                     properties: "opacity, scale"
                    //                     duration: 250
                    //                 }
                    //             }
                    //         }
                    //     ]
                    //     sourceComponent: StyledText {
                    //         color: Colors.darkerForeground
                    //         text: "Fullscreen"
                    //         font.pointSize: 20
                    //     }
                    // }
                }
            }
        }
    }
}
