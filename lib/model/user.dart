import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  User({
    required this.username,
    required this.email,
    this.token,
  });

  String username;
  String email;
  String? token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        token: json["token"],
      );
}
