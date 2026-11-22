import QtQuick
import Quickshell
import qs.config
import qs.components

Box {
    implicitWidth: label.implicitWidth + Theme.spacing

    Label {
        id: label
        anchors.centerIn: parent

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        text: " [ " + Qt.formatDateTime(clock.date, "ddd dd MMM HH:mm") + " ] "
    }
}
