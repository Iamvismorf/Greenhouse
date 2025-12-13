import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config.osd
import qs.services
import qs.custom
import qs.config

OsdLoader {
    id: loader
    property real volume: Audio.defaultSink?.audio?.volume ?? 0
    Behavior on volume {
        NumberAnimation {
            duration: Osdcfg.volumeAnimation
        }
    }
    Connections {
        target: Landhypr
        function onKbLayoutChanged() {
            if (!Landhypr.kbReady || loader.status != Loader.Ready) {
                return;
            }
            impendingDoom();
        }
    }
    Connections {
        target: Audio.defaultSink?.audio ?? null
        function onVolumeChanged() {
            if (loader.volume === null || loader.volume == undefined || isNaN(loader.volume)) {
                loader.plsShow = false;
                return;
            }

            restartTimer();
        }
    }
    sourceComponent: OsdItemGeneric {
        id: root
        loader: parent
        RowLayout {
            spacing: 8
            anchors.centerIn: parent
            SvgIcon {
                sauce: {
                    let vol = (loader.volume * 100 | 0);
                    if (vol <= 5)
                        return Quickshell.iconPath(Quickshell.shellPath("assets/volumeVeryLow.svg"));
                    else if (vol > 5 && vol <= 25)
                        return Quickshell.iconPath(Quickshell.shellPath("assets/volumeLow.svg"));
                    else if (vol > 25 && vol <= 50)
                        return Quickshell.iconPath(Quickshell.shellPath("assets/volumeNormal.svg"));
                    else if (vol > 50)
                        return Quickshell.iconPath(Quickshell.shellPath("assets/volumeHigh.svg"));
                }
                fillColor: Colors.foreground
            }
            ColumnLayout {
                StyledText {
                    Layout.alignment: Qt.AlignHCenter
                    // text: `volume ${Audio.defaultSink?.audio?.volume * 100 | 0}`
                    text: `volume ${loader.volume * 100 | 0}`
                    font.features: {
                        "tnum": 1
                    }
                }
                Rectangle {
                    radius: 8
                    implicitHeight: 4
                    implicitWidth: (loader.volume * 100 | 0)
                    color: Colors.accent
                }
            }
        }
    }
}
