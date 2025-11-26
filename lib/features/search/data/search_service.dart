// features/search/data/search_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:teatrope_flutter_app/core/constants/api_constants.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

class SearchService {
  final http.Client _client;
  SearchService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Obra>> searchObras({
    required String query,
    required String token,
  }) async {
    // Usar el endpoint de discovery/busquedas para buscar
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.discoveryBusquedasEndpoint}');

    final headers = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Primero crear la búsqueda
    final searchBody = jsonEncode({'query': query});
    final searchResp = await _client.post(uri, headers: headers, body: searchBody);

    if (searchResp.statusCode != HttpStatus.ok && searchResp.statusCode != HttpStatus.created) {
      throw Exception('HTTP ${searchResp.statusCode}: ${searchResp.reasonPhrase}\n${searchResp.body}');
    }

    // Luego buscar en obras con el query
    final obrasUri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.obrasEndpoint}?search=${Uri.encodeQueryComponent(query)}',
    );

    final obrasResp = await _client.get(obrasUri, headers: headers);

    if (obrasResp.statusCode != HttpStatus.ok) {
      throw Exception('HTTP ${obrasResp.statusCode}: ${obrasResp.reasonPhrase}\n${obrasResp.body}');
    }

    final decoded = jsonDecode(obrasResp.body);
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

    return obras;
  }
}



