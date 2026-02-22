import QtQuick 

Text {
    id: clock
    color: "white"
    font.pixelSize: 14

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            const d = new Date();
            clock.text = d.toLocaleTimeString();
        }
    }

    Component.onCompleted: {
        const d = new Date();
        clock.text = d.toLocaleTimeString();
    }
}
