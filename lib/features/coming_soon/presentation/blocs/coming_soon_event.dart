// coming_soon_event.dart
import 'package:equatable/equatable.dart';

abstract class ComingSoonEvent extends Equatable {
  const ComingSoonEvent();

  @override
  List<Object?> get props => [];
}

class LoadComingSoon extends ComingSoonEvent {
  const LoadComingSoon();
}

class RefreshComingSoon extends ComingSoonEvent {
  const RefreshComingSoon();
}


