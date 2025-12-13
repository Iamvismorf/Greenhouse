import QtQuick
import Quickshell
import qs.services

Item {
    id: root
    component ThisAnim: SequentialAnimation {
        id: thisanim
        property int animDuration: 150
        property var animTarget
        property string animProperty
        running: true
        NumberAnimation {
            target: thisanim.animTarget
            property: thisanim.animProperty
            to: 4
            duration: thisanim.animDuration
        }
        ParallelAnimation {
            NumberAnimation {
                target: thisanim.animTarget
                property: thisanim.animProperty
                to: 8
                duration: thisanim.animDuration
            }
            NumberAnimation {
                target: thisanim.animTarget
                property: "scale"
                to: 0.5
                duration: thisanim.animDuration
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: thisanim.animTarget
                property: thisanim.animProperty
                to: 12
                duration: thisanim.animDuration
            }
            NumberAnimation {
                target: thisanim.animTarget
                property: "scale"
                to: 0
                duration: thisanim.animDuration
            }
        }
        onFinished: {
            thisanim.animTarget.destroy();
        }
    }
    component ThisRectangle: Rectangle {
        color: Colors.foreground
    }
    component PartialEffect: Item {
        id: effect
        property real wid: 4
        property real hei: 8
        ThisRectangle {
            id: top
            width: effect.wid
            height: effect.hei
            anchors.bottom: center.top
            anchors.horizontalCenter: center.horizontalCenter
            transformOrigin: Item.Top
            ThisAnim {
                animTarget: top
                animProperty: "anchors.bottomMargin"
            }
        }
        Rectangle {
            id: center
            width: 20
            height: 20
            color: "transparent"
            anchors.centerIn: parent
        }
        ThisRectangle {
            id: left
            transformOrigin: Item.Left
            width: effect.hei
            height: effect.wid
            anchors.right: center.left
            anchors.verticalCenter: center.verticalCenter
            ThisAnim {
                animTarget: left
                animProperty: "anchors.rightMargin"
            }
        }
    }

    PartialEffect {
        id: vert
    }
    PartialEffect {
        id: fourtyFive
        rotation: 45
    }
}
