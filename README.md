# Qt QML Chat UI with Rasa Integration

A simple chat user interface built using **Qt 6.5** and **QML**, integrated with a Rasa backend for natural language processing.

## 📸 Preview

> Minimalist chat layout with user input, message history, and dynamic bot response display.

## 🛠️ Features

- UI built using **Qt 6.5 Controls and Layouts**
- User message input with `TextField` and `Send` button
- Message display using `ListView`
- Integrated with a **Rasa chatbot** using `XMLHttpRequest` (REST API)
- Supports both keyboard (Enter) and mouse click for sending messages
- Lightweight and easily extendable

## 📁 Project Structure
```
ChatApp/
├── ChatUI.qml # Main QML file
├── main.cpp # (Optional) Qt main C++ file if using QtQuickApplication
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- [Qt 6.5 or later](https://www.qt.io/download)
- A running instance of Rasa with REST endpoint:
  ```
  rasa run --enable-api
  ```
  
## ✉️ API Endpoint
Update the following line in ChatUI.qml if your Rasa server is remote or hosted differently:
  ```
  var rasaEndpoint = "http://localhost:5005/webhooks/rest/webhook";
  ```

## 🔧 Customization Ideas
Customize color themes and message alignment

Add bot typing indicators

Handle image or button-type messages from Rasa

Add support for audio input/output

## 📌 Example Rasa Payload Sent
```
{
  "sender": "user",
  "message": "Hello"
}
```

## 🧠 Technologies Used
Qt 6.5 (QML + QtQuick.Controls)

Rasa (REST Webhook integration)

JavaScript for API communication

## 📃 License
MIT License – free to use and modify.

## 🙋‍♂️ Support or Questions?
Feel free to open an issue or message the developer if you need help customizing the application.
Let me know if you want to bundle this with a [starter Qt project file](f) or [auto-run Rasa instructions](f).
