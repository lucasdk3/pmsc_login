import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? registration;
  final String? token;
  final String? refreshToken;

  const UserEntity({this.registration, this.token, this.refreshToken});

  @override
  List<Object?> get props => [registration, token, refreshToken];

  @override
  bool? get stringify => true;
}
