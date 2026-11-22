import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services.audio

RowLayout {
    id: root
    anchors.fill: parent
    spacing: Theme.spacing

    TextButton {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "[-]"
        dim: Audio.audio === null
        onClicked: Audio.change(-0.05)
    }

    TextButton {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: Audio.muted ? "MUTE" : Audio.percent === 100 ? "MAX%" : Audio.percent + " %"
        active: Audio.muted || Audio.percent === 100
        dim: Audio.audio === null
        onClicked: Audio.toggleMute()
        onScrolled: direction => Audio.change(direction * 0.05)
    }

    TextButton {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "[+]"
        dim: Audio.audio === null
        onClicked: Audio.change(0.05)
    }

    Label {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "|"
    }

    TextButton {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "[ PREV ]"
        dim: Media.player === null
        onClicked: Media.previous()
    }

    TextButton {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: Media.playing ? "[ STOP ]" : "[ PLAY ]"
        active: Media.playing
        dim: Media.player === null
        onClicked: Media.toggle()
    }

    TextButton {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "[ NEXT ]"
        dim: Media.player === null
        onClicked: Media.next()
    }
}
