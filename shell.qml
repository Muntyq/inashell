import Quickshell
import Quickshell.Io
import QtQml
import "modules"
import qs.services

ShellRoot {
    QtObject {
        Component.onCompleted: Wallpaper.scan()
    }

    Variants {
        model: Quickshell.screens
        delegate: WallpaperLayer {
            required property var modelData
            screen: modelData
        }
    }

    Variants {
        model: Quickshell.screens
        delegate: Bar {
            required property var modelData
            screen: modelData
        }
    }

    AutoTheme {}

    IpcHandler {
        target: "inash"

        function toggle(mode: string): void {
            Mode.toggle(mode);
        }

        function reset(): void {
            Mode.reset();
        }

        function setwallpaper(path: string): void {
            Wallpaper.set(path);
        }

        function cyclewallpaper(): void {
            Wallpaper.cycle();
        }
    }
}
