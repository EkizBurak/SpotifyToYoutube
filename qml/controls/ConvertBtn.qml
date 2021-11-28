import QtQuick 2.0
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    width: 75
    height: 25
    id: button
    property color colorDefault: "#1db954"
    property color colorMouseOver: "#ed2939"
    property color colorPressed: "#c21807"

    QtObject
    {
        id: internal

        property var dynamicColor: if(button.down){
                                       button.down ? colorPressed : colorDefault
                                   }else{
                                       button.hovered ? colorMouseOver : colorDefault
                                   }
    }
    background: Rectangle
    {
        color: internal.dynamicColor
        radius: 5
    }
    contentItem: Item{
        Text {
            id: name
            text: button.text
            font: button.font
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}


