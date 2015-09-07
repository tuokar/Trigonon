import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: about

    property bool backStepping: true
    property int operationType: PageStackAction.Animated

    function switchOperationType() {
        operationType = (operationType === PageStackAction.Immediate ? PageStackAction.Animated : PageStackAction.Immediate)
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: about.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "About " + appName
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../images/big_icon.png"
                fillMode: Image.PreserveAspectFit
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
                text: "Trigonometry calculator<p>for Sailfish OS"
                wrapMode: TextEdit.WordWrap
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 18
                color: Theme.primaryColor
                text: "<p>" + appName + " is a simple right-angled triangle calculator for Sailfish OS.<p>"
                wrapMode: TextEdit.WordWrap
            }

            Text {
                width: parent.width - 2*Theme.paddingLarge
                x: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 20
                color: Theme.highlightColor
                text: "Version " + appVersion + "<p>Developed by Tuomas Kärki"
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}

