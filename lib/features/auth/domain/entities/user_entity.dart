class UserEntity {
  final String uid;
  final String name;
  final String email;
  final int avatar;
  final String phoneNumber;
  final List<String>? wishList;
  final List<String>? history;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
    required this.phoneNumber,
    this.wishList,
    this.history,
  });

  UserEntity copyWith({
    String? name,
    int? avatar,
    String? phoneNumber,
    List<String>? wishList,
    List<String>? history,
  }) {
    return UserEntity(
      uid: uid,
      email: email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      wishList: wishList ?? this.wishList,
      history: history ?? this.history,
    );
  }
}
