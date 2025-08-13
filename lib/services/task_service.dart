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

    // Hitung jumlah semua task milik user
    Future<int> getUserTaskCount() async {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final data =
          await supabase.from('tasks').select('id').eq('user_id', user.id);

      return data.length;
    }

    // Hitung jumlah task yang belum selesai
    Future<int> getUserPendingTaskCount() async {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final data = await supabase
          .from('tasks')
          .select('id')
          .eq('user_id', user.id)
          .eq('completed', false);

      return data.length;
    }

  // Hitung jumlah task yang sudah selesai
    Future<int> getUserDoneTaskCount() async {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      final data = await supabase
          .from('tasks')
          .select('id')
          .eq('user_id', user.id)
          .eq('completed', true);

      return data.length;
    }

    // Ambil semua task yang sudah selesai
    Future<List<Map<String, dynamic>>> getUserCompletedTasks() async {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      // Ambil task selesai
      final tasksData = await supabase
          .from('tasks')
          .select('title, due_date, due_time, category_id')
          .eq('user_id', user.id)
          .eq('completed', true)
          .order('created_at', ascending: true);

      // Ambil kategori sekali
      final categoriesData =
          await supabase.from('categories').select('id, name');

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
          'category_icon':
              categoryIcons[categoryName] ?? Icons.category_outlined,
        };
      }).toList();
    }

Future<List<Map<String, dynamic>>> getTasksByDate(String dueDate) async {
  final user = supabase.auth.currentUser;
  if (user == null) throw Exception("User not logged in");

  final tasks = await supabase
      .from('tasks')
      .select()
      .eq('user_id', user.id)
      .eq('due_date', dueDate)
      .order('due_time', ascending: true);

  final categoriesData =
      await supabase.from('categories').select('id, name');
  final categoryMap = {
    for (var c in categoriesData) c['id'].toString(): c['name'] as String
  };

  return tasks.map<Map<String, dynamic>>((task) {
    final categoryName =
        categoryMap[task['category_id'].toString()] ?? 'Other';
    return {
      'title': task['title'],
      'due_date': task['due_date'],
      'due_time': task['due_time'] ?? '',
      'category_icon':
          categoryIcons[categoryName] ?? Icons.category_outlined,
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
      final categoriesData =
          await supabase.from('categories').select('id, name');

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
          'category_icon':
              categoryIcons[categoryName] ?? Icons.category_outlined,
        };
      }).toList();
    }
  }
