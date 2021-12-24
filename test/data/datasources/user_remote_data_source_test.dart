import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/data/datasources/user_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'user_remote_data_source_test.mocks.dart';

@GenerateMocks([DioAdapter])
void main() {
  late UserRemoteDataSourceImpl dataSourceImpl;
  late Dio dio;
  late MockDioAdapter adapter;

  setUp(() {
    dio = Dio();
    adapter = MockDioAdapter();
    dio.httpClientAdapter = adapter;
    dataSourceImpl = UserRemoteDataSourceImpl(dio);
  });

  void setUpMockHttpRequestSuccess200() {
    final String responsePayload = fixture('users.json');
    final ResponseBody responseBody =
        ResponseBody.fromString(responsePayload, 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    });

    when(adapter.fetch(any, any, any)).thenAnswer((_) async => responseBody);
  }

  void setUpMockHttpRequestFailure404() {
    final ResponseBody responseBody =
        ResponseBody.fromString('Something went wrong', 404);

    when(adapter.fetch(any, any, any)).thenAnswer((_) async => responseBody);
  }

  group('getUsers', () {
    const int tCount = 10;
    final List<dynamic> json =
        jsonDecode(fixture('users.json')) as List<dynamic>;
    final List<UserModel> tUserModels = json
        .map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();

    test('should return List<User> when the response code is 200 (success)',
        () async {
      setUpMockHttpRequestSuccess200();
      // final Response<dynamic> response = await dio.get<dynamic>('/route');
      final List<UserModel> result = await dataSourceImpl.getUsers(tCount);
      expect(result, equals(tUserModels));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpRequestFailure404();
      final Future<List<UserModel>> Function(int count) call =
          dataSourceImpl.getUsers;
      expect(() => call(tCount), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomUsers', () {
    final List<dynamic> json =
        jsonDecode(fixture('users.json')) as List<dynamic>;
    final List<UserModel> tUserModels = json
        .map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();

    test('should return List<User> when the response code is 200 (success)',
        () async {
      setUpMockHttpRequestSuccess200();
      // final Response<dynamic> response = await dio.get<dynamic>('/route');
      final List<UserModel> result = await dataSourceImpl.getRandomUsers();
      expect(result, equals(tUserModels));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpRequestFailure404();
      final Future<List<UserModel>> Function() call =
          dataSourceImpl.getRandomUsers;
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
