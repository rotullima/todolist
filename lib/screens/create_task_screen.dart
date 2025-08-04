import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final List<String> listKategori = [
    'Religius',
    'Personal',
    'Healthy',
    'Shopping',
    'Work',
    'Other'
  ];
  final List<String> listPrioritas = [
    'High',
    'Mid',
    'Low',
  ];
  String? kategoriTerpilih;
  String? prioritasTerpilih;

  DateTime? tanggalTerpilih;
  TimeOfDay? waktuTerpilih;

  String get formatTanggal {
    if (tanggalTerpilih == null) return '';
    return DateFormat('MMMM d, yyyy')
        .format(tanggalTerpilih!); // Format cth: July 27, 2025
  }

  String get formatWaktu {
    if (waktuTerpilih == null) return '';
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, waktuTerpilih!.hour,
        waktuTerpilih!.minute);
    return DateFormat('HH:mm').format(dt); // Format cth: 12:00
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian atas (judul + tanggal)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA0D7C8), Color(0xFFA0C7D7)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Add New Task',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
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

            // Form Code
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TASK TITLE
                      Text(
                        "Task Title",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF584A4A),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          hintText: "Input your task title",
                          hintStyle: GoogleFonts.poppins(fontSize: 20, color: Color(0xFF584A4A),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xFFA0D7C8),
                          filled: true,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10),
                
                      // KATEGORI
                      Text(
                        "Category",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF584A4A),
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: kategoriTerpilih,
                        hint: Text(
                          "Select Category",
                          style: GoogleFonts.poppins(fontSize: 18, color: Color(0xFF584A4A),),
                        ),
                        items: listKategori.map(
                          (String kategori) {
                            return DropdownMenuItem(
                              value: kategori,
                              child: Text(
                                kategori,
                                style: GoogleFonts.poppins(fontSize: 20),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            kategoriTerpilih = value;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Color(0xFFA0D7C8),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      SizedBox(height: 10),
                
                      // PRIORITAS
                      Text(
                        "Priority",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF584A4A),
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: prioritasTerpilih,
                        hint: Text(
                          "Select Priority",
                          style: GoogleFonts.poppins(fontSize: 18, color: Color(0xFF584A4A),),
                        ),
                        items: listPrioritas.map(
                          (String prioritas) {
                            return DropdownMenuItem(
                              value: prioritas,
                              child: Text(
                                prioritas,
                                style: GoogleFonts.poppins(fontSize: 20),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            prioritasTerpilih = value;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Color(0xFFA0D7C8),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: 
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      SizedBox(height: 10),
                
                      // DATE AND TIME
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF584A4A),
                                  ),
                                ),
                                TextField(
                                  readOnly: true,
                                  controller:
                                      TextEditingController(text: formatTanggal),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFFA0D7C8),
                                    filled: true,
                                    suffixIcon: Icon(Icons.calendar_month),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onTap: () async {
                                    final DateTime? terpilih = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          tanggalTerpilih ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (terpilih != null) {
                                      setState(() {
                                        tanggalTerpilih = terpilih;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF584A4A),
                                  ),
                                ),
                                TextField(
                                  readOnly: true,
                                  controller:
                                      TextEditingController(text: formatWaktu),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFFA0D7C8),
                                    filled: true,
                                    suffixIcon: Icon(Icons.access_time),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onTap: () async {
                                    final TimeOfDay? terpilih =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: waktuTerpilih ?? TimeOfDay.now(),
                                    );
                                    if (terpilih != null) {
                                      setState(() {
                                        waktuTerpilih = terpilih;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                
                      // NOTES
                      SizedBox(height: 10),
                      Text(
                        "Notes",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF584A4A),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Color(0xFF584A4A),
                        ),
                        decoration: InputDecoration(
                          hintText: "Input your notes (optional)",
                          hintStyle: GoogleFonts.poppins(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xFFA0D7C8),
                          filled: true,
                        ),
                        maxLines: 6,
                      ),
                      SizedBox(height: 35),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            showTopSnackBar(context, 'Task Saved Successfully');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF584A4A),
                            backgroundColor: Color(0xFFA0D7C8),
                            padding:
                                EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          child: Text(
                            "Save",
                            style: GoogleFonts.poppins(fontSize: 24, color: Color(0xFF584A4A),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showTopSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        elevation: 10,
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Color(0xFF5DEE4F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF15FF00), width: 4),
          ),
          child: Center(
            child: Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Masukkan overlay-nya
  overlay.insert(overlayEntry);

  // Hapus setelah 2 detik
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
