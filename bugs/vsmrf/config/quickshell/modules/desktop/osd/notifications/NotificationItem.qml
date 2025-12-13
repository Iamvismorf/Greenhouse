//todo: if image exist render app icon in the right bottom corner like android does
//redesign this shit
//mb when click to delete close the popout first then dismiss. Because you can see it
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config.osd
import qs.config
import Quickshell.Widgets
import Quickshell.Services.Notifications
import qs.custom
import Quickshell

WrapperMouseArea {
    id: wrapm
    hoverEnabled: true
    onEntered: {
        lifeTime.restart();
        lifeTime.stop();
    }
    onExited: {
        lifeTime.start();
    }
    opacity: (width - Math.abs(x)) / width

    Item {
        id: root
        Behavior on x {
            // snapback animation
            NumberAnimation {
                duration: 500
                easing.type: Easing.BezierSpline
                easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
            }
        }
        implicitWidth: Notificationscfg.notificationCard.width
        implicitHeight: notifCard.implicitHeight
        opacity: (width - Math.abs(x)) / width
        Timer {
            id: lifeTime
            interval: Notificationscfg.notificationCard.lifeTime
            running: true
            onTriggered: modelData.dismiss()
        }
        Rectangle {
            implicitWidth: Notificationscfg.notificationCardPopup.width
            opacity: (notifCard.implicitWidth == Notificationscfg.notificationCard.width) ? 0 : 1
            implicitHeight: notifCard.implicitHeight
            topRightRadius: Notificationscfg.notificationCard.outerRadius
            bottomRightRadius: Notificationscfg.notificationCard.outerRadius
            anchors.right: root.right
            color: Colors.accent
            Rectangle {
                opacity: (notifCard.implicitWidth == Notificationscfg.notificationCard.width) ? 0 : 1
                implicitWidth: Notificationscfg.notificationCardPopup.width
                anchors.right: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: Colors.accent
            }
            ColumnLayout {
                spacing: 0
                anchors.fill: parent

                ThisSvgIcon {
                    sauce: Quickshell.iconPath(Quickshell.shellPath("assets/openFilled.svg"))
                    MouseArea {
                        id: openMa
                        anchors.fill: parent
                        property NotificationAction defaultAction
                        enabled: {
                            // or view ig
                            let defaultAction = modelData.actions.find(a => a.identifier.toLowerCase() == "default");
                            if (modelData.actions.length == 0 || !defaultAction)
                                return false;

                            openMa.defaultAction = defaultAction;
                            return true;
                        }
                        cursorShape: openMa.enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                        onClicked: {
                            openMa.defaultAction.invoke();
                        }
                    }
                }
                Rectangle {
                    width: Notificationscfg.notificationCardPopup.width - 2 * Notificationscfg.notificationCard.padding
                    height: 2
                    color: Colors.foreground
                    Layout.alignment: Qt.AlignHCenter
                }
                ThisSvgIcon {
                    sauce: Quickshell.iconPath(Quickshell.shellPath("assets/dumpster.svg"))
                    mouseArea.onClicked: {
                        modelData.dismiss();
                        // NotificationManager.dismissNotif(modelData.notificationId);
                    }
                }
            }
        }
        Rectangle {
            id: notifCard
            // property real shrinkX: {
            //     // if (!ma.pressed) {
            //     //     return 0;
            //     // }
            //     return 0;
            // }
            property bool shrinkX: false
            property bool expandY: false
            implicitWidth: Notificationscfg.notificationCard.width - (shrinkX ? 44 : 0)
            implicitHeight: Notificationscfg.notificationCard.height + 2 * Notificationscfg.notificationCard.padding + (expandY ? 56 : 0)
            // property real shrinkX: 0
            // property real expandY: 0
            // implicitWidth: Notificationscfg.notificationCard.width - shrinkX
            // implicitHeight: Notificationscfg.notificationCard.height + 2 * Notificationscfg.notificationCard.padding + expandY
            radius: Notificationscfg.notificationCard.outerRadius
            color: Notificationscfg.notificationCard.background
            border {
                width: 2
                color: Colors.accent
            }
            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 250
                }
            }
            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 250
                }
            }

            property bool popupClosed: false
            onShrinkXChanged: {
                if (!notifCard.shrinkX) {
                    notifCard.popupClosed = true;
                } else {
                    notifCard.popupClosed = false;
                }
            }
            MouseArea {
                id: ma
                hoverEnabled: true

                property bool pressed: false
                property bool enableDismiss: true
                property string currentAxis: ""
                property bool rootLocked: {
                    // only allow draggin root item
                    if (drug.active) {
                        return true;
                    }
                    return false;
                }
                property real startX: 0
                property real startY: 0
                anchors.fill: parent
                drag {
                    id: drug
                    target: enableDismiss ? root : null
                    axis: Drag.XAxis
                    minimumX: 0
                    maximumX: root.width * 0.65
                    onActiveChanged: {
                        if (Math.abs(root.x) < drug.maximumX)
                            root.x = 0;
                        else
                            modelData.dismiss();
                        // NotificationManager.dismissNotif(modelData.notificationId);
                    }
                }
                onPressed: e => {
                    pressed = true;
                    startX = e.x;
                    startY = e.y;
                }
                onReleased: {
                    pressed = false;
                    // rootLocked = false;
                    // if (notifCard.shrinkX == 0) {
                    if (!notifCard.shrinkX) {
                        // if popup is closed
                        ma.enableDismiss = true;
                    }
                    ma.currentAxis = "";
                }
                onPositionChanged: e => {
                    if (pressed && !rootLocked) {
                        // draggin in x axis
                        let deltaX = e.x - startX;
                        let deltaY = e.y - startY;
                        if (ma.currentAxis == "") {
                            ma.currentAxis = (Math.abs(deltaX) > Math.abs(deltaY)) ? "x" : "y";
                        }
                        if (ma.currentAxis == "x") {
                            if (Math.abs(deltaX) > 44) {
                                // notifCard.shrinkX = Math.max(0, Math.min(44, -deltaX));
                                notifCard.shrinkX = deltaX < 0;
                                ma.enableDismiss = false; // disable dismiss when popup is opened. First must close popup
                            }
                        } else {
                            if (Math.abs(deltaY) > 56) {
                                // notifCard.expandY = Math.max(0, Math.min(44, deltaY));
                                notifCard.expandY = deltaY > 0;
                                ma.enableDismiss = false; // disable dismiss when popup is opened. First must close popup
                            }
                        }
                    }
                }
            }

            RowLayout {
                // spacing: 0
                id: rowlayout
                anchors.top: parent.top
                anchors.left: parent.left
                Component.onCompleted: {
                    spacing = (notifCard.height - (notifCard.height * 0.6 | 0)) / 2;
                    anchors.topMargin = (notifCard.height - (notifCard.height * 0.6 | 0)) / 2;
                    anchors.leftMargin = (notifCard.height - (notifCard.height * 0.6 | 0)) / 2;
                }

                // anchors.fill: parent
                Loader {
                    id: iconLoader
                    // Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                    property bool isEmpty: {
                        let tmp = modelData.image ?? Quickshell.iconPath(modelData.appIcon);
                        return tmp ? false : true;
                    }
                    sourceComponent: isEmpty ? emptyIcon : iconImage
                    Component {
                        id: iconImage
                        IconImage {
                            Component.onCompleted: {
                                implicitSize = notifCard.height * 0.6 | 0;
                                // Layout.leftMargin = (notifCard.height - (notifCard.height * 0.6 | 0)) / 2;
                            }
                            source: modelData.image ?? Quickshell.iconPath(modelData.appIcon)
                        }
                    }

                    Component {
                        id: emptyIcon
                        SvgIcon {
                            Component.onCompleted: {
                                size = notifCard.height * 0.6 | 0;
                                // Layout.leftMargin = (notifCard.height - (notifCard.height * 0.6 | 0)) / 2;
                            }
                            sauce: Quickshell.iconPath(Quickshell.shellPath("assets/noimage.svg"))
                            fillColor: Colors.foreground
                            // Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                        }
                    }
                }
                Item {
                    implicitWidth: notifCard.width - (iconLoader.isEmpty ? iconLoader.item.size : iconLoader.item.implicitSize) - 3 * rowlayout.spacing
                    Layout.alignment: Qt.AlignTop
                    StyledText {
                        id: appName
                        font.pointSize: Fontcfg.small
                        color: Colors.darkerForeground
                        maximumLineCount: 1
                        font.styleName: "Regular"
                        anchors.top: parent.top
                        opacity: notifCard.expandY
                        text: appNameMetric.elidedText
                        Behavior on opacity {
                            Anim {}
                        }
                    }
                    TextMetrics {
                        id: appNameMetric
                        text: modelData.appName
                        font.family: appName.font.family
                        font.pointSize: appName.font.pointSize
                        elide: Text.ElideRight
                        elideWidth: (notifCard.width / 2 - rowlayout.spacing * 2 - iconLoader.item.width - sep.width)
                    }
                    StyledText {
                        id: summary
                        text: summaryMetric.elidedText
                        font.pointSize: Fontcfg.betweenSmallAndNormal
                        anchors.top: parent.top
                        maximumLineCount: 1
                        states: State {
                            name: "anchorToAppName"
                            when: notifCard.expandY
                            AnchorChanges {
                                target: summary
                                anchors.top: appName.bottom
                            }
                        }

                        transitions: Transition {
                            AnchorAnimation {
                                duration: 250
                            }
                        }
                    }
                    TextMetrics {
                        id: summaryMetric
                        text: modelData.summary
                        font.family: summary.font.family
                        font.pointSize: summary.font.pointSize
                        elide: Text.ElideRight
                        elideWidth: (notifCard.width * 0.75 - rowlayout.spacing * 2 - iconLoader.item.width - sep.width)
                    }
                    StyledText {
                        id: sep
                        text: "•"
                        font.pointSize: Fontcfg.betweenSmallAndNormal
                        anchors.left: summary.right
                        anchors.leftMargin: 6
                        color: Colors.darkerForeground
                        states: State {
                            name: "anchorToAppName"
                            when: notifCard.expandY
                            AnchorChanges {
                                target: sep
                                anchors.left: appName.right
                                anchors.verticalCenter: appName.verticalCenter
                            }
                        }
                        transitions: Transition {
                            AnchorAnimation {
                                duration: 250
                            }
                        }
                    }
                    StyledText {
                        id: body
                        text: modelData.body
                        anchors.top: summary.bottom
                        font.styleName: "Regular"
                        anchors.topMargin: 8
                        width: parent.width
                        height: root.height - rowlayout.anchors.topMargin * 2 - appName.height - summary.height
                        elide: Text.ElideRight
                        wrapMode: Text.WrapAnywhere
                    }
                }
            }
        }
    }
    component ThisSvgIcon: SvgIcon {
        property alias mouseArea: ma
        fillColor: Colors.foreground
        size: 20
        Layout.alignment: Qt.AlignHCenter
        MouseArea {
            id: ma
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }
}
