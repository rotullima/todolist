import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreen();
}

class _MyProfileScreen extends State<MyProfileScreen> {
  DateTime? tanggalTerpilih;
  TimeOfDay? waktuTerpilih;

  String get formatTanggal {
    if (tanggalTerpilih == null) return '';
    return DateFormat('MMMM d,yyyy').format(tanggalTerpilih!);
  }

  String get formatWaktu {
    if (waktuTerpilih == null) return '';
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, waktuTerpilih!.hour,
        waktuTerpilih!.minute);
    return DateFormat('HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                          'Profil',
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
                            // color: Colors.black,
                            size: 70,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Richo Ferdinand',
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Slow Living',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Malang',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF584A4A),
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
                    "My Bio",
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
                          "Richo Ferdinand",
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
                          "Slow Living | Malang",
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
                  GestureDetector(
                    onTap: () async {
                      final DateTime? terpilih = await showDatePicker(
                        context: context,
                        initialDate: tanggalTerpilih ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (terpilih != null) {
                        setState(() {
                          tanggalTerpilih = terpilih;
                        });
                      }
                    },
                   child: Container(
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
                        Icon(
                          Icons.calendar_month_outlined,
                        ),
                        Text(
                          formatTanggal.isEmpty ? "Select your birth date" : formatTanggal,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF584A4A),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Number Phone",
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
                          "087878456321",
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
          ],
        ),
      ),
    );
  }
}
