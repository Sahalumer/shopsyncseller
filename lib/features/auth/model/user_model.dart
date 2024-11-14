class UserModel {
  final String username;
  final String email;
  final String userType;
  String? uid;

  UserModel({
    required this.userType,
    required this.email,
    required this.username,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'uid': uid,
      'userType': userType,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      userType: map['userType'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      uid: map['uid'],
    );
  }
}
