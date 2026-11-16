import Quickshell
import "modules"
import "theme"
import "components"

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: Bar {
            required property var modelData
            screen: modelData
        }
    }
}
