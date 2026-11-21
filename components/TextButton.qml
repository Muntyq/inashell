import QtQuick
import qs.config

Label {
    id: root

    property bool active: false
    property bool dim: false
    signal clicked()
    signal scrolled(int direction)

    color:(area.containsMouse || root.active) ? Theme.accent : (root.dim ? Theme.dim : Theme.fg)

    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
        onWheel: wheel => root.scrolled(wheel.angleDelta.y > 0 ? 1 : -1)
    }
}
