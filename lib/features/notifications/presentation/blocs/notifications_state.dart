import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/notifications/domain/notifications_preferences.dart';

class NotificationsState extends Equatable {
  final Status status;
  final NotificationPreferences? prefs;
  final String? error;

  const NotificationsState({
    this.status = Status.initial,
    this.prefs,
    this.error,
  });

  NotificationsState copyWith({
    Status? status,
    NotificationPreferences? prefs,
    String? error,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        prefs: prefs ?? this.prefs,
        error: error,
      );

  @override
  List<Object?> get props => [status, prefs, error];
}
