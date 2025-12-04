import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class LoadTheaters extends AdminEvent {
  const LoadTheaters();
}

class SelectTheater extends AdminEvent {
  final Theater theater;

  const SelectTheater(this.theater);

  @override
  List<Object?> get props => [theater];
}

class LoadTheaterObras extends AdminEvent {
  final String theaterId;

  const LoadTheaterObras(this.theaterId);

  @override
  List<Object?> get props => [theaterId];
}

class EditObra extends AdminEvent {
  final String obraId;

  const EditObra(this.obraId);

  @override
  List<Object?> get props => [obraId];
}

class UpdateObra extends AdminEvent {
  final String obraId;
  final Map<String, dynamic> data;

  const UpdateObra(this.obraId, this.data);

  @override
  List<Object?> get props => [obraId, data];
}

class CreateObra extends AdminEvent {
  final Map<String, dynamic> data;

  const CreateObra(this.data);

  @override
  List<Object?> get props => [data];
}

class DeleteObra extends AdminEvent {
  final String obraId;

  const DeleteObra(this.obraId);

  @override
  List<Object?> get props => [obraId];
}

class ClearEditingObra extends AdminEvent {
  const ClearEditingObra();
}
