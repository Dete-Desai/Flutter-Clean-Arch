import 'package:clean_arch/core/errors/exceptions.dart';
import 'package:clean_arch/core/errors/failure.dart';
import 'package:clean_arch/core/utils/typedef.dart';
import 'package:clean_arch/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_arch/src/authentication/domain/entities/user.dart';
import 'package:clean_arch/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // Test-Driven Development
    // Call the remote data source
    // Make sure that it returns the proper data if there is no exception
    // Check if the method returns the proper data
    // Check if when the remoteDataSource throws an exception, we return a
    // failure and of it doesnt throw an exception, we returrn the actual
    // expected data

    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
