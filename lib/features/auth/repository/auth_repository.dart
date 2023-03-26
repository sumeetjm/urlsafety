import 'package:dartz/dartz.dart';
import 'package:urlsafety/core/error/exceptions.dart';
import 'package:urlsafety/core/error/failures.dart';
import 'package:urlsafety/features/auth/datasource/auth_datasource.dart';

class AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepository({required this.authDatasource});

  Future<Either<Failure, bool>> login() async {
    try {
      final user = await authDatasource.login();
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> register() async {
    try {
      final user = await authDatasource.register();
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> getLoggedInUser() async {
    try {
      final user = await authDatasource.getLoggedInUser();
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> logout() async {
    try {
      final user = await authDatasource.logout();
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
