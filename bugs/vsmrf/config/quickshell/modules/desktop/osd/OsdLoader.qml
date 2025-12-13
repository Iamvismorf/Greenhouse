import QtQuick
import qs.config.osd
import qs.services

Loader {
    id: loader
    property bool plsShow: false
    property alias timer: timer
    property alias destroyer: destroyer
    active: plsShow
    visible: active
    function impendingDoom() {
        timer.stop();
        loader.item.opacity = 0;
        destroyer.start();
    }
    function restartTimer() {
        plsShow = true;
        loader.item.opacity = 1;
        if (destroyer.running) {
            destroyer.restart();
            destroyer.stop();
        }
        timer.restart();
    }
    Timer {
        id: timer
        interval: Osdcfg.lifeTime
        onTriggered: {
            impendingDoom();
            // plsShow = false;
        }
    }
    Timer {
        id: destroyer
        interval: Osdcfg.bornNDieDuration + 50
        onTriggered: plsShow = false
    }
}
