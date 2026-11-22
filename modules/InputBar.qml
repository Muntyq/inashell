import QtQuick
import qs.components
import qs.config
import qs.services

Box {
    id: root

    property string mode: "default"

    AudioControls {
        anchors.centerIn: parent
        visible: root.mode === "default"
    }

    Loader {
        anchors.fill: parent
        anchors.leftMargin: Theme.spacing
        anchors.rightMargin: Theme.spacing
        active: root.mode !== "default"
        sourceComponent: root.mode === "launch" ? launchView : commandView
    }

    Component { id: launchView; LaunchInput {} }
    Component { id: commandView; CommandInput {} }
}
