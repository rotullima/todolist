import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    print('Memulai login untuk email: $email');
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print('Login berhasil, user ID: ${response.user?.id}');
      final userId = response.user?.id;
      if (userId != null) {
        final profile = await _supabase
            .from('profiles')
            .select()
            .eq('id', userId)
            .maybeSingle();
        if (profile == null) {
          print('Membuat profil default...');
          await _supabase.from('profiles').insert({
            'id': userId,
            'name': '',
            'bio': '',
            'tanggal_lahir': null,
            'nomer_hp': '',
          });
          print('Profil default dibuat');
        }
      }
      return response;
    } catch (e) {
      print('Error saat login: $e');
      throw Exception('Gagal login: ${e.toString()}');
    }
  }

  Future<AuthResponse> signUpWithEmail(
    String email,
    String password,
    String name,
    String bio,
    String? tanggalLahir,
    String nomerHp,
  ) async {
    print('Memulai pendaftaran untuk email: $email');
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'bio': bio,
          'tanggal_lahir': tanggalLahir,
          'nomerHp': nomerHp,
        },
      );
      print('Pendaftaran auth berhasil, user ID: ${response.user?.id}');
      // Trigger akan menangani insert ke profiles
      return response;
    } catch (e) {
      print('Error saat pendaftaran: $e');
      throw Exception('Gagal mendaftar: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      print('Logout berhasil');
    } catch (e) {
      print('Error saat logout: $e');
      throw Exception('Gagal logout: ${e.toString()}');
    }
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId != null) {
      print('Mengambil profil untuk user ID: $userId');
      return await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
    }
    print('Tidak ada user ID, profil tidak diambil');
    return null;
  }
}
