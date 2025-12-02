// lib/features/coming_soon/domain/coming_soon_obra.dart
class ComingSoonObra {
  final String id;
  final String nombre;
  final String descripcion;
  final String calle;
  final String distrito;
  final double latitud;
  final double longitud;
  final String imageUrl;
  final String genero;

  // Campo opcional de fecha de estreno
  final DateTime? fechaEstreno;

  ComingSoonObra({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.calle,
    required this.distrito,
    required this.latitud,
    required this.longitud,
    required this.imageUrl,
    required this.genero,
    this.fechaEstreno,
  });

  factory ComingSoonObra.fromJson(Map<String, dynamic> json) {
    // Ajusta aquí según cómo venga del backend
    final rawFecha = json['fecha_estreno'] ?? json['fechaEstreno'] ?? json['fecha'];

    DateTime? parsedFecha;
    if (rawFecha is String && rawFecha.isNotEmpty) {
      parsedFecha = DateTime.tryParse(rawFecha);
    }

    return ComingSoonObra(
      id: json['id']?.toString() ?? '',
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      calle: json['calle'] ?? '',
      distrito: json['distrito'] ?? '',
      latitud: (json['latitud'] as num?)?.toDouble() ?? 0.0,
      longitud: (json['longitud'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      genero: json['genero'] ?? '',
      fechaEstreno: parsedFecha,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'calle': calle,
      'distrito': distrito,
      'latitud': latitud,
      'longitud': longitud,
      'image_url': imageUrl,
      'genero': genero,
      'fecha_estreno': fechaEstreno?.toIso8601String(),
    };
  }
}
