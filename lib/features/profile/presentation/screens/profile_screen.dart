import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/routes/app_routes.dart';
import 'package:movix/core/theme/app_colors.dart';
import 'package:movix/core/widgets/custom_error_widget.dart';
import 'package:movix/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:movix/features/profile/presentation/cubit/profile_state.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFF212121),
          body: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
            if (state is ProfileLoading || state is ProfileInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.yellow),
              );
            }

            if (state is ProfileError) {
              return CustomErrorWidget(
                errorMessage: state.message,
                onRetry: () {
                  context.read<ProfileCubit>().loadProfile();
                },
              );
            }
            if (state is ProfileLoaded) {
              final user = state.user;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ProfileHeader(
                        username: user.name,
                        avatarUrl:
                            "assets/images/avatar${user.avatar + 1}.png",
                        wishlistCount: user.wishList?.length ?? 0,
                        watchedCount: user.history?.length ?? 0,
                      ),
                      const SizedBox(height: 16),
                      ProfileActions(
                        onEditPressed: () {},
                        onLogoutPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                      ),
                      const SizedBox(height: 4),
                      const TabBar(
                        dividerColor: Colors.transparent,
                        indicatorColor: AppColors.yellow,
                        labelColor: AppColors.yellow,
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
                      const Expanded(
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
              );
            }
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
