// features/auth/data/auth_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';

class User {
  final String id;
  final String email;
  final String tipoRol;

  const User({required this.id, required this.email, required this.tipoRol});

  factory User.fromJson(Map<String, dynamic> j) => User(
    id: (j['id'] ?? '').toString(),
    email: (j['email'] ?? '').toString(),
    tipoRol: (j['tipo_rol'] ?? '').toString(),
  );
}

class AuthService {
  final http.Client _client;
  final TokenStorage _storage;

  AuthService({http.Client? client, TokenStorage? storage})
    : _client = client ?? http.Client(),
      _storage = storage ?? TokenStorage();

  Future<User> signIn(String email, String password) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.signinEndpoint}',
    );
    final resp = await _client.post(
      uri,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (resp.statusCode == HttpStatus.ok ||
        resp.statusCode == HttpStatus.created) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      final token = (json['token'] ?? json['auth_token'] ?? '').toString();
      if (token.isEmpty) {
        throw Exception('No se recibió token en el login.');
      }
      await _storage.save(token);

      // Si tu endpoint devuelve user dentro:
      final userJson = (json['user'] ?? {}) as Map<String, dynamic>;
      final user = User.fromJson(userJson);

      if (user.id.isNotEmpty) {
        await _storage.saveUserId(user.id);
      }

      return user;
    }

    throw Exception(
      'Login falló: ${resp.statusCode} ${resp.reasonPhrase}\n${resp.body}',
    );
  }

  Future<void> signUp(String email, String password) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.signupEndpoint}',
    );
    final resp = await _client.post(
      uri,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (resp.statusCode == HttpStatus.ok ||
        resp.statusCode == HttpStatus.created) {
      return;
    }
    throw Exception(
      'Registro falló: ${resp.statusCode} ${resp.reasonPhrase}\n${resp.body}',
    );
  }

  Future<void> signOut() async => _storage.clear();

  Future<Map<String, String>> getAuthHeader({bool bearer = false}) async {
    final token = await _storage.read();
    if (token == null || token.isEmpty) throw Exception('No autenticado.');
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: bearer
          ? 'Bearer $token'
          : 'Token $token',
    };
  }
}
