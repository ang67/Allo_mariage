class User {
  final String id;
  final String name;
  final String telephone;
  final String email;
  final String role;
  final String photoURL;
  final DateTime lastSignInTime;
  final DateTime creationTime;

  User({
    this.id,
    this.name,
    this.telephone,
    this.email,
    this.role,
    this.photoURL,
    this.lastSignInTime,
    this.creationTime,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        telephone = json['telephone'],
        email = json['email'],
        role = json['role'],
        photoURL = json['photoURL'],
        lastSignInTime = json['lastSignInTime'],
        creationTime = json['creationTime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'telephone': telephone,
        'email': email,
        'role': role,
        'photoURL': photoURL,
        'lastSignInTime': lastSignInTime,
        'creationTime': creationTime
      };
}
