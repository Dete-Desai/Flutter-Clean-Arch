import 'package:clean_arch/core/utils/typedef.dart';
import 'package:clean_arch/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_arch/src/authentication/domain/entities/user.dart';
import 'package:clean_arch/src/authentication/domain/repositories/authentication_repository.dart';

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

    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<User>> getUsers() {
    //TODO: implement getUsers
    throw UnimplementedError();
  }
}
