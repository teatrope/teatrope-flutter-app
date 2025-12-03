// home_state.dart
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';

enum GenresType {
  all('TODOS'),
  drama('DRAMA'),
  comedia('COMEDIA'),
  musical('MUSICAL'),
  experimental('EXPERIMENTAL');

  final String label;
  const GenresType(this.label);
}

class HomeState {
  final Status status;
  final GenresType selectedGenre;
  final List<Obra> obras; // <- NO NULLABLE
  final List<Theater> theaters; // <- Lista de teatros
  final String? message;

  const HomeState({
    this.status = Status.initial,
    this.selectedGenre = GenresType.all,
    this.obras = const [], // <- lista vacía por defecto
    this.theaters = const [], // <- lista vacía por defecto
    this.message,
  });

  HomeState copyWith({
    Status? status,
    GenresType? selectedGenre,
    List<Obra>? obras, // <- parámetro opcional
    List<Theater>? theaters, // <- parámetro opcional
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      obras: obras ?? this.obras, // <- fallback a actual
      theaters: theaters ?? this.theaters, // <- fallback a actual
      message: message ?? this.message,
    );
  }
}
