import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow {

    property string appName: "Trigonon"
    property string appVersion: "0.2.0-1"

    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}


