class User {
  String? name;
  String? email;

  User(
    this.email,
    this.name,
  );

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'];
}
