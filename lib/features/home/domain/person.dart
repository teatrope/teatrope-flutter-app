class Person {
  final String id;
  final String nombreCompleto;
  final String rol;
  final String imageUrl;
  final String obraId;

  Person({
    required this.id,
    required this.nombreCompleto,
    required this.rol,
    required this.imageUrl,
    required this.obraId,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    String _s(dynamic v) => (v ?? '').toString();

    final obra = (json['obra'] is Map) ? (json['obra'] as Map) : const {};

    return Person(
      id: _s(json['id']),
      nombreCompleto: _s(json['nombre_completo']),
      rol: _s(json['rol']),
      imageUrl: _s(json['image_url']),
      obraId: _s(obra['id']),
    );
  }
}
