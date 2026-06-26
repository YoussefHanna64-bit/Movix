import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.avatar,
    required super.phoneNumber,
    super.wishList,
    super.history,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? 1,
      phoneNumber: map['phoneNumber'] ?? '',
      // Safely casting dynamic lists to List<String>
      wishList: map['wishList'] == null
          ? null
          : List<String>.from(map['wishList'] ?? []),
      history: map['history'] == null
          ? null
          : List<String>.from(map['history'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'wishList': wishList,
      'history': history,
    };
  }
}
