import 'package:dartz/dartz.dart';
import 'package:urlsafety/core/error/exceptions.dart';
import 'package:urlsafety/core/error/failures.dart';
import 'package:urlsafety/features/auth/datasource/auth_datasource.dart';

class AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepository({required this.authDatasource});

  Future<Either<Failure, bool>> login(
      final String username, final String password) async {
    try {
      final isLoggedIn = await authDatasource.login(username, password);
      return Right(isLoggedIn);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> register(
      final String username, final String password) async {
    try {
      final isLoggedIn = await authDatasource.register(username, password);
      return Right(isLoggedIn);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> getLoggedInUser() async {
    try {
      final isLoggedIn = await authDatasource.getLoggedInUser();
      return Right(isLoggedIn);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> logout() async {
    try {
      final isLoggedOut = await authDatasource.logout();
      return Right(isLoggedOut);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
