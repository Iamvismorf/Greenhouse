//todo: fix plsShow and when length == 0
import QtQuick
import qs.services
import qs.config.osd

Loader {
    id: loader
    property bool plsShow: true
    active: true
    visible: active
    Connections {
        target: NotificationManager.trackedNotif
        function onValuesChanged() {
            if (NotificationManager.trackedNotif.values.length == 0 && loader.item.count == 0) {
                loader.plsShow = false;
                return;
            }
            loader.plsShow = true;
        }
    }
    sourceComponent: ListView {
        id: list
        model: NotificationManager.trackedNotif
        implicitWidth: Notificationscfg.notificationsContainer.width
        implicitHeight: {
            let count = list.count;
            if (!count) {
                return 0;
            }
            let height = (count - 1) * Notificationscfg.notificationsContainer.spacing;
            for (let i = 0; i < count; i++) {
                height += list.itemAtIndex(i)?.height ?? 0;
            }
            return height;
        }
        spacing: Notificationscfg.notificationsContainer.spacing
        cacheBuffer: 0
        keyNavigationEnabled: false
        interactive: false
        delegate: NotificationItem {}
        add: Transition {
            NumberAnimation {
                property: "x"
                easing.bezierCurve: [0.34, 0.8, 0.34, 1, 1, 1]
                // from: 1000
                from: Notificationscfg.notificationsContainer.width
                duration: 800
            }
        }
        displaced: Transition {
            NumberAnimation {
                property: "y"
                duration: 800
                easing.type: Easing.BezierSpline
                easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
            }
        }
        remove: Transition {
            NumberAnimation {
                property: "x"
                duration: 1000
                to: Notificationscfg.notificationsContainer.width
                // to: 1000
                easing.bezierCurve: [0.34, 0.8, 0.34, 1, 1, 1]
            }
        }
        // move: Transition {
        //     NumberAnimation {
        //         property: "y"
        //         duration: 4000
        //         easing.type: Easing.BezierSpline
        //         easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
        //     }
        // }
    }
    // sourceComponent: NotificationItem {}
}
