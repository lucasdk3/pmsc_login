import 'package:pmsc_auth/app/_exports.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required String registration, required String password})
      : super(registration: registration, password: password);

  static Map<String, dynamic> toMap(AuthEntity entity) {
    return {"registration": entity.registration, "password": entity.password};
  }

  @override
  List<Object?> get props => [registration, password];

  @override
  bool? get stringify => true;
}

extension AuthEntityToModel on AuthEntity {
  AuthModel get toModel =>
      AuthModel(registration: registration, password: password);
}

extension AuthModelToEntity on AuthModel {
  AuthEntity get toEntity =>
      AuthEntity(registration: registration, password: password);
}
