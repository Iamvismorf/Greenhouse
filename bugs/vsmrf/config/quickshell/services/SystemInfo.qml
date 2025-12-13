pragma Singleton
import Quickshell.Io
import Quickshell
import QtQuick

import Vixhardware

Singleton {
    id: root
    property var totalRAM: Ram.total
    property var usedRAM: Ram.used
    property var utilizedRam: Ram.utilized

    // Timer {
    //     running: true
    //     repeat: true
    //     interval: 1
    //     onTriggered: {
    //         interval = 1000;
    //         ramInfoProc.running = true;
    //     }
    // }
    // Process {
    //     id: ramInfoProc
    //     running: false
    //     command: ["bash", "-c", `free | awk '/^Mem:/ {print $2, $3}'`]
    //
    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             let tmp = text.split(" ").map(Number);
    //             // console.log(text);
    //             root.totalRAM = tmp[0];
    //             root.usedRAM = tmp[1];
    //         }
    //     }
    // }
}
