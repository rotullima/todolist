import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:projek2_aplikasi_todolist/screens/auth/splash_screen.dart';
import 'package:projek2_aplikasi_todolist/services/auth_services.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreen();
}

class _MyProfileScreen extends State<MyProfileScreen> {
  DateTime? tanggalTerpilih;
  TimeOfDay? waktuTerpilih;
  final AuthServices authServices = AuthServices();
  Map<String, dynamic>? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user profile from AuthServices
  Future<void> _fetchUserProfile() async {
    try {
      final profile = await authServices.getUserProfile();
      setState(() {
        userProfile = profile;
        isLoading = false;
        if (profile != null && profile['tanggal_lahir'] != null) {
          tanggalTerpilih = DateTime.parse(profile['tanggal_lahir']);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load profile: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // Update user profile using AuthServices
  Future<void> _updateUserProfile({
    required String name,
    required String bio,
    required String? birthDate,
    required String phoneNumber,
  }) async {
    try {
      await authServices.updateUserProfile(
        name: name,
        bio: bio,
        tanggalLahir: birthDate,
        nomerHp: phoneNumber,
      );
      await _fetchUserProfile(); // Refresh profile data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Profile saved successfully!",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          backgroundColor: Color(0xFF4CAF50),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  String get formatTanggal {
    if (tanggalTerpilih == null) return 'Not set';
    return DateFormat('MMMM d, yyyy').format(tanggalTerpilih!);
  }

  String get formatWaktu {
    if (waktuTerpilih == null) return 'Not set';
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, waktuTerpilih!.hour, waktuTerpilih!.minute);
    return DateFormat('HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bagian atas (judul + tanggal)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    decoration: const BoxDecoration(
                      color: Color(0xFFA0D7C8),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Profile',
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF584A4A),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  size: 70,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                userProfile?['name'] ?? 'No Name',
                                style: GoogleFonts.poppins(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF584A4A),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final nameController = TextEditingController(
                                          text: userProfile?['name'] ?? '');
                                      final bioController = TextEditingController(
                                          text: userProfile?['bio'] ?? '');
                                      final phoneController = TextEditingController(
                                          text: userProfile?['nomer_hp'] ?? '');
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        elevation: 10,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          width: 250,
                                          height: 450,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFA0D7C8),
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 10,
                                                offset: Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: Card(
                                            color: Color(0xFFA0D7C8),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Edit Profile",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    hintText: "Enter name",
                                                    hintStyle: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                    labelText: "Name",
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                TextField(
                                                  controller: bioController,
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    hintText: "Enter bio",
                                                    hintStyle: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                    labelText: "Bio",
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                GestureDetector(
                                                  child: TextField(
                                                    readOnly: true,
                                                    controller: TextEditingController(
                                                      text: formatTanggal,
                                                    ),
                                                    onTap: () async {
                                                      final DateTime? terpilih =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate: tanggalTerpilih ??
                                                            DateTime.now(),
                                                        firstDate: DateTime(2000),
                                                        lastDate: DateTime(2100),
                                                      );
                                                      if (terpilih != null) {
                                                        setState(() {
                                                          tanggalTerpilih = terpilih;
                                                        });
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      hintText: "Select birth date",
                                                      hintStyle: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                      labelText: "Birth Date",
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                TextField(
                                                  controller: phoneController,
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    hintText: "Enter phone number",
                                                    hintStyle: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                    labelText: "Phone Number",
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    _updateUserProfile(
                                                      name: nameController.text,
                                                      bio: bioController.text,
                                                      birthDate: tanggalTerpilih?.toIso8601String(),
                                                      phoneNumber: phoneController.text,
                                                    );
                                                    setState(() {});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xFF4CAF50),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 10,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Save",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Edit Profile',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF584A4A),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "My Profile",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Name",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA0D7C8).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person_2_outlined,
                                color: Color(0xFF584141),
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                userProfile?['name'] ?? 'No Name',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF584A4A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Bio",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFFA0D7C8).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.description_outlined,
                                color: Color(0xFF584141),
                                size: 25,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                userProfile?['bio'] ?? 'No Bio',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF584A4A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Birth Date",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFFA0D7C8).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: Color(0xFF584141),
                                size: 25,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                userProfile?['tanggal_lahir'] != null
                                    ? DateFormat('dd MMMM yyyy')
                                        .format(DateTime.parse(userProfile!['tanggal_lahir']))
                                    : 'Not set',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF584A4A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Phone Number",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 400,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            color: Color(0xFFA0D7C8).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.smartphone_outlined,
                                color: Color(0xFF584141),
                                size: 25,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                userProfile?['nomer_hp'] ?? 'Not set',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF584A4A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Log Out",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            content: Text(
                              "Are you sure you want to log out?",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await authServices.signOut();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => SplashScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Logged out successfully.",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Log Out",
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        "Log Out",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}