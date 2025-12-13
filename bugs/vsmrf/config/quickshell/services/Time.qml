pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property alias aClock: clock
    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
