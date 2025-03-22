
# 🚀 iOS Data Communication Layer with Flutter & Swift (TCP over USB Simulation)

## 📱 Overview
This project is a prototype that simulates a USB-C data reception system in iOS and integrates it with a Flutter app via platform channels. It includes:

- A **TCP server written in Swift**, acting as a mocked USB-C data layer.
- A **modular Flutter app architecture**, using `MethodChannel` to communicate with the native iOS module.

---

## 📦 Project Structure (Flutter)

```
lib/
├── core/                # Core shared utilities
│   ├── resources/       # App-wide assets, constants
│   ├── router/          # Navigation and route configuration
│   ├── services/        # Backend and platform services
│   └── theme/           # App theming and styling
├── modules/
│   └── main/            # Main module of the app
│       ├── page/        # UI pages/screens
│       ├── provider/    # State management (e.g., Provider)
│       └── widgets/     # Reusable widgets
├── splash/              # Splash screen module
├── app.dart             # App-level widget and config
└── main.dart            # Entry point
```

### 📡 Flutter Responsibilities

- Uses `MethodChannel` to send messages to native iOS code.
- Handles responses and updates UI using Provider and reactive widgets.
- Contains modular structure to keep the app scalable and maintainable.

---

## 🍎 iOS TCP Server (Swift) – Simulated USB-C Data Layer

### ✅ TCPServer.swift

This Swift class simulates a USB-C device over TCP/IP by setting up a TCP server on port **12345** and generating mock data.

```swift
import Foundation
import Network

@objc(TCPServer)
class TCPServer: NSObject {
    
    private var listener: NWListener?
    private var connection: NWConnection?
    
    override init() {
        super.init()
        startServer()
    }

    private func startServer() {
        do {
            let params = NWParameters.tcp
            listener = try NWListener(using: params, on: 12345)
            listener?.newConnectionHandler = { [weak self] newConnection in
                self?.connection = newConnection
                self?.receiveData()
                newConnection.start(queue: .global())
            }
            listener?.start(queue: .global())
            print("TCP Server started on port 12345")
        } catch {
            print("Failed to start TCP server: \(error)")
        }
    }

    private func receiveData() {
        connection?.receive(minimumIncompleteLength: 1, maximumLength: 1024) { (data, _, _, error) in
            if let data = data, let message = String(data: data, encoding: .utf8) {
                print("Received Data: \(message)")
            }
            if error == nil {
                self.receiveData()
            }
        }
    }

    @objc func sendMockData(_ result: @escaping FlutterResult) {
        let mockData = "Mock USB Data: \(Int.random(in: 1...100))"
        let data = mockData.data(using: .utf8)
        result(mockData)
    }
}
```

---

### ✅ AppDelegate.swift

Registers the Swift TCP server with a Flutter `MethodChannel`:

```swift
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let tcpChannel = FlutterMethodChannel(name: "tcp_simulator",
                                          binaryMessenger: controller.binaryMessenger)
      
    let tcpServer = TCPServer()
    
    tcpChannel.setMethodCallHandler { (call, result) in
        if call.method == "sendMockData" {
            tcpServer.sendMockData(result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## 🔗 Communication Flow

```
Flutter UI (Dart)
   ↓ invokeMethod("sendMockData")
MethodChannel: "tcp_simulator"
   ↓
Swift TCPServer (iOS)
   ↓
Returns mock or real TCP data to Flutter
```

---

## 🧪 How to Test

1. Run the Flutter app on an iOS device or simulator.
2. On button tap or screen load (depending on your UI), the Flutter app invokes the native method `"sendMockData"`.
3. The Swift TCP server responds with a simulated data string.
4. The data is rendered in the Flutter UI.

---

## 🚀 Optional Bonus Achieved

This project completes the optional bonus challenge by:

- Implementing a **mock USB-C data receiver** using a **TCP server over port 12345**.
- Creating a seamless bridge between native iOS and Flutter using `MethodChannel`.

---

## 📌 Notes

- For future enhancements, consider enabling full duplex communication.
- Secure the TCP channel if exposed beyond the simulator.
- You can easily hook this into a real external data source in the future by replacing `sendMockData()`.
