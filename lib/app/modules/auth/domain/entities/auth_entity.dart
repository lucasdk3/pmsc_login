import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String registration;
  final String password;

  const AuthEntity({required this.registration, required this.password});
  @override
  List<Object?> get props => [registration, password];
}
