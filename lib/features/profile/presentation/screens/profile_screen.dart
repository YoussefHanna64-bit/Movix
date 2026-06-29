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
import 'package:movix/features/profile/presentation/widgets/profile_movie_list.dart';

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
          backgroundColor: AppColors.black,
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
              final profileState = state;
              final user = profileState.user;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ProfileHeader(
                        username: user.name,
                        avatarUrl: "assets/images/avatar${user.avatar + 1}.png",
                        wishlistCount: profileState.wishlistMovies.length,
                        watchedCount: profileState.historyMovies.length,
                      ),
                      const SizedBox(height: 16),
                      ProfileActions(
                        onEditPressed: () {
                          Navigator.pushNamed(context, AppRoutes.updateProfile);
                        },
                        onLogoutPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                      ),
                      const SizedBox(height: 4),
                      const TabBar(
                        dividerColor: Colors.transparent,
                        indicatorColor: AppColors.yellow,
                        labelColor: AppColors.yellow,
                        unselectedLabelColor: AppColors.grey,
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
                            ProfileMovieList(
                              movies: profileState.wishlistMovies,
                              emptyLabel: "Your watchlist is empty",
                              emptyIcon: Icons.bookmark_border,
                            ),
                            ProfileMovieList(
                              movies: profileState.historyMovies,
                              emptyLabel: "No watch history yet",
                              emptyIcon: Icons.history,
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
