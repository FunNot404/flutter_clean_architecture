import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/domain/entities/user.dart';
import 'package:flutter_clean_architecture/domain/repositories/i_user_repository.dart';
import 'package:flutter_clean_architecture/domain/use_cases/load_user_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'load_user_list_test.mocks.dart';

@GenerateMocks([IUserRepository])
void main() {
  late LoadUserList usecase;
  late MockIUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockIUserRepository();
    usecase = LoadUserList(mockUserRepository);
  });
  const int tUserCount = 10;
  final List<User> tLoadedUser = <User>[const User(name: 'Jason', number: 1)];
  test('should load user list from repository', () async {
    when(mockUserRepository.getUsers(any))
        .thenAnswer((_) async => Right<Failure, List<User>>(tLoadedUser));
    final Either<Failure, List<User>> result =
        await usecase(const Params(count: tUserCount));
    expect(result, Right<Failure, List<User>>(tLoadedUser));
    verify(mockUserRepository.getUsers(tUserCount));
    verifyNoMoreInteractions(mockUserRepository);
  });
}

// class MockUserRepository extends Mock implements IUserRepository {}
