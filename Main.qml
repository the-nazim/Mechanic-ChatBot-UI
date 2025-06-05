import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: qsTr("SDV Support Bot")

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Top bar
        Frame {
            Layout.fillWidth: true
            height: 50
            padding: 12
            background: Rectangle {
                color: "#2E86C1"
            }
            Label {
                text: "Support"
                font.pointSize: 18
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Message list
        ListView {
            id: messageList
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 4
            clip: true

            model: ListModel {
                ListElement { sender: "You"; message: "Hello!" }
                ListElement { sender: "Mechanic"; message: "Hi! How can I assist you?" }
            }

            delegate: Frame {
                width: parent.width
                padding: 8
                background: Rectangle {
                    color: index % 2 === 0 ? "#F4F6F7" : "#D6EAF8"
                    radius: 4
                }

                Label {
                    text: sender + ": " + message
                    wrapMode: Text.Wrap
                }
            }
        }

        // Input and Send
        Frame {
            Layout.fillWidth: true
            padding: 8

            RowLayout {
                spacing: 6
                anchors.fill: parent

                TextField {
                    id: inputField
                    Layout.fillWidth: true
                    placeholderText: "Type a message..."
                    onAccepted: sendMessage()
                }

                Button {
                    text: "Send"
                    onClicked: sendMessage()
                }
            }
        }
    }

    function sendMessage() {
        const trimmed = inputField.text.trim();
            if (trimmed.length > 0) {
                // Append user message to chat
                messageList.model.append({
                    sender: "You",
                    message: trimmed
                });

                // Clear the input
                inputField.text = "";

                // Send to Rasa backend
                var xhr = new XMLHttpRequest();
                var rasaEndpoint = "http://localhost:5005/webhooks/rest/webhook";  // ← Update with your Rasa endpoint

                xhr.open("POST", rasaEndpoint);
                xhr.setRequestHeader("Content-Type", "application/json");

                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var response = JSON.parse(xhr.responseText);
                            if (response.length > 0) {
                                for (var i = 0; i < response.length; i++) {
                                    if (response[i].text) {
                                        messageList.model.append({
                                            sender: "Mechanic",
                                            message: response[i].text
                                        });
                                    }
                                }
                            } else {
                                messageList.model.append({
                                    sender: "Mechanic",
                                    message: "No response from Rasa."
                                });
                            }
                        } else {
                            console.log("Error contacting Rasa:", xhr.statusText);
                            messageList.model.append({
                                sender: "Mechanic",
                                message: "Error contacting Mechanic."
                            });
                        }
                    }
                };

                var payload = JSON.stringify({
                    sender: "user",
                    message: trimmed
                });
                xhr.send(payload);
            }
        }
}
