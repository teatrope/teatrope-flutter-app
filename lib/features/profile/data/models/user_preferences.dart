class UserPreferences {
  final bool notificationsEnabled;
  final bool darkMode;
  final String? preferredCity;
  final String? preferredGenre;

  const UserPreferences({
    required this.notificationsEnabled,
    required this.darkMode,
    this.preferredCity,
    this.preferredGenre,
  });

  factory UserPreferences.initial() => const UserPreferences(
        notificationsEnabled: true,
        darkMode: true,
        preferredCity: null,
        preferredGenre: null,
      );

  UserPreferences copyWith({
    bool? notificationsEnabled,
    bool? darkMode,
    String? preferredCity,
    String? preferredGenre,
  }) {
    return UserPreferences(
      notificationsEnabled:
          notificationsEnabled ?? this.notificationsEnabled,
      darkMode: darkMode ?? this.darkMode,
      preferredCity: preferredCity ?? this.preferredCity,
      preferredGenre: preferredGenre ?? this.preferredGenre,
    );
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      darkMode: json['darkMode'] ?? true,
      preferredCity: json['preferredCity'],
      preferredGenre: json['preferredGenre'],
    );
  }

  Map<String, dynamic> toJson() => {
        'notificationsEnabled': notificationsEnabled,
        'darkMode': darkMode,
        'preferredCity': preferredCity,
        'preferredGenre': preferredGenre,
      };
}
