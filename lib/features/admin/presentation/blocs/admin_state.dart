import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';

class AdminState extends Equatable {
  final Status status;
  final List<Theater> theaters;
  final Theater? selectedTheater;
  final List<Obra> obras;
  final String? errorMessage;

  const AdminState({
    this.status = Status.initial,
    this.theaters = const [],
    this.selectedTheater,
    this.obras = const [],
    this.errorMessage,
  });

  AdminState copyWith({
    Status? status,
    List<Theater>? theaters,
    Theater? selectedTheater,
    List<Obra>? obras,
    String? errorMessage,
  }) {
    return AdminState(
      status: status ?? this.status,
      theaters: theaters ?? this.theaters,
      selectedTheater: selectedTheater ?? this.selectedTheater,
      obras: obras ?? this.obras,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    theaters,
    selectedTheater,
    obras,
    errorMessage,
  ];
}
