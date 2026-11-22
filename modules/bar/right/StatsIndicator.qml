import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services.system

Box {
    Layout.alignment: Qt.AlignVCenter
    implicitWidth: row.implicitWidth + Theme.spacing

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Theme.spacing

        Label { text: " [ " }
        Label {
            text: "CPU " + String(Math.round(SystemStats.cpu)).padStart(2, "0") + "%"
            color: SystemStats.cpu >= 90 ? Theme.accent : Theme.fg
        }
        Label { text: " | " }

        Label {
            text: "MEM " + String(Math.round(SystemStats.memory)).padStart(2, "0") + "%"
            color: SystemStats.memory >= 90 ? Theme.accent : Theme.fg
        }
        Label { text: " ] " }
    }
}
