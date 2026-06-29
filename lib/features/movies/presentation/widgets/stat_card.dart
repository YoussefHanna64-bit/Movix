import 'package:flutter/material.dart';
import 'package:movix/core/theme/app_colors.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String statName;

  const StatCard({super.key, required this.icon, required this.statName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width*0.30,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ,color: AppColors.yellow, size: 40,),
          const SizedBox(width: 8,),
          Text(statName , style: const TextStyle(color: AppColors.textPrimary , fontSize: 24 , fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}