import Quickshell
import QtQuick
import Quickshell.Wayland
import qs.modules.desktop.effect
import qs.services
import Quickshell

Variants {
    model: Quickshell.screens
    Scope {
        required property var modelData
        PanelWindow {
            id: notParent
            MouseArea {
                id: mouse
                anchors.fill: parent
                onClicked: m => {
                    let comp = Qt.createComponent("effect/ClickEffect.qml");
                    if (comp.status === Component.Ready) {
                        let tempRec = comp.createObject(notParent.contentItem, {
                            theColor: Color.background
                        });
                        tempRec.x = m.x - tempRec.width / 2; // Center horizontally
                        tempRec.y = m.y - tempRec.height;
                    }
                // let tempRec = recCompo.createObject(notParent.contentItem);
                }
            }
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Bottom
            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }
        }
    }
}
