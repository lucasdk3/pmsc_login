import 'package:dartz/dartz.dart';

import '../../../../../exports_pmsc.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserEntity>> call({AuthEntity? entity});
}
