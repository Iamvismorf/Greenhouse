import QtQuick
import Quickshell
import qs.services
import qs.custom
import QtQuick.Layouts
import QtQuick.Effects
import qs.config.utilWidgets
import Quickshell.Widgets
import qs.modules.desktop.utilWidgets.clipboard

//slow???

// draghandler to manager only reactangle. that means remove wrapper mousearea and replace with mousearea

WrapperMouseArea {
    id: wrap
    property string keyBuffer: ""
    Timer {
        id: keyBufferTimer
        interval: 250
        onTriggered: wrap.keyBuffer = ""
    }
    Keys.onPressed: e => {
        wrap.keyBuffer += e.text;
        keyBufferTimer.restart();
        if (ldr.sourceComponent == listview) {
            if (wrap.keyBuffer == "gi") {
                searchBar.forceActiveFocus();
                wrap.keyBuffer = "";
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
                wrap.forceActiveFocus();
                e.accepted = true;
            } else if (e.key === Qt.Key_Escape && !searchBar.focus) {
                wrap.parent.active = false;
                e.accepted = true;
            }
        }
    }
    hoverEnabled: true
    StyledRectangle {
        id: root
        // MouseArea {
        //     anchors.fill: parent
        //     hoverEnabled: true
        // }

        // target: root
        // cursorShape: Qt.DragMoveCursor
        DragHandler {
            target: wrap
        }
        // MouseArea {
        //    anchors.fill: parent
        //    drag.target: parent
        //    drag.axis: Drag.XAndYAxis
        // }
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
                // NerdFontText {
                //     text: "󰃢"
                //     font.pointSize: 20
                //     MouseArea {
                //         anchors.fill: parent
                //         cursorShape: Qt.PointingHandCursor
                //         onClicked: CliphistService.wipe()
                //     }
                // }
            }
            Loader {
                id: ldr
                Layout.fillWidth: true
                Layout.fillHeight: true
                sourceComponent: CliphistService.cliphistModel.values.length > 0 ? listview : emptySvg
            }
            Component {
                id: listview
                StyledListView {
                    id: list
                    keyNavigationEnabled: true
                    highlightMoveDuration: 0
                    highlightResizeDuration: 0
                    highlight: StyledRectangle {
                        rounded: true
                        border.width: 2
                        border.color: Colors.accent
                        color: "transparent"
                        z: 100
                    }
                    clip: true
                    model: CliphistService.cliphistModel
                    delegate: DelegateChooser {
                        role: "type"
                        DelegateChoice {
                            roleValue: "image/png"
                            ImageDelegate {
                                implicitHeight: Math.min(img.implicitHeight, Clipboardcfg.clipboardEntry.maxHeight)
                                MouseArea {
                                    anchors.fill: parent
                                    preventStealing: true
                                    propagateComposedEvents: true
                                    onClicked:
                                    // CliphistService.selectById(modelData.eyeDih);
                                    {
                                        list.currentIndex = index;
                                    }
                                }
                                Image {
                                    id: img
                                    source: "data:image/png;base64," + modelData.data
                                    scale: Math.min((Clipboardcfg.clipboardEntry.width - 32) / modelData.dimensions.width, (Clipboardcfg.clipboardEntry.maxHeight - 32) / modelData.dimensions.height, 1)
                                    transformOrigin: Item.TopLeft
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.topMargin: 16
                                    anchors.leftMargin: 16

                                    mipmap: true
                                    asynchronous: true
                                }
                            }
                        }
                        DelegateChoice {
                            TextDelegate {
                                implicitHeight: Math.min(tex.height + tex.anchors.margins, Clipboardcfg.clipboardEntry.maxHeight)
                                MouseArea {
                                    anchors.fill: parent
                                    preventStealing: true
                                    propagateComposedEvents: true
                                    onClicked:
                                    // CliphistService.selectById(modelData.eyeDih);
                                    {
                                        list.currentIndex = index;
                                    }
                                }
                                StyledText {
                                    id: tex
                                    text: modelData.data
                                    wrapMode: Text.WrapAnywhere
                                    clip: true
                                    anchors.fill: parent
                                    anchors.margins: 16
                                    height: Math.min(implicitHeight + anchors.margins * 2, Clipboardcfg.clipboardEntry.maxHeight)
                                }
                            }
                        }
                    }
                }
            }
            Component {
                id: emptySvg
                IconImage {
                    source: Quickshell.iconPath(Quickshell.shellPath("assets/empty.svg"))
                    MultiEffect {
                        source: parent
                        anchors.fill: parent
                        brightness: 1
                        colorization: 1
                        colorizationColor: Colors.lighterBackground
                    }
                }
            }
        }
    }
}
