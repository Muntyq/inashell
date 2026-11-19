pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    // Colors
    readonly property color bg: "#1d2021"
    readonly property color surface: "#282828"
    readonly property color fg: "#ebdbb2"
    readonly property color dim: "#928374"
    readonly property color accent: "#fabd2f"
    readonly property color border: "#665c54"

    // Metrics
    readonly property int barHeight: 32
    readonly property int rowHeight: 24
    readonly property int gap: 4
    readonly property int spacing: 8
    readonly property int fontSize: 13
    readonly property string font: "monospace"
    readonly property int radius: 0
    readonly property int borderWidth: 2
    readonly property int inputWidth: 300
}
