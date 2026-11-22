pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property int workspacesNumber: 5
    readonly property int inputWidth: 300
    readonly property int popupWidth: 460
    readonly property int maxResults: 8
    readonly property string terminal: "ghostty"
}
