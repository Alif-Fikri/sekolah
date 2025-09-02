import 'package:dio/dio.dart';
import 'package:sekolah/common/api_exception.dart';

class Validators {
  static String? validateRequired(String? v, {String fieldName = 'Field'}) {
    if (v == null || v.trim().isEmpty) return '$fieldName wajib diisi';
    return null;
  }

  static String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
    final re = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!re.hasMatch(v.trim())) return 'Format email tidak valid';
    return null;
  }

  static String? validatePassword(String? v, {int minLen = 6}) {
    if (v == null || v.isEmpty) return 'Kata sandi wajib diisi';
    if (v.length < minLen) return 'Kata sandi minimal $minLen karakter';
    return null;
  }

  static String parseApiError(Object? error) {
    try {
      if (error == null) return 'Terjadi kesalahan. Silakan coba lagi';

      if (error is String) return error;

      if (error is ApiException) {
        final sc = error.statusCode;
        final msg = error.message;
        if (sc == 401) {
          if (msg.toLowerCase().contains('unauthorized') ||
              msg.toLowerCase().contains('unauth') ||
              msg.toLowerCase().contains('password') ||
              msg.toLowerCase().contains('email')) {
            return 'Email atau kata sandi salah';
          }
          return msg;
        }
        if (sc == 400) {
          return msg;
        }
        return msg;
      }

      if (error is DioException) {
        final r = error.response?.data;
        if (r is Map && r['message'] != null) return r['message'].toString();
        if (r is Map && r['error'] != null) return r['error'].toString();
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.sendTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          return 'Koneksi timeout. Periksa jaringan Anda';
        }
        return error.message ?? 'Terjadi kesalahan koneksi';
      }

      if (error is Map && error['message'] != null) {
        return error['message'].toString();
      }

      return error.toString();
    } catch (_) {
      return 'Terjadi kesalahan. Silakan coba lagi';
    }
  }
}
