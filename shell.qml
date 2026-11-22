import Quickshell
import Quickshell.Io
import "modules"
import qs.services

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: Bar {
            required property var modelData
            screen: modelData
        }
    }

    IpcHandler {
        target: "inash"

        function toggle(mode: string): void {
            Mode.toggle(mode);
        }

        function reset(): void {
            Mode.reset();
        }
    }
}
