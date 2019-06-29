class User {
  final String firstName;
  final String lastName;
  final String email;

  User({this.firstName, this.lastName, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      lastName: json["last_name"],
      firstName: json["first_name"],
    );
  }
}