import 'package:flutter/material.dart';
import 'package:movix/core/theme/app_colors.dart';

class AvatarPicker extends StatelessWidget {
  final int selectedAvatar;
  final ValueChanged<int> onAvatarSelected;

  const AvatarPicker({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isSelected = selectedAvatar == index;
        return GestureDetector(
          onTap: () => onAvatarSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.yellow : Colors.transparent,
                width: isSelected ? 3 : 0,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/avatar${index + 1}.png",
                height: isSelected ? 120 : 80,
                width: isSelected ? 120 : 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }
}
