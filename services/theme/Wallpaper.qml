pragma Singleton
import Quickshell
import Quickshell.Io
import qs.config

Singleton {
    id: root

    property string image: Config.wallpaper
    property var options: []
    readonly property url source: "file://" + encodeURI(image)

    FileView {
        id: state
        path: Config.wallpaperStateFile
        printErrors: false
        onLoaded: {
            const saved = text().trim();
            if (saved)
                root.image = saved;
        }
    }

    Process {
        id: scanner
        stdout: SplitParser {
            onRead: line => {
                if (line.trim())
                    root.options.push(line.trim());
            }
        }
    }

    function set(path) {
        if (!path)
            return false;
        root.image = path;
        state.setText(path + "\n");
        return true;
    }

    function scan() {
        root.options = [];
        scanner.exec(["find", Config.wallpaperDir, "-maxdepth", "1", "-type", "f", "(", "-iname", "*.png", "-o", "-iname", "*.jpg", "-o", "-iname", "*.jpeg", "-o", "-iname", "*.webp", ")"]);
    }

    function cycle() {
        if (root.options.length === 0)
            return false;
        const index = root.options.indexOf(root.image);
        return root.set(root.options[(index + 1) % root.options.length]);
    }
}
