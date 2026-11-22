import QtQuick
import Quickshell
import qs.config
import qs.services

Item {
    id: root

    property string query: ""
    readonly property var results: filter(query)

    function filter(q) {
        const apps = DesktopEntries.applications.values;
        const s = q.trim().toLowerCase();
        const out = [];
        for (let i = 0; i < apps.length; i++) {
            const app = apps[i];
            if (app.noDisplay)
                continue;
            const name = (app.name || "").toLowerCase();
            let score = -1;
            if (s === "")
                score = 0;
            else if (name.startsWith(s))
                score = 3;
            else if (name.indexOf(s) >= 0)
                score = 2;
            else if (((app.genericName || "") + " " + (app.comment || "")).toLowerCase().indexOf(s) >= 0)
                score = 1;
            if (score >= 0)
                out.push({ title: app.name, subtitle: app.genericName || app.comment || "", score: score, ref: app });
        }
        out.sort((a, b) => (b.score - a.score) || a.title.localeCompare(b.title));
        return out.slice(0, Config.maxResults);
    }

    function publish() {
        Mode.items = results;
        Mode.index = 0;
    }

    function accept() {
        const item = Mode.items[Mode.index];
        if (!item)
            return;
        const app = item.ref;
        Mode.reset();
        if (app.runInTerminal)
            Quickshell.execDetached([Config.terminal, "-e"].concat(Array.from(app.command)));
        else
            app.execute();
    }

    onResultsChanged: publish()
    Component.onCompleted: publish()

    Connections {
        target: Mode
        function onActivateRequested() { root.accept(); }
    }

    PromptField {
        anchors.fill: parent
        prefix: "run"
        onTextChanged: root.query = text
        onMoved: delta => Mode.move(delta)
        onAccepted: root.accept()
        onCancelled: Mode.reset()
    }
}
