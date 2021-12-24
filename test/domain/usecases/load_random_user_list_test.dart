import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/domain/entities/user.dart';
import 'package:flutter_clean_architecture/domain/repositories/i_user_repository.dart';
import 'package:flutter_clean_architecture/domain/use_cases/load_random_user_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'load_user_list_test.mocks.dart';

@GenerateMocks([IUserRepository])
void main() {
  late LoadRandomUserList usecase;
  late MockIUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockIUserRepository();
    usecase = LoadRandomUserList(mockUserRepository);
  });
  final List<User> tLoadedUser = <User>[const User(name: 'Jason', number: 1)];
  test('should load random user list from repository', () async {
    when(mockUserRepository.getRandomUsers())
        .thenAnswer((_) async => Right<Failure, List<User>>(tLoadedUser));
    final Either<Failure, List<User>> result = await usecase(const NoParams());
    expect(result, Right<Failure, List<User>>(tLoadedUser));
    verify(mockUserRepository.getRandomUsers());
    verifyNoMoreInteractions(mockUserRepository);
  });
}

// class MockUserRepository extends Mock implements IUserRepository {}
