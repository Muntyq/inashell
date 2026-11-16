import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.theme
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
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: Theme.gap
        }
        spacing: Theme.spacing

        // InputBar {}
        // MiddleText {}
        Clock {}
        // BthStatus {}
        // NetStatus {}
        // SysInfo {}
    }
}
