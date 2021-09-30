import '../../../../../exports_pmsc.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required String? registration,
      required String? token,
      required String? refreshToken})
      : super(
            registration: registration,
            token: token,
            refreshToken: refreshToken);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      registration: json['registration'],
      token: json['token'],
      refreshToken: json['refresh-token']);

  @override
  List<Object?> get props => [registration, token, refreshToken];

  @override
  bool? get stringify => true;
}
