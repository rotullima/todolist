import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/task_service.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  // Controllers untuk TextField
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Variabel untuk dropdown dan date/time
  Map<String, String> mapKategori = {}; // key: name, value: id (UUID)
  Map<String, String> mapPrioritas = {}; // key: name, value: id (UUID)
  String? kategoriNameTerpilih;
  String? prioritasNameTerpilih;
  DateTime? tanggalTerpilih;
  TimeOfDay? waktuTerpilih;

  // Format tanggal dan waktu
  String get formatTanggal {
    if (tanggalTerpilih == null) return '';
    return DateFormat('MMMM d, yyyy').format(tanggalTerpilih!);
  }

  String get formatWaktu {
    if (waktuTerpilih == null) return '';
    return waktuTerpilih!.format(context);
  }

  final taskService = TaskServices();

  @override
  void initState() {
    super.initState();
    // _fetchCategories();
    // _fetchPriorities();
    _loadDropdownData();
    _dateController.text = formatTanggal;
    _timeController.text = formatWaktu;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // Fetch categories dari Supabase
  Future<void> _loadDropdownData() async {
    try {
      final categories = await taskService.getCategories();
      final priorities = await taskService.getPriorities();
      setState(() {
        mapKategori = categories;
        mapPrioritas = priorities;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load categories: $e')),
      );
    }
  }

bool _validateTask() {
  if (_titleController.text.isEmpty) {
    _showValidationDialog('Task title is required');
    return false;
  }
  if (kategoriNameTerpilih == null) {
    _showValidationDialog('Please select a category');
    return false;
  }
  if (prioritasNameTerpilih == null) {
    _showValidationDialog('Please select a priority');
    return false;
  }
  if (tanggalTerpilih == null) {
    _showValidationDialog('Please select a date');
    return false;
  }
  return true; // Waktu opsional
}

// Fungsi popup
void _showValidationDialog(String message) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35, // panjang ke samping
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFA0D7C8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pesan
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF584A4A),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol OK di kanan bawah
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 105,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'OK',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF584A4A),
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
  );
}

  // Simpan task ke Supabase

  Future<void> _saveTask() async {
    if (!_validateTask()) return;

    final categoryId = mapKategori[kategoriNameTerpilih];
    final priorityId = mapPrioritas[prioritasNameTerpilih];

    try {
      // Loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Panggil service
      await taskService.createTask(
        title: _titleController.text,
        categoryId: categoryId!,
        priorityId: priorityId!,
        dueDate: tanggalTerpilih!.toIso8601String().split('T')[0],
        dueTime: waktuTerpilih?.format(context),
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      Navigator.pop(context); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task Saved Successfully'),
          backgroundColor: Color(0xFF5DEE4F),
        ),
      );

      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA0D7C8), Color(0xFFA0C7D7)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
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
                          'Add New Task',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF584A4A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Task Title
                      Text(
                        "Task Title",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF584A4A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _titleController,
                        style: GoogleFonts.poppins(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Input your task title",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF584A4A),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xFFA0D7C8),
                          filled: true,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),

                      // Category
                      Text(
                        "Category",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF584A4A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: kategoriNameTerpilih,
                        hint: Text(
                          "Select Category",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF584A4A),
                          ),
                        ),
                        items: mapKategori.keys.map((String name) {
                          return DropdownMenuItem(
                            value: name,
                            child: Text(
                              name,
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            kategoriNameTerpilih = value;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFA0D7C8),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Priority
                      Text(
                        "Priority",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF584A4A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: prioritasNameTerpilih,
                        hint: Text(
                          "Select Priority",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF584A4A),
                          ),
                        ),
                        items: mapPrioritas.keys.map((String name) {
                          return DropdownMenuItem(
                            value: name,
                            child: Text(
                              name,
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            prioritasNameTerpilih = value;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFA0D7C8),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Date and Time
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF584A4A),
                                  ),
                                ),
                                TextField(
                                  readOnly: true,
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    fillColor: const Color(0xFFA0D7C8),
                                    filled: true,
                                    suffixIcon:
                                        const Icon(Icons.calendar_month),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onTap: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate:
                                          tanggalTerpilih ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        tanggalTerpilih = picked;
                                        _dateController.text = formatTanggal;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF584A4A),
                                  ),
                                ),
                                TextField(
                                  readOnly: true,
                                  controller: _timeController,
                                  decoration: InputDecoration(
                                    fillColor: const Color(0xFFA0D7C8),
                                    filled: true,
                                    suffixIcon: const Icon(Icons.access_time),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onTap: () async {
                                    final TimeOfDay? picked =
                                        await showTimePicker(
                                      context: context,
                                      initialTime:
                                          waktuTerpilih ?? TimeOfDay.now(),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        waktuTerpilih = picked;
                                        _timeController.text = formatWaktu;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Notes
                      const SizedBox(height: 10),
                      Text(
                        "Notes",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF584A4A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _notesController,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFF584A4A),
                        ),
                        decoration: InputDecoration(
                          hintText: "Input your notes (optional)",
                          hintStyle: GoogleFonts.poppins(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color(0xFFA0D7C8),
                          filled: true,
                        ),
                        maxLines: 6,
                      ),
                      const SizedBox(height: 35),
                      Center(
                        child: ElevatedButton(
                          onPressed: _saveTask,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF584A4A),
                            backgroundColor: const Color(0xFFA0D7C8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: const Color(0xFF584A4A),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
