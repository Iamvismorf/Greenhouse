import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config.osd
import Quickshell
import qs.custom
import qs.config
import qs.assets.qml as Ass

OsdLoader {
    id: loader
    Connections {
        target: Audio.defaultSink?.audio ?? null
        function onVolumeChanged() {
            if (loader.status == Loader.Ready) {
                impendingDoom();
            }
        }
    }
    Connections {
        target: Landhypr
        function onKbLayoutChanged() {
            if (!Landhypr.kbReady) {
                plsShow = false;
                return;
            }
            restartTimer();
        }
    }

    sourceComponent: OsdItemGeneric {
        id: root
        loader: parent
        RowLayout {
            id: rowlayout
            anchors.centerIn: parent
            property Item current: one
            property string keyboard: Landhypr.kbLayout

            SvgIcon {
                sauce: Quickshell.iconPath(Quickshell.shellPath("assets/keyboard.svg"))
                fillColor: Colors.foreground
            }
            onKeyboardChanged: {
                const next = rowlayout.current === one ? two : one;
                next.text = Landhypr.kbLayout;
                rowlayout.current = next;
            }
            KeyText {
                id: one
                opacity: rowlayout.current == this ? 1 : 0
                visible: rowlayout.current == this ? 1 : 0
            }
            KeyText {
                id: two
                opacity: rowlayout.current == this ? 1 : 0
                visible: rowlayout.current == this ? 1 : 0
            }
        }
    }
    component KeyText: StyledText {
        text: Landhypr.kbLayout
        Behavior on opacity {
            NumberAnimation {
                duration: Osdcfg.textAnimation
            }
        }
    }
}
