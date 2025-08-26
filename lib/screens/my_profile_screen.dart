import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todolist/screens/auth/splash_screen.dart';
import 'package:todolist/services/auth_services.dart';

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
      await _fetchUserProfile();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Profile saved successfully!",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF4CAF50),
          duration: const Duration(seconds: 1),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.03,
                      ),
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
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Profile',
                                  style: GoogleFonts.poppins(
                                    fontSize: isSmallScreen ? 20 : 24,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF584A4A),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Container(
                                  width: screenWidth * 0.2,
                                  height: screenWidth * 0.2,
                                  decoration: const BoxDecoration(
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
                                  child: const Icon(
                                    Icons.account_circle_outlined,
                                    size: 70,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  userProfile?['name'] ?? 'No Name',
                                  style: GoogleFonts.poppins(
                                    fontSize: isSmallScreen ? 22 : 26,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF584A4A),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
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
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          elevation: 10,
                                          backgroundColor: Colors.transparent,
                                          child: FractionallySizedBox(
                                            widthFactor: isSmallScreen ? 0.9 : 0.7,
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFA0D7C8),
                                                borderRadius: BorderRadius.circular(20),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Edit Profile",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: isSmallScreen ? 20 : 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.02),
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
                                                        borderSide: const BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                        borderSide: const BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.015),
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
                                                        borderSide: const BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                        borderSide: const BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.015),
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
                                                          borderSide: const BorderSide(
                                                            color: Colors.white,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                          borderSide: const BorderSide(
                                                            color: Colors.white,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.015),
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
                                                        borderSide: const BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                        borderSide: const BorderSide(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.02),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      await _updateUserProfile(
                                                        name: nameController.text,
                                                        bio: bioController.text,
                                                        birthDate: tanggalTerpilih?.toIso8601String(),
                                                        phoneNumber: phoneController.text,
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: const Color(0xFF4CAF50),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                      ),
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: screenWidth * 0.08,
                                                        vertical: screenHeight * 0.015,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Save",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: isSmallScreen ? 12 : 14,
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
                                      fontSize: isSmallScreen ? 16 : 20,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF584A4A),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.06),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    // Profile Details Section
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Profile",
                            style: GoogleFonts.poppins(
                              fontSize: isSmallScreen ? 18 : 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF584A4A),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildProfileField(
                            context,
                            label: "Name",
                            value: userProfile?['name'] ?? 'No Name',
                            icon: Icons.person_2_outlined,
                            isSmallScreen: isSmallScreen,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildProfileField(
                            context,
                            label: "Bio",
                            value: userProfile?['bio'] ?? 'No Bio',
                            icon: Icons.description_outlined,
                            isSmallScreen: isSmallScreen,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildProfileField(
                            context,
                            label: "Birth Date",
                            value: userProfile?['tanggal_lahir'] != null
                                ? DateFormat('dd MMMM yyyy')
                                    .format(DateTime.parse(userProfile!['tanggal_lahir']))
                                : 'Not set',
                            icon: Icons.calendar_month_outlined,
                            isSmallScreen: isSmallScreen,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildProfileField(
                            context,
                            label: "Phone Number",
                            value: userProfile?['nomer_hp'] ?? 'Not set',
                            icon: Icons.smartphone_outlined,
                            isSmallScreen: isSmallScreen,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
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
                                  fontSize: isSmallScreen ? 17 : 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: Text(
                                "Are you sure you want to log out?",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: isSmallScreen ? 16 : 18,
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
                                      fontSize: isSmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await authServices.signOut();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => const SplashScreen()),
                                      (Route<dynamic> route) => false,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Logged out successfully.",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: isSmallScreen ? 15 : 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        backgroundColor: Colors.redAccent,
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Log Out",
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: isSmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: Text(
                          "Log Out",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.015,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProfileField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required bool isSmallScreen,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isSmallScreen ? 18 : 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF584A4A),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          width: double.infinity,
          height: isSmallScreen ? 45 : 50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: screenWidth * 0.04),
          decoration: BoxDecoration(
            color: const Color(0xFFA0D7C8).withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF584141),
                size: isSmallScreen ? 22 : 25,
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF584A4A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}