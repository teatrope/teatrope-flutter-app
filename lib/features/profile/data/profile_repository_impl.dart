import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_profile.dart';
import 'package:teatrope_flutter_app/features/profile/domain/profile_repository.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/datasource/profile_remote_ds.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl({required this.remote});

  @override
  Future<UserProfile> getProfile() {
    return remote.fetchProfile();
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) {
    return remote.updateProfile(profile);
  }

  @override
  Future<void> updatePassword(String newPassword) {
    return remote.updatePassword(newPassword);
  }

  @override
  Future<UserPreferences> getPreferences() {
    return remote.getPreferences();
  }

  @override
  Future<UserPreferences> updatePreferences(
      UserPreferences preferences,
      ) {
    return remote.savePreferences(preferences);
  }

  @override
  Future<void> logout() async {
    await remote.clearSession();
  }
}
