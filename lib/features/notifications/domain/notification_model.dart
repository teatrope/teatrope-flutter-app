class NotificationModel {
  final String id;
  final String usuarioId;
  final String tipo;
  final String contenido;
  final DateTime timestamp;
  final String estado;
  final String tituloMensaje;
  final String cuerpoMensaje;
  final String enlaceMensaje;

  const NotificationModel({
    required this.id,
    required this.usuarioId,
    required this.tipo,
    required this.contenido,
    required this.timestamp,
    required this.estado,
    required this.tituloMensaje,
    required this.cuerpoMensaje,
    required this.enlaceMensaje,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      usuarioId: json['usuario_id']?.toString() ?? '',
      tipo: json['tipo']?.toString() ?? '',
      contenido: json['contenido']?.toString() ?? '',
      timestamp:
          DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
          DateTime.now(),
      estado: json['estado']?.toString() ?? '',
      tituloMensaje: json['titulo_mensaje']?.toString() ?? '',
      cuerpoMensaje: json['cuerpo_mensaje']?.toString() ?? '',
      enlaceMensaje: json['enlace_mensaje']?.toString() ?? '',
    );
  }
}
