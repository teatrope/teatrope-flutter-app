import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_profile.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

class RefreshProfile extends ProfileEvent {
  const RefreshProfile();
}

class UpdateProfilePressed extends ProfileEvent {
  final UserProfile updated;

  const UpdateProfilePressed(this.updated);

  @override
  List<Object?> get props => [updated];
}

class UpdatePreferencesPressed extends ProfileEvent {
  final UserPreferences updated;

  const UpdatePreferencesPressed(this.updated);

  @override
  List<Object?> get props => [updated];
}

class LogoutRequested extends ProfileEvent {
  const LogoutRequested();
}
