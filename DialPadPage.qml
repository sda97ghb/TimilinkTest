import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import "utils.js" as Utils

Page {
    id: root

    QtObject {
        id: viewModel

        property string phoneNumber: ""

        function clearPhoneNumber() {
            phoneNumber = "";
        }

        property bool isCalling: false
        property int callLength: 0
        property int callLengthMinutes: callLength / 60
        property int callLengthSeconds: callLength % 60

        function isPhoneNumberValid() {
            // TODO: Сделать нормальную проверку
            return phoneNumber !== "";
        }

        function call() {
            if (isPhoneNumberValid()) {
                isCalling = true;
                callLength = 0;
                fakeCallTimer.start();
                console.log("Call " + phoneNumber);
            }
        }

        function endCall() {
            isCalling = false;
            fakeCallTimer.stop();
            console.log("End call");
        }
    }

    Timer {
        id: fakeCallTimer
        interval: 1000
        repeat: true
        running: false
        onTriggered: viewModel.callLength += 1
    }

    function getCallLengthAsString() {
        return viewModel.callLengthMinutes + ":" +
                (viewModel.callLengthSeconds < 10 ? "0" : "") +
                viewModel.callLengthSeconds;
    }

    background: Rectangle {
        color: "#001A2E"
    }

    leftPadding: Utils.dp(40)
    rightPadding: Utils.dp(40)
    topPadding: Utils.dp(110)
    bottomPadding: Utils.dp(320)

    RowLayout {
        anchors.fill: parent
        spacing: Utils.dp(0)

        RoundedRectangle {
            Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
            color: "#FFFFFF"
            topLeftRadius: Utils.dp(25)
            bottomLeftRadius: Utils.dp(25)
            topRightRadius: Utils.dp(0)
            bottomRightRadius: Utils.dp(0)

            Label {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: Utils.dp(72)
                font.family: "Roboto"
                font.weight: Font.Medium
                font.pixelSize: Utils.dp(48)
                text: viewModel.isCalling ? "Вызов " + getCallLengthAsString() : "Введите номер телефона"
            }

            Label {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: Utils.dp(140)
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: Utils.dp(24)
                color: "#A6A6A6"
                text: "Длительность разговора неограниченна"
            }

            TextField {
                id: phoneNumberInput
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: Utils.dp(250)
                width: Utils.dp(720)
                height: Utils.dp(80)
                font.family: "Roboto"
                font.weight: Font.Normal
                font.pixelSize: Utils.dp(32)
                maximumLength: 35
                readOnly: true
                background: Rectangle {
                    color: "white"
                    radius: Utils.dp(16)
                    border.color: "#BFBFBF"
                    border.width: Utils.dp(2)
                }
                text: viewModel.phoneNumber

                Button {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: Utils.dp(24)
                    width: Utils.dp(48)
                    height: Utils.dp(48)
                    visible: viewModel.phoneNumber !== ""
                    background: Rectangle { color: "transparent" }
                    contentItem: Item {
                        anchors.fill: parent
                        Image {
                            anchors.centerIn: parent
                            width: Utils.dp(57)
                            height: Utils.dp(48)
                            source: "icons/ic_clear.svg"
                        }
                    }
                    onClicked: viewModel.clearPhoneNumber()
                }
            }

            DialPad {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: Utils.dp(390)
                onPressed: viewModel.phoneNumber += digit
            }

            DialButton {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: Utils.dp(930)
                state: viewModel.isCalling ? "calling" :
                       viewModel.phoneNumber === "" ? "idle" : "ready_to_call"
                onClicked: {
                    if (viewModel.isCalling)
                        viewModel.endCall();
                    else
                        viewModel.call();
                }
            }
        }
        RoundedRectangle {
            Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
            color: "#CCD6E3"
            topLeftRadius: Utils.dp(0)
            bottomLeftRadius: Utils.dp(0)
            topRightRadius: Utils.dp(25)
            bottomRightRadius: Utils.dp(25)
        }
    }
}
