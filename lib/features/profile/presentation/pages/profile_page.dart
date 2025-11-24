import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';

import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_bloc.dart';

import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_state.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/pages/settings_page.dart';
import 'package:teatrope_flutter_app/features/profile/widgets/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.logoutSuccess) {
          // TODO: navegar al login
        }
      },
      builder: (context, state) {
        final profile = state.profile;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Perfil'),
            backgroundColor: MaterialTheme.darkBgTop,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: MaterialTheme.darkLinearGradient,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: state.status == Status.loading &&
                        profile == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (profile != null)
                            ProfileCard(
                              profile: profile,
                              onEdit: () {
                                // aquí podrías abrir un bottom sheet para editar
                              },
                            ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              // ir a settings_page
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SettingsPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.settings),
                            label: const Text('Configuración'),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(const LogoutRequested());
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Cerrar sesión'),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
