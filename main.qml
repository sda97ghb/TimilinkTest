import QtQuick 2.12
import QtQuick.Window 2.12

import "utils.js" as Utils

Window {
    visible: true
    width: Utils.dp(2160)
    height: Utils.dp(1600)
    title: qsTr("Hello World")

    DialPadPage {
        anchors.fill: parent
    }
}
