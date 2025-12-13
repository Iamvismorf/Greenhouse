// bug: when server dismisses notif it modifies server.tracked but our model is not updated. e.g dismissing by opening the app
pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import qs.config.osd

Singleton {
    id: root
    property NotificationServer notificationServer: server
    property ScriptModel trackedNotif: ScriptModel {
        values: {
            [...server.trackedNotifications.values].reverse();
        }
    }

    // property ScriptModel trackedNotif: ScriptModel {
    //     values: {
    //         [...root.notifList].reverse();
    //     }
    // }
    property list<Notification> notifList
    component Notification: QtObject {
        property int urgency
        property string body
        property string summary
        property int notificationId
        property string appIcon
        property list<NotificationAction> actions
        property string image
        property string appName
        property string desktopEntry
        property date created: new Date()
        // property Timer lifeTime: Timer {
        //     running:true
        //     interval: Notificationscfg.notificationCard.lifeTime
        //     onTriggered: {
        //        root.dismissNotif(notificationId)
        //     }
        // }
    }
    Component {
        id: notificationComp
        Notification {}
    }
    function clearAll() {
        [...server.trackedNotifications.values].forEach(e => e.dismiss());
    }
    // function dismissNotif(notifid) {
    //     let serverIdx = server.trackedNotifications.values.findIndex(n => n.id == notifid);
    //     let listIdx = root.notifList.findIndex(n => n.notificationId == notifid);
    //     server.trackedNotifications.values[serverIdx].dismiss();
    //     root.notifList.splice(listIdx, 1);
    // }
    NotificationServer {
        id: server
        bodyImagesSupported: true
        inlineReplySupported: true
        actionIconsSupported: true
        imageSupported: true
        // keepOnReload: false
        persistenceSupported: true
        bodyHyperlinksSupported: true
        actionsSupported: true
        onNotification: notif => {
            // Qt.callLater(() => {
            //     // if (trackedNotifications.values.length > Notificationscfg.notificationsContainer.maxAllowed) {
            //     // if (trackedNotifications.values.length > 2) {
            //     if (root.notifList.length > Notificationscfg.notificationsContainer.maxAllowed) {
            //         notif.dismiss();
            //         // if (root.notifList.length>2) {
            //         // root.dismissNotif(server.trackedNotifications.values[0].id);
            //         // root.dismissNotif(root.notifList[0].notificationId);
            //     }
            // });
            notif.tracked = true;
            let notifObject = notificationComp.createObject(root, {
                urgency: notif.urgency,
                body: notif.body,
                summary: notif.summary,
                notificationId: notif.id,
                appIcon: notif.appIcon,
                actions: notif.actions.map(a => ({
                            "identifier": a.identifier,
                            "text": a.text
                        })),
                image: notif.image,
                appName: notif.appName,
                desktopEntry: notif.desktopEntry
            });
            root.notifList.push(notifObject);
        // root.notifList = [...root.notifList, notifObject];
        // notif.actions.forEach(a => console.log(`text: ${a.text}`, `identifier: ${a.identifier}`));
        // console.log(notif.actions.length);
        }
    }
}
