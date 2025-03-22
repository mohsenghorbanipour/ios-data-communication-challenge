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
            listener = try NWListener(using: params, on: 12345) // Listening on port 12345
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
//        connection?.send(content: data, completion: .contentProcessed { error in
//            if let error = error {
//                result(FlutterError(code: "TCP_ERROR", message: "Failed to send data", details: error.localizedDescription))
//            } else {
//                result(mockData) // Send data back to Flutter
//            }
//        })
    }
}
