import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs.services

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

            AudioControls {}
        }

        Box {
            Layout.fillWidth: true
            Layout.fillHeight: true

            MiddleText {}
        }

        RowLayout {
            spacing: Theme.gap
            Layout.fillHeight: true

            Workspaces { Layout.alignment: Qt.AlignVCenter }
            Clock      { Layout.alignment: Qt.AlignVCenter }
        }
    }
}
