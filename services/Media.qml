pragma Singleton
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    function pick() {
        const players = Mpris.players.values;
        let fallback = null;
        for (let i = 0; i < players.length; i++) {
            if (players[i].isPlaying)
                return players[i];
            if (!fallback)
                fallback = players[i];
        }
        return fallback;
    }

    readonly property var player: pick()
    readonly property bool playing: player ? player.isPlaying : false

    readonly property string text: {
        if (!player)
            return "";
        const title = player.trackTitle || "";
        if (title === "")
            return "";
        const artist = player.trackArtist || "";
        const base = artist !== "" ? artist + " - " + title : title;
        return player.isPlaying ? base : "(paused) " + base;
    }

    function toggle() {
        if (player && player.canTogglePlaying)
            player.togglePlaying();
    }

    function next() {
        if (player && player.canGoNext)
            player.next();
    }

    function previous() {
        if (player && player.canGoPrevious)
            player.previous();
    }
}
