import 'package:equatable/equatable.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/notifications/domain/notification_model.dart';

class NotificationsState extends Equatable {
  final Status status;
  final List<NotificationModel> notifications;
  final String? error;

  const NotificationsState({
    this.status = Status.initial,
    this.notifications = const [],
    this.error,
  });

  NotificationsState copyWith({
    Status? status,
    List<NotificationModel>? notifications,
    String? error,
  }) => NotificationsState(
    status: status ?? this.status,
    notifications: notifications ?? this.notifications,
    error: error,
  );

  @override
  List<Object?> get props => [status, notifications, error];
}
