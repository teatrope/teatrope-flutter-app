class Funcion {
  final String id;
  final String obraId;
  final DateTime fecha;
  final int duracionMinutos;
  final int disponibilidadAsientos;

  Funcion({
    required this.id,
    required this.obraId,
    required this.fecha,
    required this.duracionMinutos,
    required this.disponibilidadAsientos,
  });

  factory Funcion.fromJson(Map<String, dynamic> json) {
    String _s(dynamic v) {
      if (v == null) return '';
      return '$v';
    }

    int _i(dynamic v) => int.tryParse((v ?? '0').toString()) ?? 0;

    final obra = (json['obra'] is Map) ? (json['obra'] as Map) : const {};

    return Funcion(
      id: _s(json['id']),
      obraId: _s(obra['id']),
      fecha: DateTime.tryParse(_s(json['fecha'])) ?? DateTime.now(),
      duracionMinutos: _i(json['duracion_minutos']),
      disponibilidadAsientos: _i(json['disponibilidad_asientos']),
    );
  }
}
