import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasources/user_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasources/user_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/models/user_model.dart';
import 'package:flutter_clean_architecture/data/repositories.dart/user_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks(
  [UserRemoteDataSource, UserLocalDataSource, NetworkInfo],
)
void main() {
  late UserRepositoryImpl repositoryImpl;
  late MockUserRemoteDataSource remoteDataSource;
  late MockUserLocalDataSource localDataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    remoteDataSource = MockUserRemoteDataSource();
    localDataSource = MockUserLocalDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = UserRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
        networkInfo: networkInfo);
  });

  void runTestsOnline(Function() body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function() body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('get users', () {
    const int tCount = 10;
    const List<UserModel> tUserModels = <UserModel>[UserModel(name: 'Jason')];
    const List<User> tUsers = tUserModels;
    test('should check if the device is online', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getUsers(any))
          .thenAnswer((_) async => <UserModel>[]);
      await repositoryImpl.getUsers(tCount);
      verify(networkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getUsers(any))
            .thenAnswer((_) async => tUserModels);
        final Either<Failure, List<User>> result =
            await repositoryImpl.getUsers(tCount);
        verify(remoteDataSource.getUsers(tCount));
        expect(result, equals(const Right<Failure, List<User>>(tUserModels)));
      });
      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getUsers(any))
            .thenAnswer((_) async => tUserModels);
        await repositoryImpl.getUsers(tCount);
        verify(remoteDataSource.getUsers(tCount));
        verify(localDataSource.cacheUsers(tUserModels));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(remoteDataSource.getUsers(any)).thenThrow(ServerException());
        final Either<Failure, List<User>> result =
            await repositoryImpl.getUsers(tCount);
        verify(remoteDataSource.getUsers(tCount));
        verifyNoMoreInteractions(localDataSource);
        expect(
            result, equals(const Left<Failure, List<User>>(ServerFailure())));
      });
    });
    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(localDataSource.getLastUsers())
            .thenAnswer((_) async => tUserModels);
        final Either<Failure, List<User>> result =
            await repositoryImpl.getUsers(tCount);
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastUsers());
        expect(result, equals(const Right<Failure, List<User>>(tUserModels)));
      });
      test('should return CacheFailure when there is no cached data present',
          () async {
        when(localDataSource.getLastUsers()).thenThrow(CacheException());
        final Either<Failure, List<User>> result =
            await repositoryImpl.getUsers(tCount);
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastUsers());
        expect(result, equals(const Left<Failure, List<User>>(CacheFailure())));
      });
    });
  });

  group('get random users', () {
    const List<UserModel> tUserModels = <UserModel>[UserModel(name: 'Jason')];
    const List<User> tUsers = tUserModels;
    test('should check if the device is online', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getRandomUsers())
          .thenAnswer((_) async => <UserModel>[]);
      await repositoryImpl.getRandomUsers();
      verify(networkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getRandomUsers())
            .thenAnswer((_) async => tUserModels);
        final Either<Failure, List<User>> result =
            await repositoryImpl.getRandomUsers();
        verify(remoteDataSource.getRandomUsers());
        expect(result, equals(const Right<Failure, List<User>>(tUserModels)));
      });
      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getRandomUsers())
            .thenAnswer((_) async => tUserModels);
        await repositoryImpl.getRandomUsers();
        verify(remoteDataSource.getRandomUsers());
        verify(localDataSource.cacheUsers(tUserModels));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(remoteDataSource.getRandomUsers()).thenThrow(ServerException());
        final Either<Failure, List<User>> result =
            await repositoryImpl.getRandomUsers();
        verify(remoteDataSource.getRandomUsers());
        verifyNoMoreInteractions(localDataSource);
        expect(
            result, equals(const Left<Failure, List<User>>(ServerFailure())));
      });
    });
    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(localDataSource.getLastUsers())
            .thenAnswer((_) async => tUserModels);
        final Either<Failure, List<User>> result =
            await repositoryImpl.getRandomUsers();
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastUsers());
        expect(result, equals(const Right<Failure, List<User>>(tUserModels)));
      });
      test('should return CacheFailure when there is no cached data present',
          () async {
        when(localDataSource.getLastUsers()).thenThrow(CacheException());
        final Either<Failure, List<User>> result =
            await repositoryImpl.getRandomUsers();
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastUsers());
        expect(result, equals(const Left<Failure, List<User>>(CacheFailure())));
      });
    });
  });
}
