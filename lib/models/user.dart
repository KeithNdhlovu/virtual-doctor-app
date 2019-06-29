class User {
  final String email;
  final String lastName;
  final String firstName;
  final String bloodPressure;
  final String profilePicture;

  User({
    this.email,
    this.lastName,
    this.firstName,
    this.bloodPressure,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      bloodPressure: json["blood_pressure"],
      profilePicture: json["profile_picture"],
    );
  }
}