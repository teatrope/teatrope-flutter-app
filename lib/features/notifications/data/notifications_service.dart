import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/features/notifications/domain/notifications_preferences.dart';

class NotificationsService {
  final http.Client _client;
  NotificationsService({http.Client? client}) : _client = client ?? http.Client();

  Future<NotificationPreferences> getPreferences() async {
    final uri = Uri.parse('${ApiConstants.baseUrl}notifications/preferencias/');
    final resp = await _client.get(uri);
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final body = jsonDecode(resp.body);
      final Map<String, dynamic> json =
          (body is List && body.isNotEmpty) ? (body.first as Map<String, dynamic>) : (body as Map<String, dynamic>);
      return NotificationPreferences.fromJson(json);
    }
    throw Exception('Error ${resp.statusCode} al cargar preferencias');
  }
}
