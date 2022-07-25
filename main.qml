import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Qt6 Calendar")


    property date tpmDate: new Date()

    Button{
        id:button
        text: Qt.formatDateTime(tpmDate,"ddd yyyy-MM-dd") //hh:mm:ss
        anchors.centerIn: parent
        onClicked: dialogCalendar.show(tpmDate)
    }

    Dialog {
        id: dialogCalendar
        implicitWidth: 320
        implicitHeight: 350
        padding: 0
        anchors.centerIn: parent

        MyCalendar {
            id: control
            selectDate: tpmDate
        }

        Rectangle {
            id: dividerHorizontal
            color: "orange"
            height: 2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: control.bottom
        }

        Row {
            id: row
            height: 50
            anchors.top: dividerHorizontal.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            Button {
                id: dialogButtonCancel
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                checkable: false
                width: parent.width / 2 - 1
                text: "Cancel"
                hoverEnabled: false
                background: Rectangle {
                    color: dialogButtonCancel.pressed ? "tomato" : "red"
                    border.width: 0
                }
                onClicked:{
                    dialogCalendar.close()
                }
            }

            Rectangle {
                id: dividerVertical
                width: 2
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                color: "#d7d7d7"

            }

            Button {
                id: dialogButtonOk
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width / 2 - 1
                hoverEnabled: false
                text: "Ok"
                background: Rectangle {
                    color: dialogButtonOk.pressed ? "#00a03e" : "#8bc24c"
                    border.width: 0
                }
                onClicked:{
                    button.text = Qt.formatDateTime(control.selectDate, "ddd yyyy-MM-dd"); //hh:mm:ss
                    console.log('click dialog', control.selectDate)
                    dialogCalendar.close()
                }
            }
        }

        function show(tpmDate){
            control.selectDate = tpmDate;
            dialogCalendar.open()
        }
    }
}
