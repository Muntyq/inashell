import Quickshell
import QtQuick
import qs.config
import qs.components

Label {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    text: "[ "+ Qt.formatDateTime(clock.date, "ddd dd MMM HH:mm") + " ]"
}
