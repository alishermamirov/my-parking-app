class UserModel {
  final String userId;
  final String userName;
  final String email;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userName': userName, 'email': email};
  }

  copywith({String? userId, String? userName, String? email}) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }
}
