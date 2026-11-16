import Quickshell
import QtQuick
import qs.theme
import qs.components

Label {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    text: "[ "+ Qt.formatDateTime(clock.date, "ddd dd MMM HH:mm") + " ]"
}
