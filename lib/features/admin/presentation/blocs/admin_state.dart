import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';

class AdminState extends Equatable {
  final Status status;
  final List<Theater> theaters;
  final Theater? selectedTheater;
  final List<Obra> obras;
  final Obra? editingObra;
  final Status updateStatus;
  final String? errorMessage;

  const AdminState({
    this.status = Status.initial,
    this.theaters = const [],
    this.selectedTheater,
    this.obras = const [],
    this.editingObra,
    this.updateStatus = Status.initial,
    this.errorMessage,
  });

  AdminState copyWith({
    Status? status,
    List<Theater>? theaters,
    Theater? selectedTheater,
    List<Obra>? obras,
    Obra? editingObra,
    bool clearEditingObra = false,
    Status? updateStatus,
    String? errorMessage,
  }) {
    return AdminState(
      status: status ?? this.status,
      theaters: theaters ?? this.theaters,
      selectedTheater: selectedTheater ?? this.selectedTheater,
      obras: obras ?? this.obras,
      editingObra: clearEditingObra ? null : (editingObra ?? this.editingObra),
      updateStatus: updateStatus ?? this.updateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    theaters,
    selectedTheater,
    obras,
    editingObra,
    updateStatus,
    errorMessage,
  ];
}
