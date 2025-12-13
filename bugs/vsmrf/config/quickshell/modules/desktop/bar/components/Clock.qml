import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import qs.services
import qs.custom

Item {
    implicitHeight: root.implicitHeight
    ColumnLayout {
        id: root
        spacing: 8
        anchors.horizontalCenter: parent.horizontalCenter
        ColumnLayout {
            // Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 4
            ClockText {
                text: Time.format("hh")
            }
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 6
                Dot {}
                Dot {}
            }
            ClockText {
                text: Time.format("mm")
            }
        }
        Rectangle {
            width: 2
            height: 28
            color: Colors.darkerForeground
            Layout.alignment: Qt.AlignHCenter
        }
        ClockText {
            font.pointSize: 10
            text: Time.format("ddd\ndd, MMM")
        }
        Rectangle {
            width: 12
            height: 12
            color: "transparent"
            border.width: 2
            border.color: Colors.darkerForeground
            Layout.alignment: Qt.AlignHCenter
        }
    }
    component ClockText: StyledText {
        font.pointSize: 16
        Layout.alignment: Qt.AlignHCenter
        horizontalAlignment: Text.AlignHCenter
        font.features: {
            "tnum": 1
        }
    }
    component Dot: Rectangle {
        width: 4
        height: 4
        color: Colors.foreground
        radius: 100
    }
}
