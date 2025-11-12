// features/home/domain/Obra.dart
class Obra {
  final String id;
  final String nombre;
  final String descripcion;
  final String calle;
  final String distrito;
  final double latitud;
  final double longitud;
  final String imageUrl;
  final String genero; // <-- NUEVO

  const Obra({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.calle,
    required this.distrito,
    required this.latitud,
    required this.longitud,
    required this.imageUrl,
    required this.genero, // <-- NUEVO
  });

  factory Obra.fromJson(Map<String, dynamic> json) {
    String _s(dynamic v) => (v ?? '').toString();
    double _d(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    final teatro = (json['teatro'] is Map) ? (json['teatro'] as Map) : const {};

    return Obra(
      id: _s(json['id']),
      nombre: _s(json['titulo'] ?? json['nombre'] ?? teatro['nombre']),
      descripcion: _s(json['sinopsis'] ?? json['descripcion'] ?? teatro['descripcion']),
      calle: _s(json['calle'] ?? teatro['calle']),
      distrito: _s(json['distrito'] ?? teatro['distrito']),
      latitud: _d(json['latitud'] ?? teatro['latitud']),
      longitud: _d(json['longitud'] ?? teatro['longitud']),
      imageUrl: _s(json['image_url'] ?? teatro['image_url']),
      genero: _s(json['genero']), // <-- viene así en tus ejemplos
    );
  }
}
