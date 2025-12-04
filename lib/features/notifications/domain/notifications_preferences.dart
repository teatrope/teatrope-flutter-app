class NotificationPreferences {
  final String usuarioId;
  final List<String> generos;
  final String callePreferida;
  final String distritoPreferida;
  final double latitudPreferida;
  final double longitudPreferida;
  final String frecuenciaNotif;

  const NotificationPreferences({
    required this.usuarioId,
    required this.generos,
    required this.callePreferida,
    required this.distritoPreferida,
    required this.latitudPreferida,
    required this.longitudPreferida,
    required this.frecuenciaNotif,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      usuarioId: json['usuario_id'] ?? '',
      generos: (json['generos_json'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      callePreferida: json['calle_preferida'] ?? '',
      distritoPreferida: json['distrito_preferida'] ?? '',
      latitudPreferida: (json['latitud_preferida'] as num?)?.toDouble() ?? 0,
      longitudPreferida: (json['longitud_preferida'] as num?)?.toDouble() ?? 0,
      frecuenciaNotif: json['frecuencia_notif'] ?? '',
    );
  }
}
