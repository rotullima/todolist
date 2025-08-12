import 'package:flutter/material.dart';
import 'package:projek2_aplikasi_todolist/services/auth_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _showRegisterModal(BuildContext context) {
    bool isPasswordVisible = false;
    bool isConfirmPasswordVisible = false;
    bool isLoading = false;
    String? emailError;
    String? nameError;
    String? nomerHpError;
    String? passwordError;
    String? confirmPasswordError;
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final bioController = TextEditingController();
    final tanggalLahirController = TextEditingController();
    final nomerHpController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final authServices = AuthServices();

    // Validasi real-time
    void validateInputs() {
      emailError = emailController.text.isEmpty
          ? 'Email tidak boleh kosong'
          : !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)
              ? 'Email tidak valid'
              : null;
      nameError = nameController.text.isEmpty ? 'Nama tidak boleh kosong' : null;
      nomerHpError = nomerHpController.text.isEmpty ? 'Nomor telepon tidak boleh kosong' : null;
      passwordError = passwordController.text.isEmpty
          ? 'Kata sandi tidak boleh kosong'
          : passwordController.text.length < 6
              ? 'Kata sandi minimal 6 karakter'
              : null;
      confirmPasswordError = confirmPasswordController.text.isEmpty
          ? 'Konfirmasi kata sandi tidak boleh kosong'
          : confirmPasswordController.text != passwordController.text
              ? 'Kata sandi tidak cocok'
              : null;
    }

    // Tambahkan listener untuk validasi real-time
    emailController.addListener(validateInputs);
    nameController.addListener(validateInputs);
    nomerHpController.addListener(validateInputs);
    passwordController.addListener(validateInputs);
    confirmPasswordController.addListener(validateInputs);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                width: 550,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFA0D7C8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF584A4A),
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          hintText: "info@example.com",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Email",
                          errorText: emailError,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          hintText: "Nama Anda",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Nama",
                          errorText: nameError,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: bioController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          hintText: "Tentang Anda",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Bio",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: tanggalLahirController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          hintText: "YYYY-MM-DD",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Tanggal Lahir",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                        ),
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
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: nomerHpController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          hintText: "+628123456789",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Nomor Telepon",
                          errorText: nomerHpError,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                          hintText: "Kata Sandi",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Kata Sandi",
                          errorText: passwordError,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: !isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          hintText: "Konfirmasi Kata Sandi",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Konfirmasi Kata Sandi",
                          errorText: confirmPasswordError,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isConfirmPasswordVisible = !isConfirmPasswordVisible;
                              });
                            },
                            child: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                          validateInputs();
                        });
                        if (emailError != null ||
                            nameError != null ||
                            nomerHpError != null ||
                            passwordError != null ||
                            confirmPasswordError != null) {
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }
                        try {
                          final response = await authServices.signUpWithEmail(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            bioController.text,
                            tanggalLahirController.text.isEmpty
                                ? null
                                : tanggalLahirController.text,
                            nomerHpController.text,
                          );
                          Navigator.pop(context); // Tutup modal
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Pendaftaran Berhasil',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    Navigator.pop(context); // Tutup dialog
                                    if (response.user?.emailConfirmedAt != null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'OK',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Color(0xFFA0D7C8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal mendaftar: $e')),
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
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
                                  color: Color(0xFF584A4A),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun? ',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF584A4A)),
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
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      // Bersihkan listener saat modal ditutup
      emailController.dispose();
      nameController.dispose();
      bioController.dispose();
      tanggalLahirController.dispose();
      nomerHpController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
    });
  }

  void _showLoginModal(BuildContext context) {
    bool isPasswordVisible = false;
    bool isLoading = false;
    String? emailError;
    String? passwordError;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final authServices = AuthServices();

    // Validasi real-time
    void validateInputs() {
      emailError = emailController.text.isEmpty
          ? 'Email tidak boleh kosong'
          : !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)
              ? 'Email tidak valid'
              : null;
      passwordError = passwordController.text.isEmpty
          ? 'Kata sandi tidak boleh kosong'
          : passwordController.text.length < 6
              ? 'Kata sandi minimal 6 karakter'
              : null;
    }

    emailController.addListener(validateInputs);
    passwordController.addListener(validateInputs);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                width: 550,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFA0D7C8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF584A4A),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          hintText: "info@example.com",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Email",
                          errorText: emailError,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 60,
                      child: TextField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          hintText: "Kata Sandi",
                          hintStyle: TextStyle(color: Colors.white),
                          labelText: "Kata Sandi",
                          errorText: passwordError,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white, width: 3.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                          validateInputs();
                        });
                        if (emailError != null || passwordError != null) {
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }
                        try {
                          await authServices.signInWithEmail(
                            emailController.text,
                            passwordController.text,
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login berhasil')),
                          );
                        } catch (e) {
                          setState(() {
                            passwordError = 'Email atau kata sandi salah';
                          });
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Container(
                              width: 400,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0xFF584A4A),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _showRegisterModal(context);
                          },
                          child: Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      // Bersihkan listener saat modal ditutup
      emailController.dispose();
      passwordController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'To Do Day',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA0D7C8),
                  ),
                ),
                ClipOval(
                  child: Container(
                    width: 326,
                    height: 282,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA0D7C8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'Logo.png',
                        width: 195,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Get organized your life',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF584A4A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'simple and effective\n'
                      'to-do list and task manager app\n'
                      'which helps you manage time\n',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF584A4A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showRegisterModal(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                        decoration: const BoxDecoration(
                          color: Color(0xFFA0D7C8),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'Create Account',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showLoginModal(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFA0D7C8), width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA0D7C8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}