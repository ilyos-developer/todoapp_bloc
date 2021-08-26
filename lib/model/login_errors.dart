class LoginErrors {
  String? nonFieldErrors;
  String? username;
  String? email;

  LoginErrors({this.nonFieldErrors, this.username, this.email});

  factory LoginErrors.fromJson(Map<String, dynamic> json) => LoginErrors(
        username: json["username"] is List ? json["username"][0] : null,
        email: json["email"] is List ? json["email"][0] : null,
        nonFieldErrors: json["non_field_errors"] is List
            ? json["non_field_errors"][0]
            : null,
      );
}
