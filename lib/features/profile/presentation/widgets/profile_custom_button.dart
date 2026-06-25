import 'package:flutter/material.dart';

class ProfileCustomButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final VoidCallback onPressed;

  const ProfileCustomButton(
      {super.key,
      required this.label,
      required this.backgroundColor,
      required this.textColor,
      this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: backgroundColor,
      ),
      iconAlignment: IconAlignment.end,
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, color: Colors.white, size: 20) : null,
      label: Text(label,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          )),
    );
  }
}
