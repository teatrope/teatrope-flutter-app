// features/notifications/data/notifications_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/features/notifications/domain/notifications_preferences.dart';
class NotificationsService {
  final http.Client _client;
  NotificationsService({http.Client? client}) : _client = client ?? http.Client();

  Future<NotificationPreferences> getPreferences({required String token}) async {
    if (token.isEmpty) {
      throw Exception('Token vacío: inicia sesión.');
    }

    // ⚠️ Evitamos concatenaciones que puedan provocar redirect
    // Si tu ApiConstants.baseUrl es "https://host/api/", extraemos host y path.
    final base = Uri.parse(ApiConstants.baseUrl); // ej: https://.../api/
    final uri = Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.hasPort ? base.port : null,
      path: _joinPaths(base.path, 'notifications/preferencias/'), // => /api/notifications/preferencias/
    );

    // Logs mínimos
    print('[NotificationsService] GET $uri');
    print('[NotificationsService] token(head): ${token.substring(0, token.length > 6 ? 6 : token.length)}***');

    // Algunos stacks sólo aceptan 'Authorization' con mayúscula
    final headers = <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Token $token',
      // duplicado por si acaso (hay servers que pierden mayúsculas en el pipeline)
      'authorization': 'Token $token',
    };

    final resp = await _client.get(uri, headers: headers);
    print('[NotificationsService] Status: ${resp.statusCode}');

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final body = jsonDecode(resp.body);
      final Map<String, dynamic> json =
          (body is List && body.isNotEmpty) ? (body.first as Map<String, dynamic>)
                                           : (body as Map<String, dynamic>);
      return NotificationPreferences.fromJson(json);
    }

    // Ayuda a depurar: muestra exactamente lo que respondió la API
    throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
  }

  String _joinPaths(String a, String b) {
    final left = a.endsWith('/') ? a : '$a/';
    final right = b.startsWith('/') ? b.substring(1) : b;
    return '$left$right';
  }
}
