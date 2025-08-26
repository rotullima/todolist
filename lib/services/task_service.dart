import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class TaskServices {
  final supabase = Supabase.instance.client;

  // Ambil semua category
  Future<Map<String, String>> getCategories() async {
    final response = await supabase.from('categories').select('id, name');
    return {
      for (var item in response) item['name'] as String: item['id'].toString()
    };
  }

  // Ambil semua priority
  Future<Map<String, String>> getPriorities() async {
    final response = await supabase.from('priorities').select('id, name');
    return {
      for (var item in response) item['name'] as String: item['id'].toString()
    };
  }

  // Simpan task baru
  Future<void> createTask({
    required String title,
    required String categoryId,
    required String priorityId,
    required String dueDate, // format: YYYY-MM-DD
    String? dueTime, // boleh null
    String? notes,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await supabase.from('tasks').insert({
      'user_id': user.id,
      'title': title,
      'category_id': categoryId,
      'priority_id': priorityId,
      'due_date': dueDate,
      'due_time': dueTime,
      'notes': notes,
      'completed': false,
    });
  }

  // Mapping kategori ke icon
  final Map<String, IconData> categoryIcons = {
    'Work': Icons.work_outline,
    'Study': Icons.school_outlined,
    'Personal': Icons.person_outline,
    'Shopping': Icons.shopping_cart_outlined,
    'Other': Icons.category_outlined,
  };

  final Map<String, Color> priorityColors = {
    'High': const Color.fromARGB(255, 237, 150, 150), // merah soft
    'Mid': const Color.fromARGB(255, 244, 218, 132), // kuning soft
    'Low': const Color.fromARGB(255, 149, 223, 153), // hijau soft
  };

  // Hitung jumlah semua task milik user
  Future<int> getUserTaskCount() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final data =
        await supabase.from('tasks').select('id').eq('user_id', user.id);

    return data.length;
  }

  // Hitung jumlah semua task MILIK USER untuk HARI INI
  Future<int> getUserTaskCountToday() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Format tanggal hari ini (YYYY-MM-DD)
    final today = DateTime.now();
    final formattedToday =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final data = await supabase
        .from('tasks')
        .select('id')
        .eq('user_id', user.id)
        .eq('due_date', formattedToday); // filter tanggal hari ini

    return data.length;
  }

  // Hitung jumlah task yang belum selesai
  Future<int> getUserPendingTaskCount() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Ambil tanggal hari ini dalam format YYYY-MM-DD
    final today = DateTime.now();
    final formattedToday =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final data = await supabase
        .from('tasks')
        .select('id')
        .eq('user_id', user.id)
        .eq('completed', false)
        .eq('due_date', formattedToday); // filter hanya hari ini

    return data.length;
  }

  // Hitung jumlah task yang sudah selesai
  Future<int> getUserDoneTaskCount() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Format tanggal hari ini (YYYY-MM-DD)
    final today = DateTime.now();
    final formattedToday =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final data = await supabase
        .from('tasks')
        .select('id')
        .eq('user_id', user.id)
        .eq('completed', true)
        .eq('due_date', formattedToday); // filter tanggal hari ini

    return data.length;
  }

  // Ambil semua task yang sudah selesai
  Future<List<Map<String, dynamic>>> getUserCompletedTasks() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Ambil task selesai, termasuk notes
    final tasksData = await supabase
        .from('tasks')
        .select('title, due_date, due_time, category_id, priority_id, notes')
        .eq('user_id', user.id)
        .eq('completed', true)
        .order('created_at', ascending: true);

    // Ambil kategori sekali
    final categoriesData = await supabase.from('categories').select('id, name');
    final categoryMap = {
      for (var c in categoriesData) c['id'].toString(): c['name'] as String
    };

    final prioritiesData = await supabase.from('priorities').select('id, name');
    final priorityMap = {
      for (var p in prioritiesData) p['id'].toString(): p['name'] as String
    };

    return tasksData.map<Map<String, dynamic>>((task) {
      final categoryName =
          categoryMap[task['category_id'].toString()] ?? 'Other';
      final priorityName = priorityMap[task['priority_id'].toString()] ?? 'Low';

      return {
        'title': task['title'],
        'due_date': task['due_date'],
        'due_time': task['due_time'],
        'category_icon': categoryIcons[categoryName] ?? Icons.category_outlined,
        'priority': priorityName,
        'notes': task['notes'],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getUserCompletedTasksByDate(
      String dueDate) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final tasksData = await supabase
        .from('tasks')
        .select('title, due_date, due_time, category_id, priority_id, notes')
        .eq('user_id', user.id)
        .eq('completed', true) // cuma yang selesai
        .eq('due_date', dueDate) // filter tanggal
        .order('due_time', ascending: true);

    final categoriesData = await supabase.from('categories').select('id, name');
    final categoryMap = {
      for (var c in categoriesData) c['id'].toString(): c['name'] as String
    };

    final prioritiesData = await supabase.from('priorities').select('id, name');
    final priorityMap = {
      for (var p in prioritiesData) p['id'].toString(): p['name'] as String
    };

    return tasksData.map<Map<String, dynamic>>((task) {
      final categoryName =
          categoryMap[task['category_id'].toString()] ?? 'Other';
      final priorityName = priorityMap[task['priority_id'].toString()] ?? 'Low';

      return {
        'title': task['title'],
        'due_date': task['due_date'],
        'due_time': task['due_time'],
        'category_icon': categoryIcons[categoryName] ?? Icons.category_outlined,
        'priority': priorityName,
        'notes': task['notes'],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getTasksByDate(String dueDate) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    final tasks = await supabase
        .from('tasks')
        .select('title, due_date, due_time, category_id, priority_id, notes')
        .eq('user_id', user.id)
        .eq('due_date', dueDate)
        .order('due_time', ascending: true);

    final categoriesData = await supabase.from('categories').select('id, name');
    final categoryMap = {
      for (var c in categoriesData) c['id'].toString(): c['name'] as String
    };

    final prioritiesData = await supabase.from('priorities').select('id, name');
    final priorityMap = {
      for (var p in prioritiesData) p['id'].toString(): p['name'] as String
    };

    return tasks.map<Map<String, dynamic>>((task) {
      final categoryName =
          categoryMap[task['category_id'].toString()] ?? 'Other';
      final priorityName = priorityMap[task['priority_id'].toString()] ?? 'Low';
      return {
        'title': task['title'],
        'due_date': task['due_date'],
        'due_time': task['due_time'] ?? '',
        'category_icon': categoryIcons[categoryName] ?? Icons.category_outlined,
        'priority': priorityName,
        'notes': task['notes'],
      };
    }).toList();
  }

  // Ambil semua task yang belum selesai
  Future<List<Map<String, dynamic>>> getUserPendingTasks() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    // Ambil task belum selesai
    final tasksData = await supabase
        .from('tasks')
        .select('title, due_date, due_time, category_id')
        .eq('user_id', user.id)
        .eq('completed', false);

    // Ambil kategori sekali
    final categoriesData = await supabase.from('categories').select('id, name');

    final categoryMap = {
      for (var c in categoriesData) c['id'].toString(): c['name'] as String
    };

    return tasksData.map<Map<String, dynamic>>((task) {
      final categoryName =
          categoryMap[task['category_id'].toString()] ?? 'Other';
      return {
        'title': task['title'],
        'due_date': task['due_date'],
        'due_time': task['due_time'],
        'category_icon': categoryIcons[categoryName] ?? Icons.category_outlined,
      };
    }).toList();
  }
}
