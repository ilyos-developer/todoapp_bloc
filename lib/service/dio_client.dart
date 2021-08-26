import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_trello/model/cards.dart';
import 'package:todo_trello/model/login_errors.dart';
import 'package:todo_trello/model/user.dart';

class DioClient {
  static BaseOptions options = BaseOptions(baseUrl: baseUrl);

  final Dio dio = Dio(options);

  static final _storage = new FlutterSecureStorage();
  static final baseUrl = 'https://trello.backend.tests.nekidaem.ru/api/v1';

  static Future<Map<String, String>> _getHeaders() async {
    String? value = await _storage.read(key: 'userToken');
    print("token save: $value");
    return {"Authorization": "JWT $value"};
  }

  Future createUser(
      {required String userName,
      required String email,
      required String pass}) async {
    FormData formData = FormData.fromMap(
        {"username": userName, "email": email, "password": pass});
    try {
      final response = await dio.post("/users/create/", data: formData);
      print('Response body: ${response.data}');
      final user = User.fromJson(response.data);
      return user;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response!.data);
      }
    }
  }

  Future loginUser({required String userName, required String pass}) async {
    print(userName);
    print(pass);
    FormData formData =
        FormData.fromMap({"username": userName, "password": pass});
    try {
      final response = await dio.post(
        "/users/login/",
        data: formData,
      );
      print('Response body: ${response.data}');
      final user = User.fromJson(response.data);
      return user;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.error);
        final loginErr = LoginErrors.fromJson(e.response!.data);
        print(loginErr.username);
        print(loginErr.email);
        print(loginErr.nonFieldErrors);
      }
    }
  }

  Future getCards() async {
    dio.options.headers = await _getHeaders();
    try {
      final response = await dio.get(
        "/cards/",
      );
      print('Response body: ${response.data}');
      final cards = cardsFromJson(response.data);
      return cards;
    } catch (e) {
      print("line 63 $e");
    }
  }
}
