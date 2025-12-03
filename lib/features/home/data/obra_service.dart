// features/home/data/obra_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';

class ObraService {
  final http.Client _client;
  ObraService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Obra>> getObras({
    String? genero, // 'MUSICAL', 'DRAMA', etc. o null/'' = todas
    required String token, // Opción B: lo pasas desde el BLoC
  }) async {
    final bool sinFiltro = genero == null || genero.trim().isEmpty;

    final uri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.obrasEndpoint}'
      '${sinFiltro ? '' : '?genero=${Uri.encodeQueryComponent(genero!)}'}',
    );

    final headers = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token', // o 'Bearer $token'
    };

    final resp = await _client.get(uri, headers: headers);

    if (resp.statusCode != HttpStatus.ok) {
      throw Exception(
        'HTTP ${resp.statusCode}: ${resp.reasonPhrase}\n${resp.body}',
      );
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
        .map((e) => Obra.fromJson((e as Map).cast<String, dynamic>()))
        .toList();

    // Si no hay filtro (genero es null o vacío), retornar todas las obras
    // Si hay filtro, aplicar filtro de respaldo por si el backend ignora el query
    if (!sinFiltro && genero != null && genero.trim().isNotEmpty) {
      final g = genero.toUpperCase().trim();
      return obras.where((o) => o.genero.toUpperCase().trim() == g).toList();
    }
    return obras; // Retornar todas si no hay filtro
  }

  Future<List<Theater>> getTheaters({required String token}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}content/teatros/');

    final headers = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    };

    final resp = await _client.get(uri, headers: headers);

    if (resp.statusCode != HttpStatus.ok) {
      throw Exception(
        'HTTP ${resp.statusCode}: ${resp.reasonPhrase}\n${resp.body}',
      );
    }

    final decoded = jsonDecode(resp.body);
    final List raw = decoded is List
        ? decoded
        : (decoded is Map && decoded['results'] is List)
        ? decoded['results'] as List
        : (decoded is Map && decoded['data'] is List)
        ? decoded['data'] as List
        : <dynamic>[];

    return raw
        .map((e) => Theater.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }
}
