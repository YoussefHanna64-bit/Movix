import 'package:flutter/material.dart';
import 'package:movix/features/profile/presentation/widgets/profile_actions.dart';
import 'package:movix/features/profile/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF212121),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ProfileHeader(
                  username: "Legend",
                  avatarUrl:
                      "https://avatarfiles.alphacoders.com/823/thumb-1920-82313.jpg",
                  wishlistCount: 12,
                  watchedCount: 10,
                ),
                const SizedBox(height: 16),
                ProfileActions(
                  onEditPressed: () {},
                  onLogoutPressed: () {},
                ),
                const SizedBox(height: 4),
                const TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: Color(0xFFF6BD00),
                  labelColor: Color(0xFFF6BD00),
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.list, size: 30),
                      text: "Watch List",
                    ),
                    Tab(
                      icon: Icon(Icons.history, size: 30),
                      text: "History",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(
                        child: Text(
                          "Watch List",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "History",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
