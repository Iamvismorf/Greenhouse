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
            Hyprland.refreshMonitors();
            Hyprland.refreshToplevels();
            Hyprland.refreshWorkspaces();
        }
    }
    state: "opened"
    property real notscale: 0.10625
    property real leftExcludedZone: 0
    property real rightExcludedZone: 0
    property real bottomExcludedZone: 0
    property real topExcludedZone: 0
    required property var screen
    implicitWidth: 4
    color: Colors.foreground
    radius: 8
    property int innerPadding: 8
    topRightRadius: 0
    bottomRightRadius: 0
    implicitHeight: listview.contentHeight / 2
    property bool showWsIdTxt: false
    states: State {
        name: "opened"
        PropertyChanges {
            root.implicitWidth: (screen.width - leftExcludedZone) * notscale + 2 * listview.anchors.margins + innerPadding * 2
            root.implicitHeight: listview.contentHeight + 2 * listview.anchors.margins
            root.radius: 16
            root.color: Colors.foreground
            root.showWsIdTxt: true
        }
    }
    transitions: [
        Transition {
            from: ""
            to: "opened"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        property: "implicitHeight"
                        easing.bezierCurve: [0.468, 0.155, 0.073, 1.127, 1, 1]
                        duration: 400
                    }
                    NumberAnimation {
                        property: "radius"
                    }
                }
                ColorAnimation {
                    property: "color"
                    duration: 175
                }
                NumberAnimation {
                    property: "implicitWidth"
                    easing.bezierCurve: [0.468, 0.155, 0.073, 1.127, 1, 1]
                    duration: 600
                }
                PropertyAction {
                    property: "showWsIdTxt"
                }
            }
        },
        Transition {
            to: ""
            from: "opened"
            SequentialAnimation {
                PropertyAction {
                    property: "showWsIdTxt"
                }
                NumberAnimation {
                    property: "implicitWidth"
                    easing.bezierCurve: [0.468, 0.155, 0.073, 1.127, 1, 1]
                    duration: 600
                }
                ParallelAnimation {
                    NumberAnimation {
                        property: "implicitHeight"
                        duration: 400
                        easing.bezierCurve: [0.468, 0.155, 0.073, 1.127, 1, 1]
                    }
                    NumberAnimation {
                        property: "radius"
                    }
                }
                ColorAnimation {
                    property: "color"
                    duration: 175
                }
            }
        }
    ]
    // HoverHandler {
    //     onHoveredChanged: {
    //         if (hovered) {
    //             root.state = "opened";
    //         } else {
    //             root.state = "";
    //         }
    //     }
    // }

    ListView {
        id: listview
        anchors.margins: 16
        property int offset: model * Math.floor((Landhypr.activeWsId - 1) / model)
        currentIndex: (Landhypr.activeWsId - 1) % model
        interactive: false
        anchors.fill: parent
        model: 4
        spacing: anchors.margins
        highlightFollowsCurrentItem: false
        highlight: Rectangle {
            z: 2
            radius: root.radius - listview.spacing / 2
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
                width: 4
                color: Colors.accent
            }
        }

        delegate: Rectangle {
            id: workspaceContainer
            radius: root.radius - listview.spacing / 2
            property int wsId: index + 1 + listview.offset
            property HyprlandWorkspace workspace: Landhypr.workspaces.values.find(w => w.id == wsId) ?? null
            width: listview.width // basically (root.screen.width - excluded)*root.notscale
            implicitHeight: (root.screen.height) * root.notscale + root.innerPadding * 2
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (Landhypr.focusedWorkspace.id != wsId) {
                        Landhypr.dispatch(`workspace ${wsId}`);
                    }
                }
            }

            border {
                width: 2
                color: Colors.darkerForeground
            }
            Item {
                id: wsIdText
                opacity: root.showWsIdTxt
                Behavior on opacity {
                    NumberAnimation {}
                }
                property Item current: text1
                implicitWidth: current.implicitWidth
                implicitHeight: current.implicitHeight
                anchors.centerIn: parent
                ThisText {
                    id: text1
                }
                ThisText {
                    id: text2
                }
                TextMetrics {
                    text: workspaceContainer.wsId
                    font.pointSize: wsIdText.current.font.pointSize
                    onTextChanged: {
                        const next = wsIdText.current === text1 ? text2 : text1;
                        next.text = elidedText;
                        wsIdText.current = next;
                    }
                }
            }
            Content {}
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

    component Content: ClippingRectangle {
        id: content
        anchors.fill: parent
        color: "transparent"
        radius: workspaceContainer.radius * 6
        Repeater {
            model: workspaceContainer?.workspace?.toplevels

            delegate: Item {
                id: toplevel
                required property HyprlandToplevel modelData
                property var toplevelData: modelData.lastIpcObject
                // width: Math.min(toplevelData?.size?.[0], toplevelData?.size?.[0] - root.excludedZoneX / rep.model.values.length) * root.notscale
                width: Math.min(toplevelData?.size?.[0] * root.notscale, workspaceContainer.width - 2 * root.innerPadding)

                height: toplevelData?.size?.[1] * root.notscale
                x: Math.max(0, toplevelData?.at?.[0] - root.leftExcludedZone) * root.notscale + root.innerPadding
                y: toplevelData?.at?.[1] * root.notscale + root.innerPadding
                z: toplevelData.fullscreen ? 2 : toplevelData.floating ? 1 : 0
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
                    live: true
                    anchors.fill: parent
                    captureSource: modelData?.wayland
                    IconImage {
                        id: icon
                        anchors.centerIn: parent
                        backer.asynchronous: true
                        source: Quickshell.iconPath(DesktopEntries.byId(modelData.wayland?.appId)?.icon, true)

                        implicitSize: Math.min(Math.max(toplevel.width, toplevel.height) * 0.2, Math.max(toplevel.width, toplevel.height) * 0.25)
                    }
                }
            }
        }
    }
}
