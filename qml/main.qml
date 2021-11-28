import QtQuick 2.15
import QtQuick.Controls 2.15
import "controls"
import QtQuick.Layouts 1.0
import QtQuick.Dialogs.qml 1.0
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15
import Qt.labs.animation 1.0
import Qt.labs.platform 1.0
import QtQuick.Dialogs 1.2
Window {
    id:window
    width: 640
    height: 480
    visible: true
    color: "#00000000"
    title: "Burak Ekiz"
    flags: Qt.Window | Qt.FramelessWindowHint
    minimumWidth: 550
    minimumHeight: 380

    Rectangle {
            id: rectangle
            color: "#212121"
            anchors.fill: parent
            anchors.rightMargin: internal.windowMargin
            anchors.leftMargin: internal.windowMargin
            anchors.bottomMargin: internal.windowMargin
            anchors.topMargin: internal.windowMargin

            Rectangle {
                id: spotifyRectangle
                height: 50
                color: "#1db954"
                radius: 12
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 150
                anchors.rightMargin: 50
                anchors.leftMargin: 50

            }

            TextField {
                id: spotifyTextbox
                height: 40
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                horizontalAlignment: Text.AlignLeft
                anchors.rightMargin: 55
                anchors.leftMargin: 55
                anchors.topMargin: 155
                leftPadding: 10
                font.hintingPreference: Font.PreferDefaultHinting
                topPadding: 10
                hoverEnabled: true
                topInset: 0
                rightPadding: 0
                bottomPadding: 10
                font.weight: Font.Normal
                background: Rectangle {
                    radius: 12
                }
                placeholderText: qsTr("Spotify Playlist URL")
                font.pointSize: 12
            }

            Rectangle {
                id: youtubeRectangle
                height: 50
                color: "#ed2939"
                radius: 12
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 50
                anchors.topMargin: 215
                anchors.leftMargin: 50
            }

            TextField {
                id: youtubeTextbox
                height: 40
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                horizontalAlignment: Text.AlignLeft
                bottomPadding: 10
                topPadding: 10
                placeholderText: qsTr("Youtube Collaborate Playlist URL")
                rightPadding: 0
                font.weight: Font.Normal
                anchors.leftMargin: 55
                anchors.rightMargin: 55
                topInset: 0
                leftPadding: 10
                hoverEnabled: true
                anchors.topMargin: 220
                font.hintingPreference: Font.PreferDefaultHinting
                font.pointSize: 12
                background: Rectangle {
                    radius: 12
                }
            }

            TopBarBtn {
                id: topBarBtn
                x: 570
                y: 10
                width: 30
                height: 30
                anchors.right: parent.right
                anchors.top: parent.top
                btnColorClicked: "#ed2939"
                btnColorDefault: "#00000000"
                anchors.topMargin: 0
                anchors.rightMargin: 30
                btnIconSource: "../images/svg_images/maximize_icon.svg"
                onClicked: internal.maximizeRestore()
            }

            TopBarBtn {
                x: 540
                y: 10
                width: 30
                height: 30
                visible: true
                anchors.right: parent.right
                anchors.top: parent.top
                btnColorDefault: "#00000000"
                clip: false
                btnColorClicked: "#ed2939"
                anchors.rightMargin: 60
                anchors.topMargin: 0
                btnIconSource: "../images/svg_images/minimize_icon.svg"
                onClicked: window.showMinimized()
            }

            TopBarBtn {
                x: 600
                y: 10
                width: 30
                height: 30
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0
                btnColorClicked: "#ed2939"
                btnColorDefault: "#00000000"
                btnIconSource: "../images/svg_images/close_icon.svg"
                onClicked: window.hide()
            }

            Image {
                id: logo
                x: 0
                y: -25
                width: 621
                height: 251
                source: "../images/logo.png"
                anchors.horizontalCenterOffset: 1
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
            CheckBox {
                id: checkBox
                width: 44
                height: 29
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 50
                anchors.topMargin: 278
            }
            ConvertBtn
            {
                x: 495
                width: 80
                height: 30
                text: "Convert"
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 277
                anchors.rightMargin: 50
                onPressed: backend.convert(checkBox.checked, spotifyTextbox.text, youtubeTextbox.text)
            }



            Label {
                id: checkBoxText
                width: 389
                height: 18
                text: qsTr("I allow my spotify and youtube playlists to be accessed")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 286
                anchors.leftMargin: 100
                color:"white"
            }
        }
    Rectangle {
        id: footer
        height: 20
                        color: "#303030"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10

                        Label {
                            id: footerText
                            color: "#dadfe4"
                            text: qsTr("Spotify To Youtube - ⓒ CopyRight 2021 Burak Ekiz - Mertcan Berk Aksoy")
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            font.pixelSize: 10
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Verdana"
                            anchors.topMargin: 0
                            anchors.leftMargin: 5
                            anchors.rightMargin: 30
                            anchors.bottomMargin: 0
                        }
                }
    DragHandler{
            onActiveChanged: if(active){
                                 window.startSystemMove()
                             }
        }
        QtObject
        {
            property int windowStatus: 0
            property int windowMargin: 10
            id:internal
            function maximizeRestore()
            {
                if(windowStatus==0)
                {
                    window.showMaximized()
                    windowStatus=1
                    windowMargin=0

                    resizeLeft.visible = false
                    resizeRight.visible = false
                    resizeTop.visible = false
                    resizeBottom.visible = false
                    resizeRightBottom.visible = false
                    footer.anchors.bottomMargin = 0
                    footer.anchors.rightMargin = 0
                    footer.anchors.leftMargin = 0
                }
                else
                {
                    window.showNormal()
                    windowStatus=0
                    windowMargin=10
                    resizeLeft.visible = true
                    resizeRight.visible = true
                    resizeTop.visible = true
                    resizeBottom.visible = true
                    resizeRightBottom.visible = true
                    footer.anchors.bottomMargin = 10
                    footer.anchors.rightMargin = 10
                    footer.anchors.leftMargin = 10
                }
            }
        }
        MouseArea {
            id: resizeLeft
            width: 10
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            cursorShape: Qt.SizeHorCursor
            DragHandler
            {
                target: null
                onActiveChanged: if(active){window.startSystemResize(Qt.LeftEdge)}
            }
        }

        MouseArea {
            id: resizeRight
            x: 790
            width: 10
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.bottomMargin: 10
            cursorShape: Qt.SizeHorCursor
            anchors.topMargin: 10
            DragHandler {
                target: null
                onActiveChanged: if(active){window.startSystemResize(Qt.RightEdge)}
            }
        }

        MouseArea {
            id: resizeBottom
            y: 590
            width: 780
            height: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 0
            anchors.leftMargin: 10
            cursorShape: Qt.SizeVerCursor
            DragHandler {
                target: null
                onActiveChanged: if(active){window.startSystemResize(Qt.BottomEdge)}
            }
        }


        MouseArea {
            id: resizeTop
            height: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            cursorShape: Qt.SizeVerCursor
            DragHandler {
                target: null
                onActiveChanged: if(active){window.startSystemResize(Qt.TopEdge)}
            }
        }


        MouseArea {
            id: resizeRightBottom
            x: 774
            y: 573
            width: 25
            height: 25
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            cursorShape: Qt.SizeFDiagCursor
            DragHandler {
                target: null
                onActiveChanged: if(active){window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)}
            }

            Image {
                id: image1
                x: 0
                y: 0
                width: 25
                height: 25
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                source: "../images/svg_images/resize_icon.svg"
                clip: false
                anchors.bottomMargin: 10
                anchors.rightMargin: 10
                fillMode: Image.PreserveAspectFit
            }
        }
        MessageDialog
        {
                id:messageDialog
                title: "Error"
                icon:  StandardIcon.Critical
                text: ""
        }
        Connections
        {
               target: backend
               function onGetError(string)
               {
                   messageDialog.text=string
                   if (messageDialog.text=="")
                   {

                   }
                   else
                   {
                       messageDialog.visible=true
                   }
               }
        }


}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:14}D{i:1}
}
##^##*/
