import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: root
    onStatusChanged: {
    }

    property bool backStepping: true
    property int operationType: PageStackAction.Animated

    function switchOperationType() {
        operationType = (operationType === PageStackAction.Immediate ? PageStackAction.Animated : PageStackAction.Immediate)
    }

    Timer {
        id: timer
        interval: 10
        onTriggered: checkifallfieldsarefilled()
    }

    function checkifallfieldsarefilled() {
        if((cathetus_a.text != "" && cathetus_b.text != "") || (width_x.te != "" && height_y.text != "") && hypotenuse_c.text != "" && angle_alpha.text != "" && angle_beta.text != "")
            return(pageStack.pushAttached(triangleViewPage, operationType))
    }

    SilicaFlickable {
        id: page
        anchors.fill: parent
        contentHeight: {
            if(obliqueColumn.visible == true)
                return(obliqueColumn.height)
            else
                return(rightColumn.height)
        }
        contentWidth: parent.width

        PullDownMenu {

            MenuItem {
                text: "About..."
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            }
        }

        /*PushUpMenu {

            MenuItem {
                id: rightMenuItem
                text: "Right triangle solver"
                onClicked: {
                    rightMenuItem.visible = false
                    obliqueMenuItem.visible = true
                    rightColumn.visible = true
                    obliqueColumn.visible = false
                    rightView.visible = true
                    obliqueView.visible = false
                }
                visible: false
            }

            MenuItem {
                id: obliqueMenuItem
                text: "Oblique triangle solver"
                onClicked: {
                    obliqueMenuItem.visible = false
                    rightMenuItem.visible = true
                    obliqueColumn.visible = true
                    rightColumn.visible = false
                    obliqueView.visible = true
                    rightView.visible = false
                }
                visible: true
            }
        }*/

        Column {
            id: rightColumn
            spacing: Theme.paddingSmall
            anchors {
                left: parent.left
                right: parent.right
            }
            visible: true

            PageHeader {
                title: appName
                description: "Right triangle solver"
            }

            SectionHeader {
                text: "Sides"
            }

            TextSwitch {
                id: ratioSwitch
                text: "Solve with aspect ratio"
                onCheckedChanged: {
                    cathetus_a.text = ""
                    cathetus_b.text = ""
                    angle_alpha.text = ""
                    angle_beta.text = ""
                }
            }

            Row {
                id: ratioRow
                spacing: Theme.paddingSmall
                anchors.horizontalCenter: parent.horizontalCenter
                visible: {
                    if(ratioSwitch.checked == true)
                        return(true)
                    else
                        return(false)
                }

                TextField {
                    id: ratio_width
                    width: page.width / 2.07
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    label: "x (width)"
                    placeholderText: "Enter x (width)"
                    horizontalAlignment: TextInput.AlignRight
                    focusOutBehavior: FocusBehavior.KeepFocus
                    EnterKey.onClicked: {
                        parent.focus = true
                        timer.start()
                        rightCanvas.context.clearRect(0, 0, rightCanvas.width, rightCanvas.height)
                        rightCanvas.requestPaint()
                        if(hypotenuse_c.text != "" && ratio_width.text != "" && ratio_height.text != "")
                            return(cathetus_a.text = cathetus_a.right_a_sintanhwalphac(), cathetus_b.text = cathetus_b.right_b_sintanwhbetac(), angle_alpha.text = angle_alpha.right_tan_hw_alpha(), angle_beta.text = angle_beta.right_tan_wh_beta(), width_x.text = cathetus_b.right_b_sintanwhbetac(), height_y.text = cathetus_a.right_a_sintanhwalphac())
                        else if(hypotenuse_c.text == "" && ratio_width.text != "" && ratio_height.text != "")
                            return(angle_alpha.text = angle_alpha.right_tan_hw_alpha(), angle_beta.text = angle_beta.right_tan_wh_beta())
                    }
                }

                Label {
                    text: ":"
                }

                TextField {
                    id: ratio_height
                    width: page.width / 2.07
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    label: "y (height)"
                    placeholderText: "Enter y (height)"
                    focusOutBehavior: FocusBehavior.KeepFocus
                    EnterKey.onClicked: {
                        parent.focus = true
                        timer.start()
                        rightCanvas.context.clearRect(0, 0, rightCanvas.width, rightCanvas.height)
                        rightCanvas.requestPaint()
                        if(hypotenuse_c.text != "" && ratio_width.text != "" && ratio_height.text != "")
                            return(cathetus_a.text = cathetus_a.right_a_sintanhwalphac(), cathetus_b.text = cathetus_b.right_b_sintanwhbetac(), angle_alpha.text = angle_alpha.right_tan_hw_alpha(), angle_beta.text = angle_beta.right_tan_wh_beta(), width_x.text = cathetus_b.right_b_sintanwhbetac(), height_y.text = cathetus_a.right_a_sintanhwalphac())
                        else if(hypotenuse_c.text == "" && ratio_width.text != "" && ratio_height.text != "")
                            return(angle_alpha.text = angle_alpha.right_tan_hw_alpha(), angle_beta.text = angle_beta.right_tan_wh_beta())
                    }
                }
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
                    timer.start()
                    rightCanvas.context.clearRect(0, 0, rightCanvas.width, rightCanvas.height)
                    rightCanvas.requestPaint()
                    if(hypotenuse_c.text != "" && cathetus_a.text*1 >= hypotenuse_c.text*1)
                        return(cathetus_a.text = "")
                    else if(cathetus_a.text != "" && cathetus_b.text != "")
                        return(hypotenuse_c.text = hypotenuse_c.right_c(), angle_alpha.text = angle_alpha.right_tan_alpha(), angle_beta.text = angle_beta.right_tan_beta())
                    else if(cathetus_a.text != "" && hypotenuse_c.text != "")
                        return(cathetus_b.text = cathetus_b.right_b(), angle_alpha.text = angle_alpha.right_sin_alpha(), angle_beta.text = angle_beta.right_cos_beta())
                    else if(cathetus_a.text != "" && angle_alpha.text != "")
                        return(cathetus_b.text = cathetus_b.right_b_tanalpha(), hypotenuse_c.text = hypotenuse_c.right_c_sinalpha(), angle_beta.text = angle_beta.right_beta())
                    else if(cathetus_a.text != "" && angle_beta.text != "")
                        return(cathetus_b.text = cathetus_b.right_b_tanbeta(), hypotenuse_c.text = hypotenuse_c.right_c_cosbeta(), angle_alpha.text = angle_alpha.right_alpha())
                }
                visible: {
                    if(ratioSwitch.checked == true)
                        return(false)
                    else
                        return(true)
                }

                // a²+b²=c²->a=/c²-b²
                function right_a() {
                    var b = cathetus_b.text
                    var c = hypotenuse_c.text
                    return(Math.sqrt(Math.pow(c, 2) - Math.pow(b, 2))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_a_tanalpha() {
                    var b = cathetus_b.text
                    var alpha = angle_alpha.text
                    return(Math.abs(b * Math.tan(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_a_sinalpha() {
                    var c = hypotenuse_c.text
                    var alpha = angle_alpha.text
                    return(Math.abs(c * Math.sin(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_a_tanbeta() {
                    var b = cathetus_b.text
                    var beta = angle_beta.text
                    return(Math.abs(b / Math.tan(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_a_cosbeta() {
                    var c = hypotenuse_c.text
                    var beta = angle_beta.text
                    return(Math.abs(c * Math.cos(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_a_sintanhwalphac() {
                    var w = ratio_width.text
                    var h = ratio_height.text
                    var c = hypotenuse_c.text
                    return((Math.sin(Math.atan(h / w))) * c).toFixed(12).replace(/\.?0+$/, "")
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
                    timer.start()
                    rightCanvas.context.clearRect(0, 0, rightCanvas.width, rightCanvas.height)
                    rightCanvas.requestPaint()
                    if(hypotenuse_c.text != "" && cathetus_b.text*1 >= hypotenuse_c.text*1)
                        return(cathetus_b.text = "")
                    else if(cathetus_a.text != "" && cathetus_b.text != "")
                        return(hypotenuse_c.text = hypotenuse_c.right_c(), angle_alpha.text = angle_alpha.right_tan_alpha(), angle_beta.text = angle_beta.right_tan_beta())
                    else if(cathetus_b.text != "" && hypotenuse_c.text != "")
                        return(cathetus_a.text = cathetus_a.right_a(), angle_beta.text = angle_beta.right_sin_beta(), angle_alpha.text = angle_alpha.right_cos_alpha())
                    else if(cathetus_b.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_tanbeta(), hypotenuse_c.text = hypotenuse_c.right_c_sinbeta(), angle_alpha.text = angle_alpha.right_alpha())
                    else if(cathetus_b.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_tanalpha(), hypotenuse_c.text = hypotenuse_c.right_c_cosalpha(), angle_beta.text = angle_beta.right_beta())
                }
                visible: {
                    if(ratioSwitch.checked == true)
                        return(false)
                    else
                        return(true)
                }

                // a²+b²=c²->b=/c²-a²
                function right_b() {
                    var a = cathetus_a.text
                    var c = hypotenuse_c.text
                    return(Math.sqrt(Math.pow(c, 2) - Math.pow(a, 2))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_b_tanalpha() {
                    var a = cathetus_a.text
                    var alpha = angle_alpha.text
                    return(Math.abs(a / Math.tan(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_b_cosalpha() {
                    var c = hypotenuse_c.text
                    var alpha = angle_alpha.text
                    return(Math.abs(c * Math.cos(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_b_tanbeta() {
                    var a = cathetus_a.text
                    var beta = angle_beta.text
                    return(Math.abs(a * Math.tan(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_b_sinbeta() {
                    var c = hypotenuse_c.text
                    var beta = angle_beta.text
                    return(Math.abs(c * Math.sin(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_b_sintanwhbetac() {
                    var w = ratio_width.text
                    var h = ratio_height.text
                    var c = hypotenuse_c.text
                    return((Math.sin(Math.atan(w / h))) * c).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: hypotenuse_c
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: {
                    if(ratioSwitch.checked == true)
                        return("Diagonal length")
                    else
                        return("Length of hypotenuse c")
                }
                placeholderText: {
                    if(ratioSwitch.checked == true)
                        return("Enter diagonal length")
                    else
                        return("Enter length of hypotenuse c")
                }
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    timer.start()
                    rightCanvas.context.clearRect(0, 0, rightCanvas.width, rightCanvas.height)
                    rightCanvas.requestPaint()
                    if((cathetus_a.text != "" && hypotenuse_c.text*1 <= cathetus_a.text*1) || (cathetus_b.text != "" && hypotenuse_c.text*1 <= cathetus_b.text*1))
                        return(hypotenuse_c.text = "")
                    if(hypotenuse_c.text != "" && ratio_width.text != "" && ratio_height.text != "")
                        return(width_x.text = cathetus_b.right_b_sintanwhbetac(), height_y.text = cathetus_a.right_a_sintanhwalphac())
                    else if(cathetus_a.text != "" && hypotenuse_c.text != "")
                        return(cathetus_b.text = cathetus_b.right_b(), angle_alpha.text = angle_alpha.right_sin_alpha(), angle_beta.text = angle_beta.right_cos_beta())
                    else if(cathetus_b.text != "" && hypotenuse_c.text != "")
                        return(cathetus_a.text = cathetus_a.right_a(), angle_beta.text = angle_beta.right_sin_beta(), angle_alpha.text = angle_alpha.right_cos_alpha())
                    else if(hypotenuse_c.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_cosbeta(), cathetus_b.text = cathetus_b.right_b_sinbeta(), angle_alpha.text = angle_alpha.right_alpha())
                    else if(hypotenuse_c.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_sinalpha(), cathetus_b.text = cathetus_b.right_b_cosalpha(), angle_beta.text = angle_beta.right_beta())
                }

                // a²+b²=c²->c=/a²+b²
                function right_c() {
                    var a = cathetus_a.text
                    var b = cathetus_b.text
                    return(Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_c_sinalpha() {
                    var a = cathetus_a.text
                    var alpha = angle_alpha.text
                    return(Math.abs(a / Math.sin(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_c_cosalpha() {
                    var b = cathetus_b.text
                    var alpha = angle_alpha.text
                    return(Math.abs(b / Math.cos(alpha * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_c_sinbeta() {
                    var b = cathetus_b.text
                    var beta = angle_beta.text
                    return(Math.abs(b / Math.sin(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_c_cosbeta() {
                    var a = cathetus_a.text
                    var beta = angle_beta.text
                    return(Math.abs(a / Math.cos(beta * (Math.PI / 180)))).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: width_x
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of x (width)"
                placeholderText: "Length of x (width)"
                focusOutBehavior: FocusBehavior.KeepFocus
                readOnly: true
                visible: {
                    if(ratioSwitch.checked == true)
                        return(true)
                    else
                        return(false)
                }
            }

            TextField {
                id: height_y
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of y (height)"
                placeholderText: "Length of y (height)"
                focusOutBehavior: FocusBehavior.KeepFocus
                readOnly: true
                visible: {
                    if(ratioSwitch.checked == true)
                        return(true)
                    else
                        return(false)
                }
            }

            SectionHeader {
                text: "Angles"
            }

            TextField {
                id: angle_alpha
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: {
                    if(ratioSwitch.checked == true)
                        return("Angle α (y's opposite)")
                    else
                        return("Angle α (a's opposite)")
                }
                placeholderText: {
                    if(ratioSwitch.checked == true)
                        return("Angle α (y's opposite)")
                    else
                        return("Enter angle α (a's opposite)")
                }
                focusOutBehavior: FocusBehavior.KeepFocus
                readOnly: {
                    if(ratioSwitch.checked == true)
                        return(true)
                    else
                        return(false)
                }
                EnterKey.onClicked: {
                    parent.focus = true
                    timer.start()
                    rightCanvas.context.clearRect(0, 0, rightCanvas.width, rightCanvas.height)
                    rightCanvas.requestPaint()
                    if(angle_alpha.text*1 <= 0 || angle_alpha.text*1 >= 90)
                        return(angle_alpha.text = "")
                    if(angle_alpha.text != "" && cathetus_a.text == "" && cathetus_b.text == "" && hypotenuse_c.text == "")
                        return(angle_beta.text = angle_beta.right_beta())
                    else if(cathetus_b.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_tanalpha(), hypotenuse_c.text = hypotenuse_c.right_c_cosalpha(), angle_beta.text = angle_beta.right_beta())
                    else if(hypotenuse_c.text != "" && angle_alpha.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_sinalpha(), cathetus_b.text = cathetus_b.right_b_cosalpha(), angle_beta.text = angle_beta.right_beta())
                    else if(cathetus_a.text != "" && angle_alpha.text != "")
                        return(cathetus_b.text = cathetus_b.right_b_tanalpha(), hypotenuse_c.text = hypotenuse_c.right_c_sinalpha(), angle_beta.text = angle_beta.right_beta())
                }

                function right_alpha() {
                    var beta = angle_beta.text
                    return(Math.abs(90 - beta)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_tan_alpha() {
                    var a = cathetus_a.text
                    var b = cathetus_b.text
                    return(Math.atan(a / b) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_sin_alpha() {
                    var a = cathetus_a.text
                    var c = hypotenuse_c.text
                    return(Math.asin(a / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_cos_alpha() {
                    var b = cathetus_b.text
                    var c = hypotenuse_c.text
                    return(Math.acos(b / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_tan_hw_alpha() {
                    var w = ratio_width.text
                    var h = ratio_height.text
                    return(Math.atan(h / w) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: angle_beta
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: {
                    if(ratioSwitch.checked == true)
                        return("Angle β (x's opposite)")
                    else
                        return("Angle β (b's opposite)")
                }
                placeholderText: {
                    if(ratioSwitch.checked == true)
                        return("Angle β (x's opposite)")
                    else
                        return("Enter angle β (b's opposite)")
                }
                focusOutBehavior: FocusBehavior.KeepFocus
                readOnly: {
                    if(ratioSwitch.checked == true)
                        return(true)
                    else
                        return(false)
                }
                EnterKey.onClicked: {
                    parent.focus = true
                    timer.start()
                    rightCanvas.context.clearRect(0, 0, rightCanvas.width, rightCanvas.height)
                    rightCanvas.requestPaint()
                    if(angle_beta.text*1 <= 0 || angle_beta.text*1 >= 90)
                        return(angle_beta.text = "")
                    if(angle_beta.text != "" && cathetus_a.text == "" && cathetus_b.text == "" && hypotenuse_c.text == "")
                        return(angle_alpha.text = angle_alpha.alpha())
                    else if(cathetus_b.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_tanbeta(), hypotenuse_c.text = hypotenuse_c.right_c_sinbeta(), angle_alpha.text = angle_alpha.right_alpha())
                    else if(hypotenuse_c.text != "" && angle_beta.text != "")
                        return(cathetus_a.text = cathetus_a.right_a_cosbeta(), cathetus_b.text = cathetus_b.right_b_sinbeta(), angle_alpha.text = angle_alpha.right_alpha())
                    else if(cathetus_a.text != "" && angle_beta.text != "")
                        return(cathetus_b.text = cathetus_b.right_b_tanbeta(), hypotenuse_c.text = hypotenuse_c.right_c_cosbeta(), angle_alpha.text = angle_alpha.right_alpha())
                }

                function right_beta() {
                    var alpha = angle_alpha.text
                    return(Math.abs(90 - alpha)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_tan_beta() {
                    var b = cathetus_b.text
                    var a = cathetus_a.text
                    return(Math.atan(b / a) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_sin_beta() {
                    var b = cathetus_b.text
                    var c = hypotenuse_c.text
                    return(Math.asin(b / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_cos_beta() {
                    var a = cathetus_a.text
                    var c = hypotenuse_c.text
                    return(Math.acos(a / c) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }

                function right_tan_wh_beta() {
                    var w = ratio_width.text
                    var h = ratio_height.text
                    return(Math.atan(w / h) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            Item {
                height: 40
                width: parent.width
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Clear fields"
                onClicked: {
                    cathetus_a.text = ""
                    cathetus_b.text = ""
                    ratio_width.text = ""
                    ratio_height.text = ""
                    hypotenuse_c.text = ""
                    width_x.text = ""
                    height_y.text = ""
                    angle_alpha.text = ""
                    angle_beta.text = ""
                    pageStack.popAttached(undefined, operationType)
                }
                visible: {
                    if(cathetus_a.text != "" || cathetus_b.text != "" || ratio_width.text != "" || ratio_height.text != "" || hypotenuse_c.text != "" || angle_alpha.text || angle_beta.text != "")
                        return(true)
                    else
                        return(false)
                }
            }

            Item {
                height: 40
                width: parent.width
            }
        }

        Column {
            id: obliqueColumn
            spacing: Theme.paddingSmall
            anchors {
                left: parent.left
                right: parent.right
            }
            visible: false

            PageHeader {
                title: appName
                description: "Oblique triangle solver"
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Clear fields"
                onClicked: {
                    side_a.text = ""
                    side_b.text = ""
                    side_c.text = ""
                    oblique_angle_alpha.text = ""
                    oblique_angle_beta.text = ""
                    oblique_angle_gamma.text = ""
                }
                visible: {
                    if(side_a.text != "" || side_b.text != "" || side_c.text != "" || oblique_angle_alpha.text || oblique_angle_beta.text != "" || oblique_angle_gamma.text != "")
                        return(true)
                    else
                        return(false)
                }
            }

            SectionHeader {
                text: "Sides"
            }

            TextField {
                id: side_a
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of side a"
                placeholderText: "Enter length of side a"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    if(side_a.text != "" && side_b.text != "" && side_c.text != "")
                        return(oblique_angle_alpha.text = oblique_angle_alpha.oblique_alpha_abc(), oblique_angle_beta.text = oblique_angle_beta.oblique_beta_abc(), oblique_angle_gamma.text = oblique_angle_gamma.oblique_gamma_abc())
                }

                function oblique_a_bcalpha() {
                    var b = side_b.text
                    var c = side_c.text
                    var alpha = oblique_angle_alpha.text
                }

                function oblique_a_bcbeta() {
                    var b = side_b.text
                    var c = side_c.text
                    var beta = oblique_angle_beta.text
                }

                function oblique_a_bcgamma() {
                    var b = side_b.text
                    var c = side_c.text
                    var gamma = oblique_angle_gamma.text
                }
            }

            TextField {
                id: side_b
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of side b"
                placeholderText: "Enter length of side b"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    if(side_a.text != "" && side_b.text != "" && side_c.text != "")
                        return(oblique_angle_alpha.text = oblique_angle_alpha.oblique_alpha_abc(), oblique_angle_beta.text = oblique_angle_beta.oblique_beta_abc(), oblique_angle_gamma.text = oblique_angle_gamma.oblique_gamma_abc())
                }

                function oblique_b_acalpha() {
                    var a = side_a.text
                    var c = side_c.text
                    var alpha = oblique_angle_alpha.text
                }

                function oblique_b_acbeta() {
                    var a = side_a.text
                    var c = side_c.text
                    var beta = oblique_angle_beta.text
                }

                function oblique_b_acgamma() {
                    var a = side_a.text
                    var c = side_c.text
                    var gamma = oblique_angle_gamma.text
                }
            }

            TextField {
                id: side_c
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Length of side c"
                placeholderText: "Enter length of side c"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    if(side_a.text != "" && side_b.text != "" && side_c.text != "")
                        return(oblique_angle_alpha.text = oblique_angle_alpha.oblique_alpha_abc(), oblique_angle_beta.text = oblique_angle_beta.oblique_beta_abc(), oblique_angle_gamma.text = oblique_angle_gamma.oblique_gamma_abc())
                }

                function oblique_c_abalpha() {
                    var a = side_a.text
                    var c = side_c.text
                    var alpha = oblique_angle_alpha.text
                }

                function oblique_c_abbeta() {
                    var a = side_a.text
                    var c = side_c.text
                    var beta = oblique_angle_beta.text
                }

                function oblique_c_abgamma() {
                    var a = side_a.text
                    var c = side_c.text
                    var gamma = oblique_angle_gamma.text
                }
            }

            SectionHeader {
                text: "Angles"
            }

            TextField {
                id: oblique_angle_alpha
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Angle α (a's opposite)"
                placeholderText: "Enter angle α (a's opposite)"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    if(oblique_angle_alpha.text != "" && oblique_angle_beta.text != "")
                        return(oblique_angle_gamma.text = oblique_angle_gamma.oblique_gamma())
                    if(oblique_angle_alpha.text != "" && oblique_angle_gamma.text != "")
                        return(oblique_angle_beta.text = oblique_angle_beta.oblique_beta())
                }

                function oblique_alpha() {
                    var beta = oblique_angle_beta.text
                    var gamma = oblique_angle_gamma.text
                    return(Math.abs(180 - beta - gamma)).toFixed(12).replace(/\.?0+$/, "")
                }

                function oblique_alpha_abc() {
                    var a = side_a.text
                    var b = side_b.text
                    var c = side_c.text
                    return(Math.acos((b*b + c*c - a*a) / (2 * b * c)) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: oblique_angle_beta
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Angle β (b's opposite)"
                placeholderText: "Enter angle β (b's opposite)"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    if(oblique_angle_alpha.text != "" && oblique_angle_beta.text != "")
                        return(oblique_angle_gamma.text = oblique_angle_gamma.oblique_gamma())
                    if(oblique_angle_beta.text != "" && oblique_angle_gamma.text != "")
                        return(oblique_angle_alpha.text = oblique_angle_alpha.oblique_alpha())
                }

                function oblique_beta() {
                    var alpha = oblique_angle_alpha.text
                    var gamma = oblique_angle_gamma.text
                    return(Math.abs(180 - alpha - gamma)).toFixed(12).replace(/\.?0+$/, "")
                }

                function oblique_beta_abc() {
                    var a = side_a.text
                    var b = side_b.text
                    var c = side_c.text
                    return(Math.acos((a*a + c*c - b*b) / (2 * a * c)) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            TextField {
                id: oblique_angle_gamma
                width: parent.width
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                label: "Angle γ (c's opposite)"
                placeholderText: "Enter angle γ (c's opposite)"
                focusOutBehavior: FocusBehavior.KeepFocus
                EnterKey.onClicked: {
                    parent.focus = true
                    if(oblique_angle_alpha.text != "" && oblique_angle_gamma.text != "")
                        return(oblique_angle_beta.text = oblique_angle_beta.oblique_beta())
                    if(oblique_angle_beta.text != "" && oblique_angle_gamma.text != "")
                        return(oblique_angle_alpha.text = oblique_angle_alpha.oblique_alpha())
                }

                function oblique_gamma() {
                    var alpha = oblique_angle_alpha.text
                    var beta = oblique_angle_beta.text
                    return(Math.abs(180 - alpha - beta)).toFixed(12).replace(/\.?0+$/, "")
                }

                function oblique_gamma_abc() {
                    var a = side_a.text
                    var b = side_b.text
                    var c = side_c.text
                    return(Math.acos((a*a + b*b - c*c) / (2 * a * b)) * (180 / Math.PI)).toFixed(12).replace(/\.?0+$/, "")
                }
            }

            Item {
                height: 40
                width: parent.width
            }
        }
    }

    Page {
        id: triangleViewPage

        SilicaFlickable {
            anchors.fill: parent
            contentHeight: parent.height
            contentWidth: parent.width

            Column {
                id: rightView
                spacing: Theme.paddingSmall
                anchors {
                    left: parent.left
                    right: parent.right
                }
                visible: true

                PageHeader {
                    title: appName
                    description: "Triangle view"
                }

                Canvas {
                    id: rightCanvas
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 400
                    height: 400
                    onPaint: {
                        var ctx = getContext("2d")
                        var alpha = alpha_angle()
                        var beta = beta_angle()
                        var r = 400
                        ctx.lineWidth = 1
                        ctx.strokeStyle = Theme.secondaryHighlightColor
                        ctx.fillStyle = Theme.secondaryHighlightColor
                        ctx.beginPath()
                        ctx.moveTo(0,0)
                        ctx.lineTo(0 + r * Math.cos(alpha),0 + r * Math.cos(beta))
                        ctx.lineTo(0,0 + r * Math.cos(beta))
                        ctx.closePath()
                        ctx.fill()
                        ctx.stroke()
                    }

                    function alpha_angle() {
                        var alpha = angle_alpha.text
                        return(Math.abs(Math.PI * alpha / 180))
                    }

                    function beta_angle() {
                        var beta = angle_beta.text
                        return(Math.abs(Math.PI * beta / 180))
                    }
                }

                Text {
                    font.pointSize: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: Theme.highlightColor
                    text: "Area A = " + area()

                    function area() {
                        var a = cathetus_a.text || height_y.text
                        var b = cathetus_b.text || width_x.text
                        return(Math.abs(a * b / 2).toFixed(12).replace(/\.?0+$/, ""))
                    }
                }

                /*Button {
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
                }*/
            }

            Column {
                id: obliqueView
                spacing: Theme.paddingSmall
                anchors {
                    left: parent.left
                    right: parent.right
                }
                visible: false

                PageHeader {
                    title: appName
                    description: "Triangle view"
                }

                InfoLabel {
                    text: "Triangle not specified!"
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: {
                        if(side_a.text == "" || side_b.text == "" || side_c.text == "" || oblique_angle_alpha.text == "" || oblique_angle_beta.text == "" || oblique_angle_gamma == "")
                            return(true)
                        else
                            return(false)
                    }
                }

                Canvas {
                    id: obliqueCanvas
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 400
                    height: 400
                    onPaint: {
                        var ctx = getContext("2d")
                        var alpha = alpha_angle()
                        var beta = beta_angle()
                        var r = 400
                        ctx.lineWidth = 1
                        ctx.strokeStyle = Theme.secondaryHighlightColor
                        ctx.fillStyle = Theme.secondaryHighlightColor
                        ctx.beginPath()
                        ctx.moveTo(0,0)
                        ctx.lineTo(0 + r * Math.cos(alpha),0 + r * Math.cos(beta))
                        ctx.lineTo(0,0 + r * Math.cos(beta))
                        ctx.closePath()
                        ctx.fill()
                        ctx.stroke()
                    }
                    visible: {
                        if(side_a.text == "" || side_b.text == "" || side_c.text == "" || oblique_angle_alpha.text == "" || oblique_angle_beta.text == "" || oblique_angle_gamma == "")
                            return(false)
                        else
                            return(true)
                    }

                    function alpha_angle() {
                        var alpha = angle_alpha.text
                        return(Math.abs(Math.PI * alpha / 180))
                    }

                    function beta_angle() {
                        var beta = angle_beta.text
                        return(Math.abs(Math.PI * beta / 180))
                    }
                }

                Text {
                    font.pointSize: 25
                    color: Theme.highlightColor
                    text: "Area A = " + area()
                    visible: {
                        if(side_a.text == "" || side_b.text == "" || side_c.text == "" || oblique_angle_alpha.text == "" || oblique_angle_beta.text == "" || oblique_angle_gamma == "")
                            return(false)
                        else
                            return(true)
                    }

                    function area() {
                        var a = side_a.text
                        var b = side_b.text
                        return(Math.abs(a * b / 2).toFixed(12).replace(/\.?0+$/, ""))
                    }
                }
            }
        }
    }
}
