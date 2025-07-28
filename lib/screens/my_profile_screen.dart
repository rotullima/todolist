import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

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
                              shape: BoxShape.circle, color: Colors.white),
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
                  Text(
                    "Edit Profil",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF584A4A),
                    ),
                  ),
                  Text(
                    "Name",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF584A4A),
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                    color: Color(0xFFA0D7C8),
                    borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Richo Ferdinand",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF584A4A),
                    ),
                    ),
                  ),
                  Text(
                    "Bio",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF584A4A),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                    color: Color(0xFFA0D7C8),
                    borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Slow Living | Malang",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF584A4A),
                      ),
                      ),
                  ),
                  Text(
                    "Birth Date",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF584A4A),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                    color: Color(0xFFA0D7C8),
                    borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "June, 11, 2008",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF584A4A),
                      ),
                      ),
                  ),
                  Text(
                    "Number Phone",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF584A4A),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                    color: Color(0xFFA0D7C8),
                    borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "087878456321",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF584A4A),
                      ),
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
