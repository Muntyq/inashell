import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config

Item {
    id: root

    property string prefix: ">"
    property alias text: input.text

    signal accepted()
    signal cancelled()
    signal moved(int delta)

    RowLayout {
        anchors.fill: parent
        spacing: Theme.spacing / 2

        Label {
            text: root.prefix
            color: Theme.accent
            Layout.alignment: Qt.AlignVCenter
        }

        TextInput {
            id: input
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            color: Theme.fg
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            selectionColor: Theme.accent
            selectedTextColor: Theme.bg
            clip: true
            focus: true

            onAccepted: root.accepted()

            Keys.onPressed: event => {
                const ctrl = (event.modifiers & Qt.ControlModifier) !== 0;
                if (event.key === Qt.Key_Escape) {
                    root.cancelled();
                    event.accepted = true;
                } else if (event.key === Qt.Key_Down || event.key === Qt.Key_Tab
                           || (ctrl && event.key === Qt.Key_N)) {
                    root.moved(1);
                    event.accepted = true;
                } else if (event.key === Qt.Key_Up || event.key === Qt.Key_Backtab
                           || (ctrl && event.key === Qt.Key_P)) {
                    root.moved(-1);
                    event.accepted = true;
                }
            }
        }
    }

    Component.onCompleted: input.forceActiveFocus()
}
