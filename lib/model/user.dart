import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  User({
    this.username,
    this.email,
    this.token,
    this.nonFieldErrors,
  });

  String? username;
  String? email;
  String? token;
  String? nonFieldErrors;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username:
            json["username"] is List ? json["username"][0] : json["username"],
        email: json["email"] is List ? json["email"][0] : json["email"],
        token: json["token"],
        nonFieldErrors: json["non_field_errors"] is List
            ? json["non_field_errors"][0]
            : null,
      );
}
