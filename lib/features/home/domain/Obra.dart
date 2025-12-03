class Obra {
  final String id;
  final String nombre;
  final String descripcion;
  final String calle;
  final String distrito;
  final double latitud;
  final double longitud;
  final String imageUrl;
  final String genero;

  final String teatroNombre;
  final String teatroId;

  const Obra({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.calle,
    required this.distrito,
    required this.latitud,
    required this.longitud,
    required this.imageUrl,
    required this.genero,
    required this.teatroNombre,
    required this.teatroId,
  });

  factory Obra.fromJson(Map<String, dynamic> json) {
    String _s(dynamic v) {
      if (v == null) return '';
      return '$v';
    }

    double _d(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    final teatro = (json['teatro'] is Map) ? (json['teatro'] as Map) : const {};

    return Obra(
      id: _s(json['id']),
      nombre: _s(json['titulo'] ?? json['nombre'] ?? teatro['nombre']),
      descripcion: _s(
        json['sinopsis'] ?? json['descripcion'] ?? teatro['descripcion'],
      ),
      calle: _s(json['calle'] ?? teatro['calle']),
      distrito: _s(json['distrito'] ?? teatro['distrito']),
      latitud: _d(json['latitud'] ?? teatro['latitud']),
      longitud: _d(json['longitud'] ?? teatro['longitud']),
      imageUrl: _s(json['image_url'] ?? teatro['image_url']),
      genero: _s(json['genero']),
      teatroNombre: _s(teatro['nombre']),
      teatroId: _s(teatro['id']),
    );
  }

  // ✅ necesarios para SQLite
  Map<String, dynamic> toMap() => {
    'id': id,
    'nombre': nombre,
    'descripcion': descripcion,
    'calle': calle,
    'distrito': distrito,
    'latitud': latitud,
    'longitud': longitud,
    'image_url': imageUrl,
    'genero': genero,
    'teatro_nombre': teatroNombre,
    'teatro_id': teatroId,
  };

  factory Obra.fromMap(Map<String, dynamic> map) => Obra(
    id: map['id']?.toString() ?? '',
    nombre: map['nombre']?.toString() ?? '',
    descripcion: map['descripcion']?.toString() ?? '',
    calle: map['calle']?.toString() ?? '',
    distrito: map['distrito']?.toString() ?? '',
    latitud: (map['latitud'] is num)
        ? (map['latitud'] as num).toDouble()
        : double.tryParse('${map['latitud']}') ?? 0.0,
    longitud: (map['longitud'] is num)
        ? (map['longitud'] as num).toDouble()
        : double.tryParse('${map['longitud']}') ?? 0.0,
    imageUrl: map['image_url']?.toString() ?? '',
    genero: map['genero']?.toString() ?? '',
    teatroNombre: map['teatro_nombre']?.toString() ?? '',
    teatroId: map['teatro_id']?.toString() ?? '',
  );
}
