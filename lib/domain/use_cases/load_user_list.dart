import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class LoadUserList implements UseCase<List<User>, Params> {
  final IUserRepository repository;

  LoadUserList(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(Params params) async {
    return repository.getUsers(params.count);
  }
}

class Params extends Equatable {
  final int count;

  const Params({required this.count});

  @override
  List<Object?> get props => <Object?>[count];
}
