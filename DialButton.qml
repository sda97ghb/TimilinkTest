import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import "utils.js" as Utils

Button {
    id: root

    implicitWidth: Utils.dp(720)
    implicitHeight: Utils.dp(80)
    font.family: "Roboto"
    font.weight: Font.Medium
    font.pixelSize: Utils.dp(32)
    contentItem: RowLayout {
        anchors.fill: parent
        spacing: Utils.dp(8)
        Item { Layout.fillWidth: true}
        Image {
            id: buttonImage
            source: ""
            Layout.preferredWidth: implicitWidth / 2
            Layout.preferredHeight: implicitHeight / 2
        }
        Text {
            id: buttonText
            Layout.preferredHeight: implicitHeight
            Layout.preferredWidth: implicitWidth
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font: root.font
            color: "#A6A6A6"
            text: root.text
        }
        Item { Layout.fillWidth: true}
    }
    background: Rectangle {
        id: buttonBackground
        radius: height / 2
        color: "#EAEAEA"
    }
    text: "Для вызова снимите трубку"

    states: [
        State {
            name: "idle"
            PropertyChanges { target: buttonBackground; color: "#EAEAEA" }
            PropertyChanges { target: buttonText; color: "#A6A6A6" }
            PropertyChanges { target: buttonText; text: "Для вызова снимите трубку" }
            PropertyChanges { target: buttonImage; source: "" }
        },
        State {
            name: "ready_to_call"
            PropertyChanges { target: buttonBackground; color: "#21B239" }
            PropertyChanges { target: buttonText; color: "#FFFFFF" }
            PropertyChanges { target: buttonText; text: "Вызов" }
            PropertyChanges { target: buttonImage; source: "icons/ic_call.svg" }
        },
        State {
            name: "calling"
            PropertyChanges { target: buttonBackground; color: "#F23D49" }
            PropertyChanges { target: buttonText; color: "#FFFFFF" }
            PropertyChanges { target: buttonText; text: "Завершить вызов" }
            PropertyChanges { target: buttonImage; source: "icons/ic_end_call.svg" }
        }
    ]
    state: "idle"

    transitions: [
        Transition {
            from: "idle"
            to: "ready_to_call"
            ColorAnimation { target: buttonBackground; duration: 100 }
            ColorAnimation { target: buttonText; duration: 100 }
        },
        Transition {
            from: "ready_to_call"
            to: "calling"
            ColorAnimation { target: buttonBackground; duration: 100 }
            ColorAnimation { target: buttonText; duration: 100 }
        },
        Transition {
            from: "calling"
            to: "idle"
            ColorAnimation { target: buttonBackground; duration: 100 }
            ColorAnimation { target: buttonText; duration: 100 }
        }
    ]
}
