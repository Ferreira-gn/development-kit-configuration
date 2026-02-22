import QtQuick
import "../../components/workspace" 
import "../../components/clock" 

Rectangle {
    id: root
    color: "#1e1e2e"
    implicitWidth: parent.width
    implicitHeight: parent.height
    
    
    Workspace{}

    // CENTRO 
    // Futuro componente de data e hora 
    Row {
        id: centerArea
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: "Centro"
            color: "white"
        }
    }

    // DIREITA
    // futuro componente de informações do sistema
    Row {
        id: rightArea
        spacing: 12

        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        Clock {}
    }
}
