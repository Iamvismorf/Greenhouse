import QtQuick.Layouts
import QtQuick

//easing.bezierCurve: [0.26, 0.39, 0.32, 1.58, 1, 1]

// Item {
//     implicitWidth: col.implicitWidth
//     implicitHeight: col.implicitHeight
ColumnLayout {
    id: col
    //ok buddy
    // anchors.centerIn: parent
    spacing: 12
    Cpu {
        readonly property string name: "cpu"
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
    }
    // Gpu {
    //     id: gpu
    //     readonly property string name: "gpu"
    //     Layout.alignment: Qt.AlignHCenter
    //     Layout.fillWidth: true
    // }
    Ram {
        id: ram
        readonly property string name: "ram"
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
    }
}
// }
