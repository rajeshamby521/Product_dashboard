class Register {
  String? name;
  String? email;

  String? gender;
  String? birthDate;
  String? image;
  int? id;

  Register.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        gender = json['gender'],
        birthDate = json['birth_date'],
        image = json['images'],
        id = json['id'];
}
