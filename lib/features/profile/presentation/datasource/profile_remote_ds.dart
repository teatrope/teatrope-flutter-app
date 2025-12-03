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
  static const _kUserPasswordKey = 'user_password';

  Future<String?> _getSavedEmail() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kUserEmailKey);
  }

  // =================== GET PROFILE ===================
  Future<UserProfile> fetchProfile() async {
    final token = await _tokenStorage.read();
    if (token == null || token.isEmpty) {
      throw Exception('No autenticado');
    }

    final userId = await _tokenStorage.readUserId();
    if (userId == null || userId.isEmpty) {
      throw Exception('User ID no encontrado');
    }

    final endpoint =
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}$userId/';

    final response = await _dio.get(
      endpoint,
      options: Options(
        headers: {
          'Authorization': 'Token $token',
          'Accept': 'application/json',
        },
      ),
    );

    final data = response.data;

    if (data is Map) {
      return UserProfile.fromJson(Map<String, dynamic>.from(data));
    }

    throw Exception('Respuesta inesperada de /auth/users/$userId/');
  }

  // =================== UPDATE PROFILE ===================
  Future<UserProfile> updateProfile(UserProfile profile) async {
    final token = await _tokenStorage.read();
    if (token == null || token.isEmpty) {
      throw Exception('No autenticado');
    }

    // Si no tenemos id, lo obtenemos primero
    String id = profile.id;
    if (id.isEmpty) {
      final current = await fetchProfile();
      id = current.id;
    }

    final endpoint =
        '${ApiConstants.baseUrl}${ApiConstants.userDetailEndpoint.replaceAll('{id}', id)}';

    // Enviamos solo los campos editables
    final body = <String, dynamic>{
      'name': profile.name,
      'email': profile.email,
      'avatar_url': profile.avatarUrl,
      'phone': profile.phone,
      'city': profile.city,
    };

    final response = await _dio.patch(
      endpoint,
      data: body,
      options: Options(
        headers: {
          'Authorization': 'Token $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    final updatedJson = response.data as Map<String, dynamic>;

    // Si cambió el email, lo guardamos también en local
    final sp = await SharedPreferences.getInstance();
    if (updatedJson['email'] != null) {
      await sp.setString(_kUserEmailKey, updatedJson['email'] as String);
    }

    return UserProfile.fromJson(updatedJson);
  }

  // =================== UPDATE PASSWORD ===================
  Future<void> updatePassword(String newPassword) async {
    final token = await _tokenStorage.read();
    if (token == null || token.isEmpty) {
      throw Exception('No autenticado');
    }

    // Necesitamos el id del usuario actual
    final profile = await fetchProfile();
    final endpoint =
        '${ApiConstants.baseUrl}${ApiConstants.userDetailEndpoint.replaceAll('{id}', profile.id)}';

    await _dio.patch(
      endpoint,
      data: {'password': newPassword},
      options: Options(
        headers: {
          'Authorization': 'Token $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Guardamos la nueva contraseña en local (solo para este proyecto)
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kUserPasswordKey, newPassword);
  }

  // =================== PREFERENCIAS (LOCAL) ===================
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

  // =================== LOGOUT / CLEAR SESSION ===================
  Future<void> clearSession() async {
    await _tokenStorage.clear();
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kPrefsKey);
    await sp.remove(_kUserEmailKey);
    await sp.remove(_kUserPasswordKey);
  }

  // =================== HELPERS ===================
  Map<String, dynamic> _decode(String source) {
    return Map<String, dynamic>.from(
      (jsonDecode(source) as Map<String, dynamic>),
    );
  }

  String _encode(Map<String, dynamic> map) {
    return jsonEncode(map);
  }
}
