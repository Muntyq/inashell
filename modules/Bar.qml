import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

PanelWindow {
    id: bar

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: Theme.barHeight
    color: Theme.bg

    WlrLayershell.namespace: "inash"

    RowLayout {

        anchors {
            fill: parent
            margins: Theme.gap
        }
        spacing: Theme.gap

        Box {
            Layout.preferredWidth: Theme.inputWidth
            Layout.fillHeight: true

            Label {
                anchors.centerIn: parent
                text: "audio"
                color: Theme.dim
            }
        }

        Box {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                anchors.centerIn: parent
                text: "inash"
                color: Theme.dim
            }
        }

        RowLayout {
            spacing: Theme.gap
            Layout.fillHeight: true

            Workspaces { Layout.alignment: Qt.AlignVCenter }
            Clock      { Layout.alignment: Qt.AlignVCenter }
        }
    }
}
