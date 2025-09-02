import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekolah/common/custom_toast.dart';
import 'package:sekolah/common/validators.dart';
import 'package:sekolah/screen/auth/register/service/register_service.dart';

final registerServiceProvider = Provider<RegisterService>((ref) => RegisterService());

class RegisterState {
  final bool isLoading;
  final String? error;
  final bool success;
  RegisterState({this.isLoading = false, this.error, this.success = false});

  RegisterState copyWith({bool? isLoading, String? error, bool? success}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterService _service;
  RegisterNotifier(this._service) : super(RegisterState());

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
    final vName = Validators.validateRequired(name, fieldName: 'Nama');
    final vEmail = Validators.validateEmail(email);
    final vPass = Validators.validatePassword(password);
    final vNik = Validators.validateRequired(nik, fieldName: 'NIK');
    final vSchool = Validators.validateRequired(schoolName, fieldName: 'Nama Sekolah');
    final vLevel = Validators.validateRequired(schoolLevel, fieldName: 'Tingkat Sekolah');

    if (vName != null) return ToastHelper.showError(vName);
    if (vEmail != null) return ToastHelper.showError(vEmail);
    if (vPass != null) return ToastHelper.showError(vPass);
    if (vNik != null) return ToastHelper.showError(vNik);
    if (vSchool != null) return ToastHelper.showError(vSchool);
    if (vLevel != null) return ToastHelper.showError(vLevel);

    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.registerTeacher(
        name: name,
        email: email,
        password: password,
        nik: nik,
        nuptk: nuptk,
        schoolName: schoolName,
        schoolLevel: schoolLevel,
        isSlb: isSlb,
      );

      state = state.copyWith(isLoading: false, success: true);
      ToastHelper.showSuccess('Registrasi berhasil. Silakan login.');
    } catch (e) {
      final msg = e is Exception ? Validators.parseApiError(e) : 'Terjadi kesalahan';
      state = state.copyWith(isLoading: false, error: msg);
      ToastHelper.showError(msg);
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>(
  (ref) => RegisterNotifier(ref.read(registerServiceProvider)),
);
