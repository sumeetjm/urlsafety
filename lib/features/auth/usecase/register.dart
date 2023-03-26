import 'package:dartz/dartz.dart';
import 'package:urlsafety/core/error/failures.dart';
import 'package:urlsafety/core/usecase/usecase.dart';
import 'package:urlsafety/features/auth/repository/auth_repository.dart';

class Register extends UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  Register(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return authRepository.register();
  }
}
