// todo: onhover tooltip that shows used/total
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import Quickshell
import qs.custom

CircularProgressIndicator {
    id: root
    value: SystemInfo.utilizedRam
    iconSauce: Quickshell.iconPath(Quickshell.shellPath("assets/ram.svg"))
}

// ToolTip {
//     id: tooltip
//     visible: true
//     background: StyledRectangle {
//         implicitWidth: tooltip.contentItem.implicitWidth
//         rounded: true
//         color: Colors.lighterBackground
//     }
//     x: parent.width + parent.uh * 2
//     y: (parent.height - height) / 2
//     padding: 12
//     // topPadding: 12
//     // bottomPadding: 12
//     contentItem: RowLayout {
//         spacing: 8
//         ThisStyledText {
//             text: "RAM:"
//         }
//         ThisStyledText {
//             text: {
//                 let used = (SystemInfo.usedRAM / 1048576).toFixed(2).substring(0, 4);
//                 return `${used} GiB / ${(SystemInfo.totalRAM / 1048576).toFixed(1)} GiB`;
//             }
//         }
//         Rectangle {
//             width: 2
//             Layout.fillHeight: true
//             color: Colors.accent
//         }
//         ThisStyledText {
//             text: `${(SystemInfo.utilizedRam * 100 | 0)}%`
//         }
//     }
// }

