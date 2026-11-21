import QtQuick
import qs.components
import qs.config
import qs.services

Label {
    id: root
    anchors.centerIn: parent
    width: Math.min(implicitWidth, parent.width - Theme.spacing)
    elide: Text.ElideRight

    text: Media.text !== "" ? Media.text : "inash"
    color: Media.text !== "" ? Theme.fg : Theme.dim
}
