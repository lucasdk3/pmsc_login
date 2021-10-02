import 'package:dartz/dartz.dart';

import '../../../../../exports_pmsc.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final IAuthDatasouce _datasouce;

  AuthRepositoryImpl(this._datasouce);
  @override
  Future<Either<Failure, UserEntity>> call({required AuthEntity entity}) async {
    try {
      final result = await _datasouce.call(entity.toModel);
      return right(result.toEntity);
    } on ErrorResponse catch (e) {
      return left(e);
    }
  }
}
