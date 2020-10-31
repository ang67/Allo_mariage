class User {
  final String id;
  final String email;
  final String telephone;
  final String role;
  final String firstname;

  User({
    this.id,
    this.email,
    this.telephone,
    this.role,
    this.firstname,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        telephone = json['telephone'],
        role = json['role'],
        firstname = json['firstname'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'telephone': telephone,
        'role': role,
        'firstname': firstname,
      };
}
