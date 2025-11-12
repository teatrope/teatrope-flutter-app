// home_event.dart
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_state.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class GetObrasByGenre extends HomeEvent {
  final GenresType genre;
  const GetObrasByGenre({required this.genre});
}
