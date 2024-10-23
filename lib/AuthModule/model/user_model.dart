class User {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'username': username,
        'password': password,
      };
}
