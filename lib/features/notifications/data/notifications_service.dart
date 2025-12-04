// features/notifications/data/notifications_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/notifications/domain/notification_model.dart';

class NotificationsService {
  final http.Client _client;
  NotificationsService({http.Client? client})
    : _client = client ?? http.Client();

  Future<List<NotificationModel>> getNotifications({
    required String token,
  }) async {
    if (token.isEmpty) throw Exception('Token vacío: inicia sesión.');

    // Get stored user ID
    final userId = await TokenStorage().readUserId();
    if (userId == null) throw Exception('User ID not found.');

    final base = Uri.parse(ApiConstants.baseUrl);
    final uri = Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.hasPort ? base.port : null,
      path: _joinPaths(base.path, 'notifications/notificaciones/'),
    );

    final headers = <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    };

    final resp = await _client.get(uri, headers: headers);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final body = jsonDecode(resp.body);
      final list = (body is List) ? body : [];

      return list
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .where((n) => n.usuarioId == userId) // Filter by user ID
          .toList();
    }

    throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
  }

  String _joinPaths(String a, String b) {
    final left = a.endsWith('/') ? a : '$a/';
    final right = b.startsWith('/') ? b.substring(1) : b;
    return '$left$right';
  }
}
