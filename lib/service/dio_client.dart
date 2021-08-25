import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_trello/model/cards.dart';
import 'package:todo_trello/model/user.dart';

class DioClient {
  final Dio dio = Dio();

  static final _storage = new FlutterSecureStorage();
  static final baseUrl = 'https://trello.backend.tests.nekidaem.ru/api/v1';

  static Future<Map<String, String>> _getHeaders() async {
    String? value = await _storage.read(key: 'userToken');
    return {"Authorization": "JWT $value"};
  }

  Future createUser(
      {required String userName,
      required String email,
      required String pass}) async {
    dio.options.baseUrl = baseUrl;
    FormData formData = FormData.fromMap(
        {"username": userName, "email": email, "password": pass});
    try {
      final response = await dio.post("/users/create/", data: formData);
      print('Response body: ${response.data}');
      final user = User.fromJson(response.data);
      return user;
    } catch (e) {
      print("line 28 $e");
    }
  }

  Future loginUser({required String userName, required String pass}) async {
    dio.options.baseUrl = baseUrl;
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
    } catch (e) {
      print("line 43 $e");
    }
  }

  Future getCards() async {
    dio.options.baseUrl = baseUrl;
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
