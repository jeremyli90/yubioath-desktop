import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

ColumnLayout {

    readonly property int dynamicWidth: 380
    readonly property int dynamicMargin: 32

    property string deviceName: !!yubiKey.currentDevice ? yubiKey.currentDevice.name : ""
    property string deviceSerial: !!yubiKey.currentDevice && !!yubiKey.currentDevice.serial ? yubiKey.currentDevice.serial : ""
    property string deviceVersion: !!yubiKey.currentDevice && !!yubiKey.currentDevice.version ? yubiKey.currentDevice.version : ""
    property string deviceImage: !!yubiKey.currentDevice ? yubiKey.getCurrentDeviceImage() : ""

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    width: app.width * 0.9 > 600 ? 600 : app.width * 0.9
    height: parent.height

    Layout.fillWidth: true

    ColumnLayout {
        id: fullHeight
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.topMargin: 32
        Layout.bottomMargin: 16
        Layout.fillWidth: true
        width: parent.width
        spacing: 4
        visible: app.height > 462

        Rectangle {
            width: 100
            height: 100
            color: formHighlightItem
            radius: width * 0.5
            Layout.topMargin: 16
            Layout.bottomMargin: 16
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                sourceSize.width: 80
                source: deviceImage
                fillMode: Image.PreserveAspectFit
                visible: parent.visible
            }
        }

        Label {
            text: deviceName
            font.pixelSize: 16
            font.weight: Font.Normal
            lineHeight: 1.8
            color: primaryColor
            opacity: highEmphasis
        }

        StyledTextField {
            labelText: qsTr("Serial number")
            text: deviceSerial
            visible: text.length > 0
            enabled: false
        }

        StyledTextField {
            labelText: qsTr("Firmware version")
            text: deviceVersion
            visible: text.length > 0
            enabled: false
        }

        Button {
            id: configureDevice
            text: qsTr("Configure device")
            flat: true
            focus: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            onClicked: navigator.goToSettings()
            Keys.onReturnPressed: navigator.goToSettings()
            Keys.onEnterPressed: navigator.goToSettings()
            font.pixelSize: 10
            font.bold: false
            font.capitalization: Font.MixedCase
            background: Rectangle {
                    color: parent.hovered ? defaultElevated : "transparent"
                    border.color: formUnderline
                    border.width: 1
                    radius: 4
                    visible: border
                    enabled: border
                }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                enabled: false
            }

        }

        StyledButton {
            id: addBtn
            text: qsTr("Add security codes")
            focus: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            onClicked: yubiKey.scanQr()
            Keys.onReturnPressed: yubiKey.scanQr()
            Keys.onEnterPressed: yubiKey.scanQr()
            Layout.topMargin: 16
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        Layout.topMargin: 32
        Layout.bottomMargin: 16
        Layout.fillWidth: true
        width: parent.width
        spacing: 4
        visible: !fullHeight.visible

        Rectangle {
            width: 100
            height: 100
            color: formHighlightItem
            radius: width * 0.5
            Layout.topMargin: 16
            Layout.bottomMargin: 16
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                sourceSize.width: 80
                source: deviceImage
                fillMode: Image.PreserveAspectFit
                visible: parent.visible
            }
        }

        ColumnLayout {
            spacing: 4
            Layout.topMargin: 0
            Layout.leftMargin: 16

            Label {
                text: deviceName
                font.pixelSize: 16
                font.weight: Font.Normal
                lineHeight: 1.8
                color: primaryColor
                opacity: highEmphasis
            }

            StyledTextField {
                labelText: qsTr("Serial number")
                text: deviceSerial
                visible: text.length > 0
                enabled: false
            }

            StyledTextField {
                labelText: qsTr("Firmware version")
                text: deviceVersion
                visible: text.length > 0
                enabled: false
            }
        }
    }
}
