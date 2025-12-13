pragma Singleton
import Quickshell
import qs.services
import QtQuick

Singleton {
    readonly property ClipboardEntry clipboardEntry: ClipboardEntry {}
    readonly property Clipboard clipboard: Clipboard {
        id: clipboardih
    }
    component Clipboard: QtObject {
        readonly property int width: 320
        readonly property int height: 512
        readonly property int padding: 20
        readonly property color background: Colors.background
    }
    component ClipboardEntry: QtObject {
        readonly property int width: clipboardih.width
        readonly property int maxHeight: 140
        readonly property color background: Colors.lighterBackground
    }
}
