class User {
  final String id;
  final String name;
  final String telephone;
  final String email;
  final String role;

  User({
    this.id,
    this.name,
    this.telephone,
    this.email,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        telephone = json['telephone'],
        email = json['email'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'telephone': telephone,
        'email': email,
        'role': role
      };
}
