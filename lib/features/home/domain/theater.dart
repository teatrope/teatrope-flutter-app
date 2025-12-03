import 'package:equatable/equatable.dart';

class Theater extends Equatable {
  final String id;
  final String nombre;
  final String descripcion;
  final String calle;
  final String distrito;
  final double latitud;
  final double longitud;
  final String imageUrl;

  const Theater({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.calle,
    required this.distrito,
    required this.latitud,
    required this.longitud,
    required this.imageUrl,
  });

  factory Theater.fromJson(Map<String, dynamic> json) {
    String _s(dynamic v) {
      if (v == null) return '';
      return '$v';
    }

    double _d(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return Theater(
      id: _s(json['id']),
      nombre: _s(json['nombre']),
      descripcion: _s(json['descripcion']),
      calle: _s(json['calle']),
      distrito: _s(json['distrito']),
      latitud: _d(json['latitud']),
      longitud: _d(json['longitud']),
      imageUrl: _s(json['image_url']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    nombre,
    descripcion,
    calle,
    distrito,
    latitud,
    longitud,
    imageUrl,
  ];
}
