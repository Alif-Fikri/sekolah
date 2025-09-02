import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekolah/common/custom_toast.dart';
import 'package:sekolah/common/validators.dart';
import 'package:sekolah/model/auth_response.dart';
import 'package:sekolah/screen/auth/login/service/login_service.dart';

final loginServiceProvider = Provider<LoginService>((ref) => LoginService());

class AuthState {
  final bool isLoading;
  final AuthResponse? auth;
  final String? error;

  AuthState({this.isLoading = false, this.auth, this.error});

  AuthState copyWith({bool? isLoading, AuthResponse? auth, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      auth: auth ?? this.auth,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginService _service;
  AuthNotifier(this._service) : super(AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _service.login(email, password);
      final box = Hive.box('auth');
      await box.put('token', res.token);
      await box.put('role', res.role);
      state = state.copyWith(isLoading: false, auth: res);
      ToastHelper.showSuccess('Login berhasil');
    } catch (e) {
      final msg = Validators.parseApiError(e);
      state = state.copyWith(isLoading: false, error: msg);
      ToastHelper.showError(msg);
    }
  }

  void logout() {
    final box = Hive.box('auth');
    box.delete('token');
    box.delete('role');
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.read(loginServiceProvider)),
);
