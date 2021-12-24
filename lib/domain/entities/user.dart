import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final double? number;

  const User({required this.name, this.number});

  @override
  List<Object?> get props => <Object?>[name];
}
