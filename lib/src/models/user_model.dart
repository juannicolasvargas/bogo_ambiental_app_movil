class UserModel {
  final int id;
  final String email;
  final String name;
  final String lastName;
  final String image;

  UserModel({ this.id, this.email, this.name, this.lastName, this.image });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      lastName: json['last_name'],
      image: ''
    );
  }
}