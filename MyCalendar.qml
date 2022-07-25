import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: control
    implicitWidth: 320
    implicitHeight: 350
    color: "#f7f7f7"
    border.color: "black"

    property alias font: month_grid.font
    property alias locale: month_grid.locale
    property date selectDate: tpmDate

    component CalendarButton : AbstractButton {
        id: c_btn
        implicitWidth: 30
        implicitHeight: 30
        contentItem: Text {
            font: control.font
            text: c_btn.text
            color: "red"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        background: Item{}
    }

    GridLayout {
        anchors.fill: parent
        anchors.margins: 2
        columns: 2
        rows: 3
        columnSpacing: 1
        rowSpacing: 1

        Rectangle {
            implicitWidth: 30
            implicitHeight: 40
            color: "gray"
        }

        Rectangle {
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
            implicitHeight: 40
            color: "gray"
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                CalendarButton {
                    text: "<"
                    onClicked: {
                        month_grid.year-=1;
                    }
                }
                Text {
                    font: control.font
                    color: "white"
                    text: month_grid.year
                }
                CalendarButton {
                    text: ">"
                    onClicked: {
                        month_grid.year+=1;
                    }
                }
                Item {
                    implicitWidth: 20
                }
                CalendarButton {
                    text: "<"
                    onClicked: {
                        if(month_grid.month === 0){
                            month_grid.year -= 1;
                            month_grid.month = 11;
                        }else{
                            month_grid.month -= 1;
                        }
                    }
                }
                Text {
                    font: control.font
                    color: "white"
                    text: month_grid.month+1
                }
                CalendarButton {
                    text: ">"
                    onClicked: {
                        if(month_grid.month === 11){
                            month_grid.year +=1;
                            month_grid.month = 0;
                        }else{
                            month_grid.month +=1;
                        }
                    }
                }
            }
        }

        Rectangle {
            implicitWidth: 30
            implicitHeight: 40
            color: "gray"
        }

        DayOfWeekRow {
            id: week_row
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            implicitHeight: 40
            spacing: 1
            topPadding: 0
            bottomPadding: 0
            font: control.font
            locale: control.locale
            delegate: Text {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: shortName
                font: week_row.font
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                required property string shortName
            }
            contentItem: Rectangle {
                color: "gray"
                border.color: "black"
                RowLayout {
                    anchors.fill: parent
                    spacing: week_row.spacing
                    Repeater {
                        model: week_row.source
                        delegate: week_row.delegate
                    }
                }
            }
        }

        WeekNumberColumn {
            id: week_col
            Layout.row: 2
            Layout.fillHeight: true
            implicitWidth: 30
            spacing: 1
            leftPadding: 0
            rightPadding: 0
            font: control.font
            month: month_grid.month
            year: month_grid.year
            locale: control.locale
            delegate: Text {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: weekNumber
                font: week_col.font
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                required property int weekNumber
            }
            contentItem: Rectangle {
                color: "gray"
                border.color: "black"
                ColumnLayout {
                    anchors.fill: parent
                    spacing: week_col.spacing
                    Repeater {
                        model: week_col.source
                        delegate: week_col.delegate
                    }
                }
            }
        }

        MonthGrid {
            id: month_grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            locale: Qt.locale("uk_UK")
            spacing: 1
            font{
                family: "SimHei"
                pixelSize: 14
            }
            delegate: Rectangle {
                color: model.today
                       ?"orange"
                       : control.selectDate.valueOf() === model.date.valueOf()
                         ? "darkCyan"
                         :"gray"
                border.color: "black"
                border.width: 1
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 2
                    color: "transparent"
                    border.color: "white"
                    visible: item_mouse.containsMouse
                }
                Text {
                    anchors.centerIn: parent
                    text: model.day
                    color: model.month === month_grid.month ? "white" : "black"
                }
                MouseArea {
                    id: item_mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }
            }

            onClicked: (date)=> {
                           control.selectDate = date;
                           let cur_date = new Date();

                           control.selectDate.setTime(cur_date.getTime())

                           console.log(
                               'click',control.selectDate
//                               month_grid.title,
//                               month_grid.year,
//                               month_grid.month,
//                               "--",
//                               date.getUTCFullYear(),
//                               date.getUTCMonth(),
//                               date.getUTCDate(),
//                               date.getUTCDay(),
//                               date.getTime(),
//                               date
                               )
                       }

        }
    }
}
