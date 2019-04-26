import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import "utils.js" as Utils

Item {
    id: root

    implicitWidth: Utils.dp(240) * 3
    implicitHeight: Utils.dp(120) * 4

    signal pressed(string digit)

    Rectangle {
        anchors.fill: parent
        color: "#BFBFBF"
    }

    GridLayout {
        anchors.fill: parent
        columns: 3
        columnSpacing: Utils.dp(2)
        rowSpacing: Utils.dp(2)
        Repeater {
            model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"]
            delegate: Button {
                Layout.fillWidth: true; Layout.fillHeight: true
                text: modelData
                background: Rectangle {
                    color: parent.pressed ? "silver" : "white"
                }
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: Utils.dp(48)
                onPressed: root.pressed(modelData)
            }
        }
    }
}
