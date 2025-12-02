// coming_soon_state.dart
import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/coming_soon/domain/coming_soon_obra.dart';

class ComingSoonState extends Equatable {
  final Status status;
  final List<ComingSoonObra> obras;
  final String? message;

  const ComingSoonState({
    this.status = Status.initial,
    this.obras = const [],
    this.message,
  });

  ComingSoonState copyWith({
    Status? status,
    List<ComingSoonObra>? obras,
    String? message,
  }) {
    return ComingSoonState(
      status: status ?? this.status,
      obras: obras ?? this.obras,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, obras, message];
}




