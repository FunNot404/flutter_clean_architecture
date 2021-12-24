import 'dart:convert';

import 'package:flutter_clean_architecture/data/models/user_model.dart';
import 'package:flutter_clean_architecture/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const UserModel tUserModel = UserModel(name: 'Jason', number: 1);
  const UserModel tUserModel2 = UserModel(name: 'S1ngleton');

  test('should be a subclass of User entity', () async {
    expect(tUserModel, isA<User>());
  });

  group('fromJson', () {
    test('should return a valid list when the JSON number is empty', () async {
      // arrange
      final List<dynamic> jsonMap =
          jsonDecode(fixture('users.json')) as List<dynamic>;
      // act
      final List<User> result = jsonMap
          .map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
      // assert
      expect(result, equals(<User>[tUserModel, tUserModel2]));
    });
  });
}
