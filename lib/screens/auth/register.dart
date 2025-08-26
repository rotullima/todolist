import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/screens/auth/login.dart';
import 'package:todolist/screens/home_screen.dart';
import 'package:todolist/services/auth_services.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  _RegisterModalState createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final nomerHpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authServices = AuthServices();

  void _showLoginModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => LoginModal(),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    bioController.dispose();
    tanggalLahirController.dispose();
    nomerHpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFA0D7C8),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create Account',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF584A4A),
                ),
              ),
              const SizedBox(height: 25),
              _buildTextField(
                controller: emailController,
                label: 'Email',
                hint: 'info@example.com',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email must not be empty';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: nameController,
                label: 'Name',
                hint: 'Your Name',
                validator: (value) => value == null || value.isEmpty ? 'Name must not be empty' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: bioController,
                label: 'Bio',
                hint: 'About You',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: tanggalLahirController,
                label: 'Birth Date',
                hint: 'YYYY-MM-DD',
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      tanggalLahirController.text =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: nomerHpController,
                label: 'Contact NUmber',
                hint: '+628123456789',
                validator: (value) => value == null || value.isEmpty ? 'Contact number must not be empty' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: passwordController,
                label: 'Password',
                hint: 'Password',
                obscureText: !isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Password must not be empty';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hint: ' Confirm Password',
                obscureText: !isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () => setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please confirm yur password';
                  if (value != passwordController.text) return 'Password do not match';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AbsorbPointer(
                absorbing: isLoading,
                child: GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          setState(() => isLoading = true);
                          try {
                            final response = await authServices.signUpWithEmail(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              bioController.text,
                              tanggalLahirController.text.isEmpty ? null : tanggalLahirController.text,
                              nomerHpController.text,
                            );
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Registation Successful',
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  response.user?.emailConfirmedAt == null
                                      ? 'Account created. Please verify your email to activate your account.'
                                      : 'Account created. Wellcome to NexToDo!',
                                  style: GoogleFonts.poppins(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (response.user?.emailConfirmedAt != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFFA0D7C8)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Registration failed: ${e.toString()}')),
                            );
                          } finally {
                            setState(() => isLoading = false);
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Container(
                          width: 400,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF584A4A),
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF584A4A),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _showLoginModal(context);
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: 400,
      height: 60,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          labelText: label,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 3.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red, width: 3.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red, width: 3.0),
          ),
        ),
        validator: validator,
        onTap: onTap,
      ),
    );
  }
}

  // Widget _buildTextField({
  //   required TextEditingController controller,
  //   required String label,
  //   required String hint,
  //   bool obscureText = false,
  //   Widget? suffixIcon,
  //   String? Function(String?)? validator,
  // }) {
  //   return SizedBox(
  //     width: 400,
  //     height: 60,
  //     child: TextFormField(
  //       controller: controller,
  //       obscureText: obscureText,
  //       decoration: InputDecoration(
  //         labelStyle: GoogleFonts.poppins(
  //           color: Colors.white,
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //         ),
  //         hintText: hint,
  //         hintStyle: const TextStyle(color: Colors.white),
  //         labelText: label,
  //         suffixIcon: suffixIcon,
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20),
  //           borderSide: const BorderSide(color: Colors.white, width: 3.0),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20),
  //           borderSide: const BorderSide(color: Colors.white, width: 3.0),
  //         ),
  //         errorBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20),
  //           borderSide: const BorderSide(color: Colors.red, width: 3.0),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20),
  //           borderSide: const BorderSide(color: Colors.red, width: 3.0),
  //         ),
  //       ),
  //       validator: validator,
  //     ),
  //   );
  // }