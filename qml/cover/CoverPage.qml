import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Text {
        width: parent.width - 2*Theme.paddingMedium
        x: Theme.paddingMedium
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 28
        color: Theme.highlightColor
        text: appName
        wrapMode: TextEdit.WordWrap
        anchors {
            top: parent.top
            topMargin: 20
        }
    }

    Text {
        width: parent.width - 2*Theme.paddingMedium
        x: Theme.paddingMedium
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 20
        color: Theme.primaryColor
        text: "Trigonometry calculator<p>for Sailfish OS"
        wrapMode: TextEdit.WordWrap
        anchors {
            bottom: parent.bottom
            bottomMargin: 20
        }
    }
}


