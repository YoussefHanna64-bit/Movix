import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/theme/app_colors.dart';
import 'package:movix/core/widgets/app_button.dart';
import 'package:movix/core/widgets/app_text_field.dart';
import 'package:movix/core/widgets/avatar_picker.dart';
import 'package:movix/core/widgets/confirm_dialog.dart';
import 'package:movix/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:movix/features/profile/presentation/cubit/profile_state.dart';
import 'package:movix/features/profile/presentation/widgets/change_password_section.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  int _selectedAvatar = 0;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileLoaded) {
      final user = state.user;
      _nameController.text = user.name;
      _phoneController.text = user.phoneNumber;
      _selectedAvatar = user.avatar;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _deleteAccount() async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: "Delete Account",
      message:
          "Are you sure you want to delete your account? This action cannot be undone",
      confirmLabel: "Delete",
    );
    if (confirmed && mounted) {
      await context.read<AuthCubit>().deleteAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.yellow),
        centerTitle: true,
        title: Text("Update Profile",
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                AvatarPicker(
                  selectedAvatar: _selectedAvatar,
                  onAvatarSelected: (index) {
                    setState(() => _selectedAvatar = index);
                  },
                ),
                const SizedBox(height: 30),
                AppTextField(
                  controller: _nameController,
                  hintText: "Name",
                  prefixIcon: Icons.badge_outlined,
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: _phoneController,
                  hintText: "Phone Number",
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 30),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Profile updated successfully")),
                      );
                      Navigator.pop(context);
                    } else if (state is ProfileError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      label: "Save",
                      onPressed: () {
                        if (_nameController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty) {
                          context.read<ProfileCubit>().updateProfile(
                                newName: _nameController.text,
                                newAvatar: _selectedAvatar,
                                phoneNumber: _phoneController.text,
                              );
                        }
                      },
                      isLoading: state is ProfileLoading,
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Divider(color: AppColors.dividerColor),
                const SizedBox(height: 20),
                const ChangePasswordSection(),
                const SizedBox(height: 60),
                AppButton.danger(
                  label: "Delete Account",
                  onPressed: _deleteAccount,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
