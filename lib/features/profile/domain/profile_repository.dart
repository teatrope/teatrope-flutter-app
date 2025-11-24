import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile();
  Future<UserProfile> updateProfile(UserProfile profile);

  Future<UserPreferences> getPreferences();
  Future<UserPreferences> updatePreferences(UserPreferences preferences);

  Future<void> logout();
}
