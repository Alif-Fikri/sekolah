import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sekolah/common/api_exception.dart';
import 'package:sekolah/model/auth_response.dart';
import 'package:sekolah/services/dio_client.dart';

class LoginService {
  final Dio _dio = DioClient().client;

  Future<AuthResponse> login(String email, String password) async {
    try {
      final Response resp = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      final dynamic body = resp.data;
      Map<String, dynamic> payload;

      if (body is Map<String, dynamic>) {
        if (body.containsKey('data') && body['data'] is Map) {
          payload = Map<String, dynamic>.from(body['data']);
        } else {
          payload = Map<String, dynamic>.from(body);
        }
      } else if (body is String) {
        payload = Map<String, dynamic>.from(jsonDecode(body) as Map);
      } else {
        throw ApiException(
          'Format response tidak dikenali',
          statusCode: resp.statusCode,
        );
      }

      final token = payload['token'] ?? payload['access_token'];
      if (token == null) {
        throw ApiException(
          payload['message'] ?? 'Token tidak ditemukan',
          statusCode: resp.statusCode,
        );
      }

      return AuthResponse.fromMap(payload);
    } on DioException catch (e) {
      String? message = 'Gagal melakukan request';
      int? status = e.response?.statusCode;

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

      throw ApiException(message!, statusCode: status ?? 0);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
