import QtQuick
import qs.custom
import qs.services
import qs.config

StyledText {
    id: layout
    font.pointSize: Fontcfg.small
    text: {
        let layout = Landhypr.kbLayout.slice(0, 2);
        if (layout.toLowerCase() == "ge")
            return "De";

        if (layout.toLowerCase() == "en")
            return "Eng";
        else
            return layout;
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            Landhypr.dispatch(`exec hyprctl switchxkblayout ${Landhypr.kbName} next`);
        }
    }
}
