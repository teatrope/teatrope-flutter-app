import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final prefs =
            state.preferences ?? UserPreferences.initial();

        bool notifications = prefs.notificationsEnabled;
        bool darkMode = prefs.darkMode;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Configuración'),
          ),
          body: StatefulBuilder(
            builder: (context, setState) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SwitchListTile(
                    value: notifications,
                    title: const Text('Notificaciones'),
                    onChanged: (value) {
                      setState(() => notifications = value);
                      _save(context, prefs.copyWith(
                        notificationsEnabled: value,
                      ));
                    },
                  ),
                  const Divider(),
                  SwitchListTile(
                    value: darkMode,
                    title: const Text('Modo oscuro'),
                    onChanged: (value) {
                      setState(() => darkMode = value);
                      _save(context, prefs.copyWith(
                        darkMode: value,
                      ));
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _save(BuildContext context, UserPreferences updated) {
    context
        .read<ProfileBloc>()
        .add(UpdatePreferencesPressed(updated));
  }
}
