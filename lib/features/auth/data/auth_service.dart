import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/features/auth/domain/user.dart';

class AuthService {
  // ========== LOGIN ==========
  Future<User> signIn(String email, String password) async {
    try {
      final Uri uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.signinEndpoint}');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return User.fromJson(json);
      } else {
        final Map<String, dynamic> err = jsonDecode(response.body);
        throw Exception(err['message'] ?? 'Error al iniciar sesión (${response.statusCode})');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // ========== SIGNUP ==========
  Future<User> signUp(String email, String password) async {
    try {
      final Uri uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.signupEndpoint}');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return User.fromJson(json);
      } else {
        final Map<String, dynamic> err = jsonDecode(response.body);
        throw Exception(err['message'] ?? 'Error al registrar usuario (${response.statusCode})');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
