import QtQuick
import Quickshell
import qs.services

Item {
    id: root

    property string query: ""
    property string pending: ""
    property bool touched: false
    readonly property var results: filter(query)

    function filter(q) {
        const s = q.trim().toLowerCase();
        const out = [];
        const list = Commands.list;
        for (let i = 0; i < list.length; i++) {
            const cmd = list[i];
            const name = cmd.name.toLowerCase();
            let score = -1;
            if (s === "")
                score = 1;
            else if (name === s)
                score = 4;
            else if (name.startsWith(s))
                score = 3;
            else if (name.indexOf(s) >= 0)
                score = 2;
            if (score >= 0)
                out.push({ title: cmd.name, subtitle: cmd.desc, score: score, ref: cmd });
        }
        out.sort((a, b) => (b.score - a.score) || a.title.localeCompare(b.title));
        return out;
    }

    function publish() {
        Mode.items = results;
        Mode.index = 0;
    }

    function accept() {
        const typed = query.trim();
        if (typed === "" && !touched)
            return;

        const item = Mode.items[Mode.index];
        if (!item) {
            Mode.reset();
            Mode.flash("unknown command: " + typed, 1500);
            return;
        }

        const cmd = item.ref;
        if (cmd.confirm && pending !== cmd.name) {
            pending = cmd.name;
            Mode.message = "run '" + cmd.name + "'? press enter again";
            return;
        }

        Mode.reset();
        Quickshell.execDetached(cmd.cmd);
        Mode.flash(cmd.name, 1000);
    }

    onQueryChanged: {
        pending = "";
        Mode.message = "";
    }
    onResultsChanged: publish()
    Component.onCompleted: publish()

    Connections {
        target: Mode
        function onActivateRequested() {
            root.touched = true;
            root.accept();
        }
    }

    PromptField {
        anchors.fill: parent
        prefix: "/"
        onTextChanged: root.query = text
        onMoved: delta => { root.touched = true; Mode.move(delta); }
        onAccepted: root.accept()
        onCancelled: Mode.reset()
    }
}
