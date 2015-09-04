import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: root
    onStatusChanged: {
        if(status == PageStatus.Active) {
            return(pageStack.pushAttached(triangleViewPage, {}, operationType))
        }
    }

    property bool backStepping: true
    property int operationType: PageStackAction.Animated

    function switchOperationType() {
        operationType = (operationType === PageStackAction.Immediate ? PageStackAction.Animated : PageStackAction.Immediate)
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        PullDownMenu {

            MenuItem {
                text: "About..."
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            }
        }

        Column {
            id: column
            spacing: Theme.paddingSmall
            anchors {
                left: parent.left
                right: parent.right
            }

            PageHeader {
                title: appName
            }

            SectionHeader {
                text: "Sides"
            }

            TextField {
                id: cathetus_a
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of cathetus a"
                placeholderText: "Enter length of cathetus a"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    triangleCanvas.context.clearRect(0, 0, triangleCanvas.width, triangleCanvas.height)
                    triangleCanvas.requestPaint()
                    if(hypotenuse_c.text != "" && cathetus_a.text*1 >= hypotenuse_c.text*1)
                        return(cathetus_a.text = "")
                    else if(cathetus_a.text != "" && cathetus_b.text != "")
                        return(hypotenuse_c.text = hypotenuse_c.c(), angle_alpha.text = angle_alpha.tan_alpha(), angle_beta.text = angle_beta.tan_beta())
                    else if(cathetus_a.text != "" && hypotenuse_c.text != "")
                        return(cathetus_b.text = cathetus_b.b(), angle_alpha.text = angle_alpha.sin_alpha(), angle_beta.text = angle_beta.cos_beta())
                    else if(cathetus_a.text != "" && angle_alpha.text != "")
                        return(cathetus_b.text = cathetus_b.b_tanalpha(), hypotenuse_c.text = hypotenuse_c.c_sinalpha(), angle_beta.text = angle_beta.beta())
                    else if(cathetus_a.text != "" && angle_beta.text != "")
                        return(cathetus_b.text = cathetus_b.b_tanbeta(), hypotenuse_c.text = hypotenuse_c.c_cosbeta(), angle_alpha.text = angle_alpha.alpha())
                }

                // a²+b²=c²->a=/c²-b²
                function a() {
                    var b = cathetus_b.text
                    var c = hypotenuse_c.text
                    return(Math.sqrt(Math.pow(c, 2) - Math.pow(b, 2))).toFixed(12).replace(/\.?0+$/, "")
                }

                function a_tanalpha() {
                    var b = cathetus_b.text
                    var alpha = angle_alpha.text
                    return(Math.abs(b * Math.tan(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function a_sinalpha() {
                    var c = hypotenuse_c.text
                    var alpha = angle_alpha.text
                    return(Math.abs(c * Math.sin(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function a_tanbeta() {
                    var b = cathetus_b.text
                    var beta = angle_beta.text
                    return(Math.abs(b / Math.tan(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function a_cosbeta() {
                    var c = hypotenuse_c.text
                    var beta = angle_beta.text
                    return(Math.abs(c * Math.cos(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: cathetus_b
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of cathetus b"
                placeholderText: "Enter length of cathetus b"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    triangleCanvas.context.clearRect(0, 0, triangleCanvas.width, triangleCanvas.height)
                    triangleCanvas.requestPaint()
                    if(hypotenuse_c.text != "" && cathetus_b.text*1 >= hypotenuse_c.text*1)
                        return(cathetus_b.text = "")
                    else if(cathetus_a.text != "" && cathetus_b.text != "")
                        return(hypotenuse_c.text = hypotenuse_c.c(), angle_alpha.text = angle_alpha.tan_alpha(), angle_beta.text = angle_beta.tan_beta())
                    else if(cathetus_b.text != "" && hypotenuse_c.text != "")
                        return(cathetus_a.text = cathetus_a.a(), angle_beta.text = angle_beta.sin_beta(), angle_alpha.text = angle_alpha.cos_alpha())
                    else if(cathetus_b.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.a_tanbeta(), hypotenuse_c.text = hypotenuse_c.c_sinbeta(), angle_alpha.text = angle_alpha.alpha())
                    else if(cathetus_b.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.a_tanalpha(), hypotenuse_c.text = hypotenuse_c.c_cosalpha(), angle_beta.text = angle_beta.beta())
                }

                // a²+b²=c²->b=/c²-a²
                function b() {
                    var a = cathetus_a.text
                    var c = hypotenuse_c.text
                    return(Math.sqrt(Math.pow(c, 2) - Math.pow(a, 2))).toFixed(12).replace(/\.?0+$/, "")
                }

                function b_tanalpha() {
                    var a = cathetus_a.text
                    var alpha = angle_alpha.text
                    return(Math.abs(a / Math.tan(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function b_cosalpha() {
                    var c = hypotenuse_c.text
                    var alpha = angle_alpha.text
                    return(Math.abs(c * Math.cos(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function b_tanbeta() {
                    var a = cathetus_a.text
                    var beta = angle_beta.text
                    return(Math.abs(a * Math.tan(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function b_sinbeta() {
                    var c = hypotenuse_c.text
                    var beta = angle_beta.text
                    return(Math.abs(c * Math.sin(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: hypotenuse_c
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of hypotenuse c"
                placeholderText: "Enter length of hypotenuse c"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    triangleCanvas.context.clearRect(0, 0, triangleCanvas.width, triangleCanvas.height)
                    triangleCanvas.requestPaint()
                    if((cathetus_a.text != "" && hypotenuse_c.text*1 <= cathetus_a.text*1) || (cathetus_b.text != "" && hypotenuse_c.text*1 <= cathetus_b.text*1))
                        return(hypotenuse_c.text = "")
                    else if(cathetus_a.text != "" && hypotenuse_c.text != "")
                        return(cathetus_b.text = cathetus_b.b(), angle_alpha.text = angle_alpha.sin_alpha(), angle_beta.text = angle_beta.cos_beta())
                    else if(cathetus_b.text != "" && hypotenuse_c.text != "")
                        return(cathetus_a.text = cathetus_a.a(), angle_beta.text = angle_beta.sin_beta(), angle_alpha.text = angle_alpha.cos_alpha())
                    else if(hypotenuse_c.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.a_cosbeta(), cathetus_b.text = cathetus_b.b_sinbeta(), angle_alpha.text = angle_alpha.alpha())
                    else if(hypotenuse_c.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.a_sinalpha(), cathetus_b.text = cathetus_b.b_cosalpha(), angle_beta.text = angle_beta.beta())
                }

                // a²+b²=c²->c=/a²+b²
                function c() {
                    var a = cathetus_a.text
                    var b = cathetus_b.text
                    return(Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2))).toFixed(12).replace(/\.?0+$/, "")
                }

                function c_sinalpha() {
                    var a = cathetus_a.text
                    var alpha = angle_alpha.text
                    return(Math.abs(a / Math.sin(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function c_cosalpha() {
                    var b = cathetus_b.text
                    var alpha = angle_alpha.text
                    return(Math.abs(b / Math.cos(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function c_sinbeta() {
                    var b = cathetus_b.text
                    var beta = angle_beta.text
                    return(Math.abs(b / Math.sin(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function c_cosbeta() {
                    var a = cathetus_a.text
                    var beta = angle_beta.text
                    return(Math.abs(a / Math.cos(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            SectionHeader {
                text: "Angles"
            }

            TextField {
                id: angle_alpha
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Angle α (a's opposite)"
                placeholderText: "Enter angle α (a's opposite)"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    triangleCanvas.context.clearRect(0, 0, triangleCanvas.width, triangleCanvas.height)
                    triangleCanvas.requestPaint()
                    if(angle_alpha.text*1 <= 0 || angle_alpha.text*1 >= 90)
                        return(angle_alpha.text = "")
                    if(cathetus_b.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.a_tanalpha(), hypotenuse_c.text = hypotenuse_c.c_cosalpha(), angle_beta.text = angle_beta.beta())
                    else if(hypotenuse_c.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.a_sinalpha(), cathetus_b.text = cathetus_b.b_cosalpha(), angle_beta.text = angle_beta.beta())
                    else if(cathetus_a.text != "" && angle_alpha.text != "")
                        return(cathetus_b.text = cathetus_b.b_tanalpha(), hypotenuse_c.text = hypotenuse_c.c_sinalpha(), angle_beta.text = angle_beta.beta())
                }

                function alpha() {
                    var beta = angle_beta.text
                    return(Math.abs(90 - beta)).toFixed(12).replace(/\.?0+$/, "")
                }

                function tan_alpha() {
                    var a = cathetus_a.text
                    var b = cathetus_b.text
                    return(Math.atan(a / b) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function sin_alpha() {
                    var a = cathetus_a.text
                    var c = hypotenuse_c.text
                    return(Math.asin(a / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function cos_alpha() {
                    var b = cathetus_b.text
                    var c = hypotenuse_c.text
                    return(Math.acos(b / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: angle_beta
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Angle β (b's opposite)"
                placeholderText: "Enter angle β (b's opposite)"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    triangleCanvas.context.clearRect(0, 0, triangleCanvas.width, triangleCanvas.height)
                    triangleCanvas.requestPaint()
                    if(angle_beta.text*1 <= 0 || angle_beta.text*1 >= 90)
                        return(angle_beta.text = "")
                    if(cathetus_b.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.a_tanbeta(), hypotenuse_c.text = hypotenuse_c.c_sinbeta(), angle_alpha.text = angle_alpha.alpha())
                    else if(hypotenuse_c.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.a_cosbeta(), cathetus_b.text = cathetus_b.b_sinbeta(), angle_alpha.text = angle_alpha.alpha())
                    else if(cathetus_a.text != "" && angle_beta.text != "")
                        return(cathetus_b.text = cathetus_b.b_tanbeta(), hypotenuse_c.text = hypotenuse_c.c_cosbeta(), angle_alpha.text = angle_alpha.alpha())
                }

                function beta() {
                    var alpha = angle_alpha.text
                    return(Math.abs(90 - alpha)).toFixed(12).replace(/\.?0+$/, "")
                }

                function tan_beta() {
                    var b = cathetus_b.text
                    var a = cathetus_a.text
                    return(Math.atan(b / a) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function sin_beta() {
                    var b = cathetus_b.text
                    var c = hypotenuse_c.text
                    return(Math.asin(b / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function cos_beta() {
                    var a = cathetus_a.text
                    var c = hypotenuse_c.text
                    return(Math.acos(a / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            Item {
                height: 40
                width: parent.width
            }

            Button {
                id: clearFields
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Clear fields"
                onClicked: {
                    cathetus_a.text = ""
                    cathetus_b.text = ""
                    hypotenuse_c.text = ""
                    angle_alpha.text = ""
                    angle_beta.text = ""
                }
                visible: {
                    if(cathetus_a.text != "" || cathetus_b.text != "" || hypotenuse_c.text != "" || angle_alpha.text || angle_beta.text != "")
                        return(true)
                    else
                        return(false)
                }
            }
        }
    }

    Page {
        id: triangleViewPage

        SilicaFlickable {
            anchors.fill: parent
            contentHeight: triangleColumn.height

            VerticalScrollDecorator {}

            Column {
                id: triangleColumn
                spacing: Theme.paddingSmall
                anchors {
                    left: parent.left
                    right: parent.right
                }

                PageHeader {
                    title: appName
                    description: "Triangle view"
                }

                Item {
                    width: parent.width
                    height: 400
                    visible: {
                        if(cathetus_a.text == "" || cathetus_b.text == "" || hypotenuse_c.text == "" || angle_alpha.text == "" || angle_beta.text == "")
                            return(true)
                        else
                            return(false)
                    }
                }

                InfoLabel {
                    text: "Triangle not specified!"
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: {
                        if(cathetus_a.text == "" || cathetus_b.text == "" || hypotenuse_c.text == "" || angle_alpha.text == "" || angle_beta.text == "")
                            return(true)
                        else
                            return(false)
                    }
                }

                Canvas {
                    id: triangleCanvas
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 450
                    height: 450
                    onPaint: {
                        var ctx = getContext("2d")
                        var a = acat()
                        var b = bcat()
                        var wRatio = bcat() / 450
                        var hRatio = acat() / 450
                        ctx.lineWidth = 1
                        ctx.strokeStyle = Theme.secondaryHighlightColor
                        ctx.fillStyle = Theme.secondaryHighlightColor
                        ctx.beginPath()
                        ctx.moveTo(0,0)
                        ctx.lineTo(0,a)
                        ctx.lineTo(b,a)
                        ctx.closePath()
                        ctx.fill()
                        ctx.stroke()
                    }
                    visible: {
                        if(cathetus_a.text == "" || cathetus_b.text == "" || hypotenuse_c.text == "" || angle_alpha.text == "" || angle_beta.text == "")
                            return(false)
                        else
                            return(true)
                    }

                    function resize() {
                        var height = triangleCanvas.height
                        var ratio = triangleCanvas.width / triangleCanvas.height
                        var width = height * ratio

                        triangleCanvas.width = width
                        triangleCanvas.height = height
                    }

                    function acat() {
                        var a = cathetus_a.text
                        return(Math.abs(a * 1))
                    }

                    function bcat() {
                        var b = cathetus_b.text
                        return(Math.abs(b * 1))
                    }
                }

                Button {
                    text: "Resize"
                    onClicked: triangleCanvas.resize()
                    visible: {
                        if(cathetus_a.text == "" || cathetus_b.text == "" || hypotenuse_c.text == "" || angle_alpha.text == "" || angle_beta.text == "")
                            return(false)
                        else
                            return(true)
                    }
                }

                Button {
                    text: "Flip"
                    visible: {
                        if(cathetus_a.text == "" || cathetus_b.text == "" || hypotenuse_c.text == "" || angle_alpha.text == "" || angle_beta.text == "")
                            return(false)
                        else
                            return(true)
                    }
                }

                Button {
                    text: "Mirror"
                    visible: {
                        if(cathetus_a.text == "" || cathetus_b.text == "" || hypotenuse_c.text == "" || angle_alpha.text == "" || angle_beta.text == "")
                            return(false)
                        else
                            return(true)
                    }
                }
            }
        }
    }
}
