import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

typedef _ListOrRandomChooser = Future<List<UserModel>> Function();

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const UserRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<User>>> getRandomUsers() async {
    return _getUsers(() => remoteDataSource.getRandomUsers());
  }

  @override
  Future<Either<Failure, List<User>>> getUsers(int count) async {
    return _getUsers(() => remoteDataSource.getUsers(count));
  }

  Future<Either<Failure, List<User>>> _getUsers(
      _ListOrRandomChooser getListOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final List<UserModel> remoteUsers = await getListOrRandom();
        localDataSource.cacheUsers(remoteUsers);
        return Right<Failure, List<User>>(remoteUsers);
      } on ServerException {
        return const Left<Failure, List<User>>(ServerFailure());
      }
    } else {
      try {
        final List<UserModel> localUsers = await localDataSource.getLastUsers();
        return Right<Failure, List<User>>(localUsers);
      } on CacheException {
        return const Left<Failure, List<User>>(CacheFailure());
      }
    }
  }
}
