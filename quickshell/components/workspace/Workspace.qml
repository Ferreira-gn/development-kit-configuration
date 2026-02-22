import Quickshell.Hyprland
import QtQuick

Rectangle {
    id: workspace
    color: "transparent"
    implicitHeight: 30

    Row {
        spacing: 10
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: 5

            Rectangle {
                id: ws
                property int currentIndex: index + 1
                property bool isActive: Hyprland.focusedWorkspace?.id === currentIndex
                property var wsData:
                    Hyprland.workspaces.values
                        ? Hyprland.workspaces.values.find(w => w.id === currentIndex)
                        : null    
                property bool hasWindows: wsData ? wsData.windows > 0 : false 


                width: isActive ? 48 : 24
                height: 20
                radius: isActive ? height / 2 : 50

                color: isActive
                       ? "#cdd6f4"        // ativo (claro, estilo end-4)
                       : hasWindows
                         ? "#45475a"     // ocupado
                         : "#313244"     // vazio

                         
                // Animação 
                Behavior on width {
                    NumberAnimation { duration: 400; easing.type: Easing.OutCubic }
                }

                Behavior on color {
                    ColorAnimation { duration: 450 }
                }

                anchors.verticalCenter: parent.verticalCenter

                Text {
                    anchors.centerIn: parent
                    text: currentIndex
                    visible: isActive
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                    color: "#1e1e2e"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Hyprland.dispatch("workspace " + currentIndex)
                }
            }
        }
    }
}
