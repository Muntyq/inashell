pragma Singleton
import Quickshell
import Quickshell.Io
import QtQml

Singleton {
    id: root

    property real cpu: 0
    property real memory: 0
    property real memoryUsed: 0
    property real memoryTotal: 0

    property int lastTotal: 0
    property int lastIdle: 0

    property FileView statFile: FileView {
        path: "/proc/stat"
        printErrors: false
        onLoaded: {
            const fields = text().split("\n")[0].trim().split(/\s+/);
            let total = 0;
            for (let i = 1; i < fields.length; i++)
                total += parseInt(fields[i]) || 0;
            const idle = (parseInt(fields[4]) || 0) + (parseInt(fields[5]) || 0);
            if (root.lastTotal > 0) {
                const delta = total - root.lastTotal;
                if (delta > 0)
                    root.cpu = Math.max(0, Math.min(100, 100 * (1 - (idle - root.lastIdle) / delta)));
            }
            root.lastTotal = total;
            root.lastIdle = idle;
        }
    }

    property FileView memFile: FileView {
        path: "/proc/meminfo"
        printErrors: false
        onLoaded: {
            let total = 0;
            let available = 0;
            for (const line of text().split("\n")) {
                const parts = line.trim().split(/\s+/);
                if (parts[0] === "MemTotal:")
                    total = parseInt(parts[1]) || 0;
                if (parts[0] === "MemAvailable:")
                    available = parseInt(parts[1]) || 0;
            }
            root.memoryTotal = total / 1048576;
            root.memoryUsed = (total - available) / 1048576;
            if (total > 0)
                root.memory = 100 * (total - available) / total;
        }
    }

    property Timer timer: Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            root.statFile.reload();
            root.memFile.reload();
        }
    }
}
