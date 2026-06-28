import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/widgets/app_button.dart';
import 'package:movix/core/widgets/app_text_field.dart';
import 'package:movix/features/auth/presentation/cubit/auth_cubit.dart';

class ChangePasswordSection extends StatefulWidget {
  const ChangePasswordSection({super.key});

  @override
  State<ChangePasswordSection> createState() => _ChangePasswordSectionState();
}

class _ChangePasswordSectionState extends State<ChangePasswordSection> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar("Please fill all password fields");
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackBar("Passwords do not match");
      return;
    }

    if (newPassword.length < 6) {
      _showSnackBar("Password must be at least 6 characters");
      return;
    }

    context.read<AuthCubit>().changePassword(newPassword: newPassword);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Change Password", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 20),
        AppTextField(
          controller: _newPasswordController,
          hintText: "New Password",
          prefixIcon: Icons.lock_outline,
          obscureText: _obscureNewPassword,
          onToggleObscure: () {
            setState(() {
              _obscureNewPassword = !_obscureNewPassword;
            });
          },
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _confirmPasswordController,
          hintText: "Confirm New Password",
          prefixIcon: Icons.lock_outline,
          obscureText: _obscureConfirmPassword,
          onToggleObscure: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
        const SizedBox(height: 20),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              _showSnackBar("Password changed successfully");
              _newPasswordController.clear();
              _confirmPasswordController.clear();
            } else if (state is AuthFailure) {
              _showSnackBar(state.error);
            }
          },
          builder: (context, state) {
            return AppButton(
              label: "Change Password",
              onPressed: _changePassword,
              isLoading: state is AuthLoading,
            );
          },
        ),
      ],
    );
  }
}
