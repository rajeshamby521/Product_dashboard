class RegisterRequest {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? image;
  String? birthDate;
  String? gender;

  RegisterRequest(
      {this.name,
      this.email,
      this.password,
      this.confirmPassword,
      this.image,
      this.birthDate,
      this.gender});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'images': image,
        'birth_date': birthDate,
        'gender': gender,
      };
}
