import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_arch/src/authentication/data/repositories/authentication_repository_implementation.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group('createUser', () {
    test(
        'should call the [RemoteDataSource.createUser] and complete'
        ' succesfully when the call to the remote source is successful',
        () async {
      // Arrange
      when(
        () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')),
      ).thenAnswer((_) => Future.value());

      final createdAt = 'whatever.createdAt';
      final name = 'whatever.name';
      final avatar = 'whatever.avatar';

      // Act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(result, equals(const Right(null)));

      // Check if the remote source's createUser gets called with the right data
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
    });
  });
}
