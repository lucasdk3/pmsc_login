import 'package:dartz/dartz.dart';

import '../../../../../exports_pmsc.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final IAuthDatasouce _datasouce;

  AuthRepositoryImpl(this._datasouce);
  @override
  Future<Either<Failure, UserEntity>> call({AuthEntity? entity}) {
    throw UnimplementedError();
  }
}
