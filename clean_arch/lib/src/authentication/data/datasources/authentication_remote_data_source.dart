import 'dart:convert';

import 'package:clean_arch/core/errors/exceptions.dart';
import 'package:clean_arch/core/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:clean_arch/src/authentication/data/models/user_model.dart';

import '../../../../core/utils/typedef.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndPoint = '/test-api/user';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // 1. Check to make sure that it returns the right data when the status
    // code is 200 or the proper response code
    // 2. check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    // right message when status code is the bad one
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      // Arrange
      final response = await _client.get(
        Uri.http(kBaseUrl, kGetUsersEndPoint),
      );

      // Act
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
