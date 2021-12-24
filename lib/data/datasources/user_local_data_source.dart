import 'dart:convert';

import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

const String CACHED_USERS = 'CACHED_USERS';

abstract class UserLocalDataSource {
  Future<void> cacheUsers(List<UserModel> usersToChache);

  /// Gets the cached [List\<User\>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [CacheException] if no cached data is presented.
  Future<List<UserModel>> getLastUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  const UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheUsers(List<UserModel> usersToChache) {
    final String jsonString =
        jsonEncode(usersToChache.map((UserModel e) => e.toJson()).toList());
    return sharedPreferences.setString(CACHED_USERS, jsonString);
  }

  @override
  Future<List<UserModel>> getLastUsers() async {
    final String? jsonString = sharedPreferences.getString(CACHED_USERS);
    if (jsonString != null) {
      final List<dynamic> json = jsonDecode(jsonString) as List<dynamic>;
      return Future.value(json
          .map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      throw CacheException();
    }
  }
}
