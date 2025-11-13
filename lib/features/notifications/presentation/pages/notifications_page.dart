import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/notifications/domain/notifications_preferences.dart';
import 'package:teatrope_flutter_app/features/notifications/presentation/blocs/notifications_bloc.dart';
import 'package:teatrope_flutter_app/features/notifications/presentation/blocs/notifications_event.dart';
import 'package:teatrope_flutter_app/features/notifications/presentation/blocs/notifications_state.dart';
import 'package:teatrope_flutter_app/features/notifications/widgets/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: MaterialTheme.darkLinearGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Notifications'),
          actions: [
            TextButton(
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('All caught up!'))),
              child: const Text('Clear all'),
            ),
          ],
        ),
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.failure:
                return Center(
                  child: Text(
                    'Error: ${state.error}',
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                );
              case Status.success:
                final p = state.prefs!;
                return _buildList(context, p);
              default:
                context.read<NotificationsBloc>().add(const LoadNotifications());
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, NotificationPreferences p) {
    final items = <Widget>[
      // Mostramos cada campo tal cual, sin concatenar textos
      NotificationCard(
        emoji: '🆔',
        title: 'usuario_id',
        subtitle: p.usuarioId,
      ),
      _GenresCard(generos: p.generos), // chips sin concatenar
      NotificationCard(
        emoji: '🛣️',
        title: 'calle_preferida',
        subtitle: p.callePreferida,
      ),
      NotificationCard(
        emoji: '🏙️',
        title: 'distrito_preferida',
        subtitle: p.distritoPreferida,
      ),
      NotificationCard(
        emoji: '🧭',
        title: 'latitud_preferida',
        subtitle: p.latitudPreferida.toString(),
      ),
      NotificationCard(
        emoji: '🧭',
        title: 'longitud_preferida',
        subtitle: p.longitudPreferida.toString(),
      ),
      NotificationCard(
        emoji: '🔔',
        title: 'frecuencia_notif',
        subtitle: p.frecuenciaNotif,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => items[i],
    );
  }
}

/// Card especial para mostrar generos_json como chips individuales (sin join)
class _GenresCard extends StatelessWidget {
  const _GenresCard({required this.generos});
  final List<String> generos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasGenres = generos.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B38).withOpacity(0.65),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🎭', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('generos_json',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFFFFFFF).withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 8),
                if (!hasGenres)
                  Text('—', style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFFFFFFF).withOpacity(0.72),
                  )),
                if (hasGenres)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: generos.map((g) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2B38), // sólido para chip
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                        child: Text(
                          g,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
