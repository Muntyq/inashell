import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.components
import qs.config

Box {
    Layout.alignment: Qt.AlignVCenter
    implicitWidth: workspacesIndicator.implicitWidth + Theme.spacing

    Row {
        id: workspacesIndicator
        anchors.centerIn: parent
        spacing: Theme.spacing

        function workspaceExists(id) {
            const workspacesArray = Hyprland.workspaces.values;
            for (let i = 0; i < workspacesArray.length; i++)
                if (workspacesArray[i].id === id)
                    return true;
            return false;
        }

        Label { text: "[" }

        Repeater {
            model: Config.workspacesNumber

            delegate: TextButton {
                required property int index
                readonly property int workspaceId: index + 1
                readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === workspaceId

                text: focused ? "[" + workspaceId + "]" : " " + workspaceId + " "
                active: focused
                dim: !focused && !workspacesIndicator.workspaceExists(workspaceId)
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + workspaceId + " })")
            }
        }

        Label { text: "]" }
    }
}
