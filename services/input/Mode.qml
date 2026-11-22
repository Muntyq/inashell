pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property string mode: "default"
    property string screenName: ""
    property string message: ""
    property var items: []
    property int index: 0

    signal activateRequested()

    function set(m) {
        if (m === "default") {
            reset();
            return;
        }
        const monitor = Hyprland.focusedMonitor;
        screenName = monitor ? monitor.name : (Quickshell.screens.length ? Quickshell.screens[0].name : "");
        clearMessage();
        items = [];
        index = 0;
        mode = m;
    }

    function toggle(m) {
        if (mode === m)
            reset();
        else
            set(m);
    }

    function reset() {
        mode = "default";
        screenName = "";
        items = [];
        index = 0;
        clearMessage();
    }

    function move(delta) {
        if (items.length === 0)
            return;
        index = Math.max(0, Math.min(items.length - 1, index + delta));
    }

    function flash(text, ms) {
        message = text;
        flashTimer.interval = ms || 1500;
        flashTimer.restart();
    }

    function clearMessage() {
        flashTimer.stop();
        message = "";
    }

    Timer {
        id: flashTimer
        onTriggered: root.message = ""
    }
}
