import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zanis/modules/main/provider/main_page_bloc.dart';
import 'package:zanis/core/services/tcp_service.dart';

void main() {
  const MethodChannel channel = MethodChannel('tcp_simulator');
  late MainPageBloc bloc;

  TestWidgetsFlutterBinding.ensureInitialized();

  group('MainPageBloc TCP Tests', () {
    const String mockTCPResponse = 'Mock USB Data: 99';

    setUp(() {
      bloc = MainPageBloc();

      // Set up the mock method channel handler
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'sendMockData') {
          return mockTCPResponse;
        }
        throw PlatformException(code: '404', message: 'Method not found');
      });
    });

    tearDown(() {
      channel.setMockMethodCallHandler(null);
    });

    test('loads TCP data and sets tcpDate', () async {
      expect(bloc.tcpDate, isNull);

      await bloc.loadDateFromTcpConnection();

      expect(bloc.tcpDate, equals(mockTCPResponse));
    });

    test('handles empty TCP response', () async {
      channel.setMockMethodCallHandler((_) async => '');

      await bloc.loadDateFromTcpConnection();

      expect(bloc.tcpDate, isNull); // it won't update due to empty check
    });

    test('handles exception gracefully', () async {
      channel.setMockMethodCallHandler((_) async {
        throw PlatformException(code: '500', message: 'Something went wrong');
      });

      await bloc.loadDateFromTcpConnection();

      expect(bloc.tcpDate, isNull); // stays null on exception
    });
  });
}
