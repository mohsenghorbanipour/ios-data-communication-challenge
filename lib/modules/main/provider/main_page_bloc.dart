import 'package:flutter/foundation.dart';
import 'package:zanis/core/services/tcp_service.dart';

class MainPageBloc extends ChangeNotifier {
  String? tcpDate;

  Future<void> loadDateFromTcpConnection() async {
    try {
      String? data = await TcpService.getDataFromTCPConnection();
      if (data?.isNotEmpty ?? false) {
        tcpDate = data ?? '';
      } else {
        //TODO SHOW ERROR
      }
      notifyListeners();
    } catch (e, s) {
      print(e.toString());
    }
  }
}
