import QtQuick
import qs.components
import qs.config
import qs.services

Row {
    id: root
    anchors.centerIn: parent
    spacing: Theme.spacing

    TextButton {
        text: "-"
        dim: Audio.audio === null
        onClicked: Audio.change(-0.05)
    }

    TextButton {
        text: Audio.muted ? "muted" : Audio.percent + "%"
        active: Audio.muted
        dim: Audio.audio === null
        onClicked: Audio.toggleMute()
        onScrolled: direction => Audio.change(direction * 0.05)
    }

    TextButton {
        text: "+"
        dim: Audio.audio === null
        onClicked: Audio.change(0.05)
    }

    Label {
        text: "|"
        color: Theme.dim
    }

    TextButton {
        text: "|<"
        dim: Media.player === null
        onClicked: Media.previous()
    }

    TextButton {
        text: Media.playing ? "||" : ">"
        active: Media.playing
        dim: Media.player === null
        onClicked: Media.toggle()
    }

    TextButton {
        text: ">|"
        dim: Media.player === null
        onClicked: Media.next()
    }
}
