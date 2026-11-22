import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services.system

Box {
    Layout.alignment: Qt.AlignVCenter
    implicitWidth: label.implicitWidth + Theme.spacing

    Label {
        id: label
        anchors.centerIn: parent
        text: " [ " + BluetoothStatus.label + " ] "
        color: BluetoothStatus.connected ? Theme.fg : Theme.dim
    }
}
