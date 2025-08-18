import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projek2_aplikasi_todolist/screens/auth/login.dart';
import 'package:projek2_aplikasi_todolist/screens/home_screen.dart';
import 'package:projek2_aplikasi_todolist/services/auth_services.dart';

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
                  if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: nameController,
                label: 'Nama',
                hint: 'Nama Anda',
                validator: (value) => value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: bioController,
                label: 'Bio',
                hint: 'Tentang Anda',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: tanggalLahirController,
                label: 'Tanggal Lahir',
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
                label: 'Nomor Telepon',
                hint: '+628123456789',
                validator: (value) => value == null || value.isEmpty ? 'Nomor telepon tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: passwordController,
                label: 'Kata Sandi',
                hint: 'Kata Sandi',
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
                  if (value == null || value.isEmpty) return 'Kata sandi tidak boleh kosong';
                  if (value.length < 6) return 'Kata sandi minimal 6 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: confirmPasswordController,
                label: 'Konfirmasi Kata Sandi',
                hint: 'Konfirmasi Kata Sandi',
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
                  if (value == null || value.isEmpty) return 'Konfirmasi kata sandi tidak boleh kosong';
                  if (value != passwordController.text) return 'Kata sandi tidak cocok';
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
                                  'Pendaftaran Berhasil',
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  response.user?.emailConfirmedAt == null
                                      ? 'Akun Anda telah berhasil dibuat. Silakan verifikasi email Anda untuk login.'
                                      : 'Akun Anda telah berhasil dibuat. Selamat datang di To Do Day!',
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
                              SnackBar(content: Text('Gagal mendaftar: ${e.toString()}')),
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
                    'Sudah punya akun? ',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
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
      ),
    );
  }
