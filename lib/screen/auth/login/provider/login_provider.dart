import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekolah/common/custom_toast.dart';
import 'package:sekolah/screen/auth/login/service/login_service.dart';
import 'package:sekolah/model/auth_response.dart';
import 'package:sekolah/common/validators.dart';

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
  final StreamController<void> _refreshController =
      StreamController.broadcast();
  Stream<void> get refreshStream => _refreshController.stream;
  AuthNotifier(this._service) : super(AuthState()) {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final box = await Hive.openBox('auth');
    final token = box.get('token') as String?;
    final role = box.get('role') as String;
    if (token != null) {
      state = state.copyWith(auth: AuthResponse(token: token, role: role));
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _service.login(email, password);
      final box = await Hive.openBox('auth');
      await box.put('token', res.token);
      await box.put('role', res.role);
      state = state.copyWith(isLoading: false, auth: res);
      _refreshController.add(null);
      ToastHelper.showSuccess('Login berhasil');
      return true;
    } catch (e) {
      final msg = Validators.parseApiError(e);
      state = state.copyWith(isLoading: false, error: msg);
      ToastHelper.showError(msg);
      return false;
    }
  }

  Future<void> logout() async {
    final box = await Hive.openBox('auth');
    await box.delete('token');
    await box.delete('role');
    state = AuthState();
    _refreshController.add(null);
  }

  @override
  void dispose() {
    _refreshController.close();
    super.dispose();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.read(loginServiceProvider)),
);
