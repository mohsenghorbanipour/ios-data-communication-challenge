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
    let tcpChannel = FlutterMethodChannel(name: "tcp_server",
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
