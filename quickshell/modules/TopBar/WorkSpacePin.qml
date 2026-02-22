import QtQuick 2.15
import QtQuick.Controls 2.15

Row {
    id: root
    spacing: 8

    // API pública
    property int currentIndex: 0
    property var workspaces: []   // ex: ["1", "2", "3", "4"]

    signal workspaceSelected(int index)

    Repeater {
        model: root.workspaces.length

        Rectangle {
            width: 12
            height: 12
            radius: 6

            color: index === root.currentIndex
                   ? "#4f46e5"     // ativo
                   : "#9ca3af"     // inativo

            opacity: index === root.currentIndex ? 1.0 : 0.6

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    root.currentIndex = index
                    root.workspaceSelected(index)
                }
            }
        }
    }
}
