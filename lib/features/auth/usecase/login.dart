import 'package:dartz/dartz.dart';
import 'package:urlsafety/core/error/failures.dart';
import 'package:urlsafety/core/usecase/usecase.dart';
import 'package:urlsafety/features/auth/repository/auth_repository.dart';

class Login extends UseCase<bool, MultiParams> {
  final AuthRepository authRepository;

  Login(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return authRepository.login(params.params[0], params.params[1]);
  }
}
