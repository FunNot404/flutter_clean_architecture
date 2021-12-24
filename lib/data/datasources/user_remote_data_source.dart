import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the [host] endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<UserModel>> getRandomUsers();

  /// Calls the [host] endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<UserModel>> getUsers(int count);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  const UserRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UserModel>> getRandomUsers() async {
    return _getUsersFromUrl('http://localhost:3000/users/random');
  }

  @override
  Future<List<UserModel>> getUsers(int count) async {
    return _getUsersFromUrl('http://localhost:3000/users?count=$count');
  }

  Future<List<UserModel>> _getUsersFromUrl(String url) async {
    try {
      final Response<String> response = await dio.get<String>(url,
          options: Options(
              headers: <String, dynamic>{'Content-Type': 'application/json'}));
      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.data!) as List<dynamic>;
        final List<UserModel> userModels = json
            .map((dynamic e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return userModels;
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw ServerException();
    }
  }
}
