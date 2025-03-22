import 'package:flutter/services.dart';

class TcpService {

  static const MethodChannel _tcpChanne = MethodChannel(
    'tcp_server'
  );

  static Future<String?> getDataFromTCPConnection() async {
    try {
      String data = await _tcpChanne.invokeMethod('sendMockData');
      return data;
    } catch(e, s) {
      print(e);
      return null;
    }
  }
}