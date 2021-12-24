import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  Future<Either<Failure, List<User>>> getRandomUsers();
  Future<Either<Failure, List<User>>> getUsers(int count);
}
