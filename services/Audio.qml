pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var audio: sink && sink.audio ? sink.audio : null
    readonly property real volume: audio ? audio.volume : 0
    readonly property bool muted: audio ? audio.muted : false
    readonly property int percent: Math.round(volume * 100)

    function change(delta) {
        if (audio)
            audio.volume = Math.max(0, Math.min(1, volume + delta));
    }

    function toggleMute() {
        if (audio)
            audio.muted = !audio.muted;
    }

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }
}
