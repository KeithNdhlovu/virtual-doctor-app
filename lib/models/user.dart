class User {
  final String firstName;
  final String lastName;
  final String email;

  User({this.firstName, this.lastName, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json["firs_name"],
      lastName: json["last_name"],
      email: json["email"]
    );
  }
}