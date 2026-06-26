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
}
