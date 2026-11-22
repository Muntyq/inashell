import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services

Box {
    Layout.alignment: Qt.AlignVCenter
    implicitWidth: row.implicitWidth + Theme.spacing

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Theme.spacing

        Label { text: " [ NET " }
        Label {
            text: NetworkStatus.label
            color: NetworkStatus.connected ? Theme.fg : Theme.dim
        }
        Label { text: " ] " }
    }
}
