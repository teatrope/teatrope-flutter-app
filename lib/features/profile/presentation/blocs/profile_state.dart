import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_profile.dart';

class ProfileState extends Equatable {
  final Status status;
  final UserProfile? profile;
  final UserPreferences? preferences;
  final String? errorMessage;
  final bool logoutSuccess;

  const ProfileState({
    required this.status,
    this.profile,
    this.preferences,
    this.errorMessage,
    this.logoutSuccess = false,
  });

  factory ProfileState.initial() => const ProfileState(
        status: Status.initial,
        profile: null,
        preferences: null,
        errorMessage: null,
        logoutSuccess: false,
      );

  ProfileState copyWith({
    Status? status,
    UserProfile? profile,
    UserPreferences? preferences,
    String? errorMessage,
    bool? logoutSuccess,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      preferences: preferences ?? this.preferences,
      errorMessage: errorMessage,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [status, profile, preferences, errorMessage, logoutSuccess];
}
