import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services.input

Box {
    id: root

    implicitWidth: Config.popupWidth
    implicitHeight: Math.min(Mode.items.length, Config.maxResults) * Theme.rowHeight + Theme.borderWidth * 2

    Column {
        anchors.fill: parent
        anchors.margins: Theme.borderWidth

        Repeater {
            model: Mode.items

            delegate: Rectangle {
                id: row
                required property var modelData
                required property int index
                readonly property bool selected: index === Mode.index

                width: parent.width
                height: Theme.rowHeight
                color: selected ? Theme.accent : "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: Theme.spacing
                    anchors.rightMargin: Theme.spacing
                    spacing: Theme.spacing

                    Label {
                        text: row.modelData.title
                        color: row.selected ? Theme.bg : Theme.fg
                        elide: Text.ElideRight
                        Layout.maximumWidth: root.width * 0.6
                    }

                    Label {
                        text: row.modelData.subtitle || ""
                        color: row.selected ? Theme.bg : Theme.dim
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Mode.index = row.index;
                        Mode.activateRequested();
                    }
                }
            }
        }
    }
}
