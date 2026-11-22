import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    WlrLayershell.namespace: "inash-wallpaper"
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    color: "black"

    Image {
        anchors.fill: parent
        source: Wallpaper.source
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: false
    }
}
