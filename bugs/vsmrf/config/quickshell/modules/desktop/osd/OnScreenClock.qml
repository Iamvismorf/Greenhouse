//todo: color quantize + random from todo
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.custom

Item {
    id: root
    implicitWidth: col.implicitWidth
    implicitHeight: col.implicitHeight
    ColumnLayout {
        id: col
        spacing: -(time.font.pointSize - date.font.pointSize) / 1.5
        StyledText {
            id: time
            text: Time.format("hh:mm")
            color: Colors.foreground
            font.pointSize: 56
        }
        StyledText {
            id: date
            text: Time.format("dddd, dd MMM")
            font.pointSize: 24
        }
    }
}
