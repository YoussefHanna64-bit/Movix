import 'package:flutter/material.dart';
import 'package:movix/features/profile/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              ProfileHeader(
                username: "Legend",
                avatarUrl:
                    "https://avatarfiles.alphacoders.com/823/thumb-1920-82313.jpg",
                wishlistCount: 12,
                watchedCount: 10,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
