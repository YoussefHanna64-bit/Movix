import 'package:flutter/material.dart';
import 'package:movix/core/theme/app_colors.dart';

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
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            )
          ],
        ),
        Column(
          children: [
            Text(
              wishlistCount.toString(),
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            const Text(
              "Wishlist",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            )
          ],
        ),
        Column(
          children: [
            Text(
              watchedCount.toString(),
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            const Text(
              "Watched",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            )
          ],
        ),
      ],
    );
  }
}
