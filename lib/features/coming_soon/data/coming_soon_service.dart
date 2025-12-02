// features/coming_soon/data/coming_soon_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/features/coming_soon/domain/coming_soon_obra.dart';

class ComingSoonService {
  final http.Client _client;
  ComingSoonService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<ComingSoonObra>> getComingSoonObras({
    required String token,
  }) async {
    // Usar el endpoint de obras con filtro para próximos estrenos
    // O usar el endpoint de obras directamente si no hay endpoint específico
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.obrasEndpoint}');

    final headers = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    };

    final resp = await _client.get(uri, headers: headers);

    if (resp.statusCode != HttpStatus.ok) {
      throw Exception('HTTP ${resp.statusCode}: ${resp.reasonPhrase}\n${resp.body}');
    }

    final decoded = jsonDecode(resp.body);
    final List raw = decoded is List
        ? decoded
        : (decoded is Map && decoded['results'] is List)
            ? decoded['results'] as List
            : (decoded is Map && decoded['data'] is List)
                ? decoded['data'] as List
                : <dynamic>[];

    final obras = raw
        .map((e) => ComingSoonObra.fromJson((e as Map).cast<String, dynamic>()))
        .toList();

    return obras;
  }
}

