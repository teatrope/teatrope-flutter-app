import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_profile.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';

class ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSource(this._dio);

  // === PROFILE ===

  Future<UserProfile> fetchProfile() async {
    final token = await _getToken();

    final response = await _dio.get(
      '${ApiConstants.baseUrl}users/me/', // TODO: ajusta endpoint real
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return UserProfile.fromJson(response.data as Map<String, dynamic>);
  }

  Future<UserProfile> updateProfile(UserProfile profile) async {
    final token = await _getToken();

    final response = await _dio.put(
      '${ApiConstants.baseUrl}users/me/', // TODO: ajusta endpoint real
      data: profile.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return UserProfile.fromJson(response.data as Map<String, dynamic>);
  }

  // === PREFERENCES (guardadas en local con SharedPreferences) ===

  static const _kPrefsKey = 'user_preferences';

  Future<UserPreferences> getPreferences() async {
    final sp = await SharedPreferences.getInstance();
    final jsonString = sp.getString(_kPrefsKey);

    if (jsonString == null) {
      return UserPreferences.initial();
    }

    final map = Map<String, dynamic>.from(
      // ignore: deprecated_member_use
      _decode(jsonString),
    );
    return UserPreferences.fromJson(map);
  }

  Future<UserPreferences> savePreferences(UserPreferences prefs) async {
    final sp = await SharedPreferences.getInstance();
    final jsonString = _encode(prefs.toJson());
    await sp.setString(_kPrefsKey, jsonString);
    return prefs;
  }

  Future<void> clearSession() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('access_token');
    await sp.remove(_kPrefsKey);
  }

  // === Helpers ===

  Future<String?> _getToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString('access_token');
  }

  // Encoders simples para evitar dependencias extras
  Map<String, dynamic> _decode(String source) {
    return Map<String, dynamic>.from(
      // ignore: unnecessary_cast
      (jsonDecode(source) as Map<String, dynamic>),
    );
  }

  String _encode(Map<String, dynamic> map) {
    return jsonEncode(map);
  }
}
