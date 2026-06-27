import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/routes/app_routes.dart';
import 'package:movix/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectedAvatar = 1;
  bool securePassword = true;
  bool secureConfirmPassword = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _validateForm() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return false;
    }
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return false;
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      return false;
    }
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return false;
    }
    if (!RegExp(r'^[0-9]{11}$').hasMatch(_phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone number must be 11 digits")),
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Register",
          style: TextStyle(color: Color(0xFFF6BD00)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isSelected = _selectedAvatar == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFF6BD00)
                              : Colors.transparent,
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
              ),
              const SizedBox(height: 10),
              const Text(
                "Avatar",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Column(
                    children: [
                      _buildTextField(
                        hintText: "Name",
                        icon: Icons.badge_outlined,
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        hintText: "Email",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        hintText: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                        controller: _passwordController,
                        secureText: securePassword,
                        onTogglePassword: () {
                          setState(() {
                            securePassword = !securePassword;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        hintText: "Confirm Password",
                        controller: _confirmPasswordController,
                        icon: Icons.lock,
                        isPassword: true,
                        secureText: secureConfirmPassword,
                        onTogglePassword: () {
                          setState(() {
                            secureConfirmPassword = !secureConfirmPassword;
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: _phoneController,
                        hintText: "Phone Number",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.layout);
                          } else if (state is AuthFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF6BD00),
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_validateForm()) {
                                context.read<AuthCubit>().register(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      phoneNumber: _phoneController.text,
                                      avatar: _selectedAvatar,
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF6BD00),
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Create Account",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already Have Account ? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.login);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFFF6BD00),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    TextEditingController? controller,
    bool isPassword = false,
    bool secureText = false,
    VoidCallback? onTogglePassword,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      obscureText: secureText,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF282A28),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  secureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: onTogglePassword,
              )
            : null,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
