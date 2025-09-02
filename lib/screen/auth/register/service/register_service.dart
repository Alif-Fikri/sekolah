import 'package:dio/dio.dart';
import 'package:sekolah/services/dio_client.dart';

class RegisterService {
  final Dio _dio = DioClient().client;

  Future<void> registerTeacher({
    required String name,
    required String email,
    required String password,
    required String nik,
    String? nuptk,
    required String schoolName,
    required String schoolLevel,
    required bool isSlb,
  }) async {
    try {
      final resp = await _dio.post('/guru/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'nik': nik,
        'nuptk': nuptk,
        'schoolName': schoolName,
        'schoolLevel': schoolLevel,
        'isSLB': isSlb,
      });

      final body = resp.data;
      if (body is Map && (body['status'] == 'error' || resp.statusCode! >= 400)) {
        final msg = (body['message'] ?? body['error'] ?? 'Gagal registrasi').toString();
        throw Exception(msg);
      }

      return;
    } on DioException catch (e) {
      String? message = 'Gagal melakukan request';
      final r = e.response?.data;
      if (r != null) {
        if (r is Map && (r['message'] != null || r['error'] != null)) {
          message = (r['message'] ?? r['error']).toString();
        } else if (r is String && r.isNotEmpty) {
          message = r;
        } else {
          message = e.response?.statusMessage ?? e.message;
        }
      } else {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          message = 'Koneksi timeout. Periksa jaringan Anda';
        } else {
          message = e.message;
        }
      }
      throw Exception(message);
    } catch (e) {
      rethrow;
    }
  }
}
