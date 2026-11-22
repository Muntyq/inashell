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

    readonly property string barMode: (screen && Mode.screenName === screen.name) ? Mode.mode : "default"
    readonly property bool inputActive: barMode !== "default"

    WlrLayershell.keyboardFocus: inputActive ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    RowLayout {

        anchors {
            fill: parent
            margins: Theme.gap
        }
        spacing: Theme.gap

        InputBar {
            Layout.preferredWidth: Theme.inputWidth
            Layout.fillHeight: true
            mode: bar.barMode
        }

        Box {
            Layout.fillWidth: true
            Layout.fillHeight: true

            MiddleText { mode: bar.barMode }
        }

        RowLayout {
            spacing: Theme.gap
            Layout.fillHeight: true

            Workspaces { Layout.alignment: Qt.AlignVCenter }
            Clock      { Layout.alignment: Qt.AlignVCenter }
        }
    }

    PopupWindow {
        id: popup
        anchor.window: bar
        anchor.rect.x: Theme.gap
        anchor.rect.y: bar.height
        implicitWidth: list.implicitWidth
        implicitHeight: list.implicitHeight
        color: "transparent"
        visible: bar.inputActive && Mode.items.length > 0

        ResultsList {
            id: list
            anchors.fill: parent
        }
    }
}
