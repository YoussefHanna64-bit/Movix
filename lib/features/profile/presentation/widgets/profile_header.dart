import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final int wishlistCount;
  final int watchedCount;

  const ProfileHeader(
      {super.key,
      required this.username,
      required this.avatarUrl,
      required this.wishlistCount,
      required this.watchedCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 46,
              backgroundImage: AssetImage(avatarUrl),
            ),
            const SizedBox(height: 8),
            Text(
              username,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
        Column(
          children: [
            Text(
              wishlistCount.toString(),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              "Wishlist",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
        Column(
          children: [
            Text(
              watchedCount.toString(),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              "Watched",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ],
    );
  }
}
