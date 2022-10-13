class UserModel {
  String userId;
  String name;
  String email;
  String image;

  UserModel({
    required this.name,
    required this.email,
    required this.image,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      image: json['image'],
      userId: json['uId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'uId': userId,
    };
  }
}
