import 'dart:convert';

import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/data/datasources/user_local_data_source.dart';
import 'package:flutter_clean_architecture/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';
import 'user_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late UserLocalDataSourceImpl dataSourceImpl;
  late MockSharedPreferences preferences;

  setUp(() {
    preferences = MockSharedPreferences();
    dataSourceImpl = UserLocalDataSourceImpl(preferences);
  });

  group('getLastUsers', () {
    final List<dynamic> json =
        jsonDecode(fixture('users_cached.json')) as List<dynamic>;
    final List<UserModel> tUserModels = json
        .map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
    test(
        'should return List<User> from SharedPreferences when there are some in the cache',
        () async {
      when(preferences.getString(any)).thenReturn(fixture('users_cached.json'));
      final List<UserModel> result = await dataSourceImpl.getLastUsers();
      verify(preferences.getString(CACHED_USERS));
      expect(result, equals(tUserModels));
    });

    test('should return a CacheException when there are no cached value',
        () async {
      when(preferences.getString(any)).thenReturn(null);
      final Future<List<UserModel>> Function() call =
          dataSourceImpl.getLastUsers;
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheUsers', () {
    final List<UserModel> tUserModels = <UserModel>[
      const UserModel(name: 'Jason', number: 1),
      const UserModel(name: 'S1ngleton')
    ];
    test('should call SharedPreferences to cache the data', () async {
      when(preferences.setString(any, any)).thenAnswer((_) async => true);
      await dataSourceImpl.cacheUsers(tUserModels);
      final String expectedJsonString =
          jsonEncode(tUserModels.map((UserModel e) => e.toJson()).toList());
      verify(preferences.setString(CACHED_USERS, expectedJsonString));
    });
  });
}
