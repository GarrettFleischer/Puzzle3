import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    id: root
    visible: true
    width: Screen.width * 0.8
    height: Screen.height * 0.8
    title: qsTr("Magic 8 ball")

    Rectangle
    {
        id: big_wrapper
        anchors.fill: parent

        Text
        {
            id: txt_question
            text: Cursed_8_ball.get_question();
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 24
            font.family: "BELLABOO"
            color: "purple"
            anchors.bottomMargin: 20
        }

        TextInput
        {
            id: txtin_input
            anchors.topMargin: 20
            anchors.bottom: rect_outer_ball.top
            anchors.horizontalCenter: big_wrapper.horizontalCenter
            focus: spg_animation_y.running ? false : true
            visible: (spg_animation_y.running || ma_mouse_area.enabled) ? false : true
            text: "Enter question here..."
            font.pointSize: 24
            height: 50
            width: 50
            color: "orange"

            Keys.onReturnPressed:
            {
                Cursed_8_ball.set_question(text);
                Cursed_8_ball.set_draggable(true);
                ma_mouse_area.enabled = true;
                txt_question.text = Cursed_8_ball.get_question();
            }
        }

        Rectangle
        {
            id: rect_outer_ball
            height: 300
            width: 300

            x: parent.width/2 - width/2;
            y: parent.height/2 - height/2;
            border.color: "white"
            color: "black"
            radius: width/2;

            Behavior on x
            {
                SpringAnimation
                {
                    id: spg_animation_x
                    spring: 4.0
                    damping: .5
                    epsilon: 0.5
                    mass: 10
                }
            }

            Behavior on y
            {
                SpringAnimation
                {
                    id: spg_animation_y
                    spring: 4.0
                    damping: .5
                    epsilon: 0.5
                    mass: 10
                }
            }

            Rectangle
            {
                id: rect_inner_ball
                height: parent.height * .60
                width: parent.width * .60
                anchors.horizontalCenter: rect_outer_ball.horizontalCenter;
                border.color: "purple"
                color: "white"
                radius: width/2;

                Rectangle
                {
                    id: rect_wave_wrapper
                    height: parent.height + border.width
                    width: parent.width + border.width
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    border.color: "black"
                    border.width: 35
                    radius: width/2
                    z: 2
                }

                AnimatedImage
                {
                    id: gif_waves
                    source: "../img/waves.gif"
                    height: parent.height - rect_wave_wrapper.border.width
                    width: parent.width - rect_wave_wrapper.border.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    visible: (spg_animation_y.running || ma_mouse_area.enabled) ? true : false
                }

                Text
                {
                    id: txt_saying
                    //anchors.fill: parent
                    wrapMode: Text.Wrap
                    font.family: "BELLABOO"
                    font.pointSize: 24
                    anchors.centerIn: parent

                    text: (spg_animation_y.running || ma_mouse_area.enabled) ? "" : Cursed_8_ball.get_saying()
                }
            }

            MouseArea
            {
                id: ma_mouse_area
                anchors.fill: rect_outer_ball
                enabled: Cursed_8_ball.get_is_draggable();
                drag.target: rect_outer_ball

                onReleased:
                {
                    if(Cursed_8_ball.get_is_draggable())
                    {
                        Cursed_8_ball.set_draggable(false);
                        ma_mouse_area.enabled = false;
                        rect_outer_ball.x = big_wrapper.width/2 - rect_outer_ball.width/2;
                        rect_outer_ball.y = big_wrapper.height/2 - rect_outer_ball.height/2;
                    }
                }



            }
        }

    }


}
