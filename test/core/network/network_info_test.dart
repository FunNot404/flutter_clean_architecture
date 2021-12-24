import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late MockConnectivity _connectivity;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    _connectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(_connectivity);
  });

  group('isConnected', () {
    test('should forward the call to ConnectivityResult.mobile', () async {
      when(_connectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.mobile);
      final bool result = await networkInfoImpl.isConnected;
      verify(_connectivity.checkConnectivity());
      expect(result, isTrue);
    });

    test('should forward the call to ConnectivityResult.ethernet', () async {
      when(_connectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.ethernet);
      final bool result = await networkInfoImpl.isConnected;
      verify(_connectivity.checkConnectivity());
      expect(result, isTrue);
    });

    test('should forward the call to ConnectivityResult.wifi', () async {
      when(_connectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);
      final bool result = await networkInfoImpl.isConnected;
      verify(_connectivity.checkConnectivity());
      expect(result, isTrue);
    });
  });
}
