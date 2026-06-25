import 'package:flutter/material.dart';
import 'package:movix/features/profile/presentation/widgets/profile_custom_button.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onLogoutPressed;

  const ProfileActions(
      {super.key, required this.onEditPressed, required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ProfileCustomButton(
                label: "Edit Profile",
                backgroundColor: const Color(0xFFF6BD00),
                textColor: Colors.black,
                onPressed: onEditPressed,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ProfileCustomButton(
                label: "Logout",
                backgroundColor: const Color(0xFFE82626),
                textColor: Colors.white,
                icon: Icons.logout_rounded,
                onPressed: onLogoutPressed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
