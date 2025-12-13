pragma Singleton
import Quickshell
import qs.services
import QtQuick

Singleton {
    readonly property NotificationCard notificationCard: NotificationCard {
        id: notifCard
    }
    readonly property NotificationsContainer notificationsContainer: NotificationsContainer {
        id: notifContainer
    }
    readonly property NotificationCardPopout notificationCardPopup: NotificationCardPopout {
        id: notifCardPopup
    }
    component NotificationsContainer: QtObject {
        readonly property int margin: 24
        readonly property int spacing: 12
        readonly property int maxAllowed: 5
        // readonly property real width: notifCard.width + notifCardPopup.width
        readonly property real width: 400
    }
    component NotificationCard: QtObject {
        readonly property real height: 68
        // readonly property real width: 356
        readonly property real width: 400
        readonly property real padding: 8
        readonly property int innerRadius: 8
        readonly property int outerRadius: padding + innerRadius
        readonly property color background: Colors.background
        readonly property int lifeTime: 4000
    }
    component NotificationCardPopout: QtObject {
        readonly property real width: 44
        readonly property color background: Colors.accent
        readonly property int outerRadius: notifCard.outerRadius
    }
}
