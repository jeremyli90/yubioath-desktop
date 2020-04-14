import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

ColumnLayout {

    readonly property int dynamicWidth: 380
    readonly property int dynamicMargin: 32

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    width: app.width * 0.9 > 600 ? 600 : app.width * 0.9
    height: parent.height

    function getDeviceDescription() {
        if (!!yubiKey.currentDevice) {
            return yubiKey.currentDevice.usbInterfacesEnabled.join('+')
        } else if (yubiKey.availableDevices.length > 0
                   && !yubiKey.availableDevices.some(dev => dev.selectable)) {
            return qsTr("No compatible device found")
        } else {
            return qsTr("No device found")
        }
    }

    Layout.fillWidth: true

    ColumnLayout {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.bottomMargin: 16
        Layout.fillWidth: true
        width: parent.width
        spacing: 0

        Rectangle {
            id: rectangle
            width: 140
            height: 140
            color: formHighlightItem
            radius: width * 0.5
            Layout.margins: 16
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                sourceSize.width: 120
                source: !!yubiKey.currentDevice ? yubiKey.getCurrentDeviceImage() : ""
                fillMode: Image.PreserveAspectFit
                visible: parent.visible
            }
        }

        Label {
            text: !!yubiKey.currentDevice ? yubiKey.currentDevice.name : ""
            font.pixelSize: 16
            font.weight: Font.Normal
            lineHeight: 1.8
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            color: primaryColor
            opacity: highEmphasis
        }

        Label {
            text: !!yubiKey.currentDevice ? "Serial number: " + yubiKey.currentDevice.serial : ""
            visible: !!yubiKey.currentDevice && yubiKey.currentDevice.serial
            color: primaryColor
            opacity: lowEmphasis
            font.pixelSize: 12
            lineHeight: 1.2
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            wrapMode: Text.NoWrap
            Layout.maximumWidth: parent.width
            width: parent.width

        }

        Label {
            text: !!yubiKey.currentDevice ? "Firmware version: " + yubiKey.currentDevice.version : ""
            visible: !!yubiKey.currentDevice && yubiKey.currentDevice.version
            color: primaryColor
            opacity: lowEmphasis
            font.pixelSize: 12
            lineHeight: 1.2
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            wrapMode: Text.NoWrap
            Layout.maximumWidth: parent.width
            width: parent.width
        }

        Label {
            text: !!yubiKey.currentDevice ? qsTr("Enabled interfaces: ") + getDeviceDescription() : ""
            color: primaryColor
            opacity: lowEmphasis
            font.pixelSize: 12
            lineHeight: 1.2
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            wrapMode: Text.NoWrap
            Layout.maximumWidth: parent.width
            width: parent.width
        }

        StyledButton {
            id: addBtn
            text: qsTr("Add security codes")
            enabled: true
            focus: true
            Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
            onClicked: yubiKey.scanQr()
            Keys.onReturnPressed: yubiKey.scanQr()
            Keys.onEnterPressed: yubiKey.scanQr()
            Layout.topMargin: 14
        }
    }
}
