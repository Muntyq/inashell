import QtQuick
import qs.components
import qs.config
import qs.services

Label {
    id: root
    anchors.centerIn: parent
    width: Math.min(implicitWidth, parent.width - Theme.spacing)
    elide: Text.ElideRight

    property string mode: "default"

    readonly property string display: {
        if (Mode.message !== "")
            return Mode.message;
        if (mode === "launch")
            return "launch  [enter] run  [esc] cancel";
        if (mode === "command")
            return "command  [enter] run  [esc] cancel";
        return Media.text !== "" ? Media.text : "inash";
    }

    text: root.display
    color: root.mode !== "default" ? Theme.accent : (Media.text !== "" ? Theme.fg : Theme.dim)
}
