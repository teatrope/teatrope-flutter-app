import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_profile.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';

class ProfileRemoteDataSource {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ProfileRemoteDataSource(this._dio) : _tokenStorage = TokenStorage();

  // claves de SharedPreferences
  static const _kPrefsKey = 'user_preferences';
  static const _kUserEmailKey = 'user_email';

  Future<String?> _getSavedEmail() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kUserEmailKey);
  }

  // =============== AQUÍ VA LO QUE PEGASTE ===============
  Future<UserProfile> fetchProfile() async {
    final token = await _tokenStorage.read();
    if (token == null || token.isEmpty) {
      throw Exception('No autenticado');
    }

    final savedEmail = await _getSavedEmail();

    if (savedEmail == null || savedEmail.isEmpty) {
      throw Exception('No hay email de usuario guardado en la app');
    }

    final response = await _dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}',
      options: Options(
        headers: {
          'Authorization': 'Token $token',
          'Accept': 'application/json',
        },
      ),
    );

    final data = response.data;

    // Si el backend devuelve una LISTA de usuarios
    if (data is List) {
      final list = data.cast<Map<String, dynamic>>();

      final userJson = list.firstWhere(
            (u) {
          final email = (u['email'] ?? '').toString().toLowerCase();
          return email == savedEmail.toLowerCase();
        },
        orElse: () {
          // Si no encuentra el usuario, lanzamos error explícito
          throw Exception(
            'Usuario con email $savedEmail no encontrado en /auth/users/.',
          );
        },
      );

      return UserProfile.fromJson(userJson);
    }

    // Si el backend devuelve UN SOLO usuario (objeto)
    if (data is Map) {
      return UserProfile.fromJson(Map<String, dynamic>.from(data));
    }

    throw Exception('Respuesta inesperada de /auth/users/');
  }
  // ======================= FIN ==========================

  // …y debajo sigues con updateProfile, updatePassword, prefs, etc.

  Future<UserProfile> updateProfile(UserProfile profile) async {
    // tu implementación actual
    // ...
    throw UnimplementedError(); // reemplaza por tu código real
  }

  Future<void> updatePassword(String newPassword) async {
    // tu implementación actual
  }

  Future<UserPreferences> getPreferences() async {
    final sp = await SharedPreferences.getInstance();
    final jsonString = sp.getString(_kPrefsKey);

    if (jsonString == null) {
      return UserPreferences.initial();
    }

    final map = Map<String, dynamic>.from(_decode(jsonString));
    return UserPreferences.fromJson(map);
  }

  Future<UserPreferences> savePreferences(UserPreferences prefs) async {
    final sp = await SharedPreferences.getInstance();
    final jsonString = _encode(prefs.toJson());
    await sp.setString(_kPrefsKey, jsonString);
    return prefs;
  }

  Future<void> clearSession() async {
    await _tokenStorage.clear();
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kPrefsKey);
    await sp.remove(_kUserEmailKey);
  }

  Map<String, dynamic> _decode(String source) {
    return Map<String, dynamic>.from(
      (jsonDecode(source) as Map<String, dynamic>),
    );
  }

  String _encode(Map<String, dynamic> map) {
    return jsonEncode(map);
  }
}
