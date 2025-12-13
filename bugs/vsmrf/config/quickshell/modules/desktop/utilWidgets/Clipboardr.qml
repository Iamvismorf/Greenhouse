import QtQuick
import Quickshell
import qs.services
import qs.custom
import QtQuick.Layouts
import QtQuick.Effects
import qs.config.utilWidgets
import Quickshell.Widgets
import qs.modules.desktop.utilWidgets.clipboard

// draghandler to manager only reactangle. that means remove wrapper mousearea and replace with mousearea

StyledRectangle {
    id: root
    property string keyBuffer: ""
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
    }
    Timer {
        id: keyBufferTimer
        interval: 250
        onTriggered: root.keyBuffer = ""
    }
    Keys.onPressed: e => {
        root.keyBuffer += e.text;
        keyBufferTimer.restart();
        if (ldr.sourceComponent == listview) {
            if (root.keyBuffer == "gi") {
                searchBar.forceActiveFocus();
                root.keyBuffer = "";
                keyBufferTimer.stop();
                e.accepted = true;
            }
            if (e.key === Qt.Key_J) {
                ldr.item.incrementCurrentIndex();
                e.accepted = true;
            } else if (e.key === Qt.Key_K) {
                ldr.item.decrementCurrentIndex();
                e.accepted = true;
            } else if (e.key === Qt.Key_Escape && searchBar.focus) {
                searchBar.focus = false;
                root.forceActiveFocus();
                e.accepted = true;
            } else if (e.key === Qt.Key_Escape && !searchBar.focus) {
                root.parent.active = false;
                e.accepted = true;
            }
        }
    }
    DragHandler {
    }
    focus: true

    rounded: true
    implicitWidth: Clipboardcfg.clipboard.width + 2 * Clipboardcfg.clipboard.padding
    implicitHeight: Clipboardcfg.clipboard.height + 2 * Clipboardcfg.clipboard.padding
    color: Clipboardcfg.clipboard.background
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Clipboardcfg.clipboard.padding
        spacing: 20
        RowLayout {
            SvgIcon {
                sauce: Quickshell.iconPath(Quickshell.shellPath("assets/clip.svg"))
                fillColor: Colors.foreground
            }
            StyledText {
                text: "bord"
                font.pointSize: 20
                Layout.fillWidth: true
            }
            StyledText {
                color: Colors.darkerForeground
                font.pointSize: 10
                text: {
                    if (!CliphistService.cliphistModel.values.length) {
                        return "uhh";
                    } else if (CliphistService.cliphistModel.values.length > 99) {
                        return "99+ items";
                    } else {
                        return `${CliphistService.cliphistModel.values.length} items`;
                    }
                }
            }
        }
        RowLayout {
            spacing: 20
            Layout.fillWidth: true
            StyledTextField {
                id: searchBar
                enabled: CliphistService.cliphistModel.values.length > 0
                Layout.fillWidth: true
                implicitHeight: 36
                padding: 8
                leftPadding: 12 + searchIcon.width + searchIcon.x
                rightPadding: 12
                placeholderText: "Fuzzy search"
                Component {
                    id: curosr
                    Rectangle {
                        width: 0
                        height: 0
                        color: "transparent"
                    }
                }
                cursorDelegate: enabled ? null : curosr
                background: StyledRectangle {
                    id: textBg
                    rounded: true
                    color: Colors.lighterBackground
                }
                SvgIcon {
                    id: searchIcon
                    sauce: Quickshell.iconPath(Quickshell.shellPath("assets/search.svg"))
                    fillColor: Colors.foreground
                    size: 20
                    anchors.verticalCenter: textBg.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                }
                onTextEdited: {
                    if (text == "") {
                        CliphistService.refetch();
                    } else {
                        CliphistService.cliphistModel.values = Fuzzy.go(text, CliphistService.cliphistModel.values.filter(i => i.type != "image/png"), {
                            key: "data",
                            all: true
                        }).map(r => r.obj);
                    }
                }
            }
        }
        Loader {
            id: ldr
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: listview
        }
        Component {
            id: listview
            StyledListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
                id: list
                keyNavigationEnabled: true
                highlightMoveDuration: 0
                highlightResizeDuration: 0

                clip: true
                model: CliphistService.cliphistModel
                delegate: Rectangle{
                   implicitWidth:320
                   implicitHeight: 100

                   
                }
            }
        }
    }
}
