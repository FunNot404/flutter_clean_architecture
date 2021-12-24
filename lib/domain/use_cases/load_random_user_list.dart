import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class LoadRandomUserList implements UseCase<List<User>, NoParams> {
  final IUserRepository repository;

  LoadRandomUserList(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return repository.getRandomUsers();
  }
}
