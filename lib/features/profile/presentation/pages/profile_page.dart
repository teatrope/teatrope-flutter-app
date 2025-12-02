import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';

import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:teatrope_flutter_app/features/auth/pages/signin_page.dart';

import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_state.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/pages/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.logoutSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const SigninPage()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final profile = state.profile;
        final cs = Theme.of(context).colorScheme;
        final tt = Theme.of(context).textTheme;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: DarkBlurBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: state.status == Status.loading &&
                        profile == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(
                        children: [
                          // User greeting
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: cs.surfaceContainerHigh,
                                child: profile?.avatarUrl != null && profile!.avatarUrl!.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          profile.avatarUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(Icons.person, color: cs.onSurfaceVariant, size: 30),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi! User Welcome',
                                      style: tt.titleMedium?.copyWith(
                                        color: cs.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (profile != null)
                                      Text(
                                        profile.email,
                                        style: tt.bodySmall?.copyWith(
                                          color: cs.onSurfaceVariant,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const SettingsPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          
                          // Account options
                          _ProfileMenuItem(
                            icon: Icons.confirmation_number,
                            title: 'My tickets',
                            onTap: () {},
                          ),
                          _ProfileMenuItem(
                            icon: Icons.credit_card,
                            title: 'My credit cards',
                            onTap: () {},
                          ),
                          _ProfileMenuItem(
                            icon: Icons.history,
                            title: 'History',
                            onTap: () {},
                          ),
                          const SizedBox(height: 16),
                          
                          // Information links
                          _ProfileMenuItem(
                            icon: Icons.edit_outlined,
                            title: 'About us',
                            onTap: () {},
                          ),
                          _ProfileMenuItem(
                            icon: Icons.info_outline,
                            title: 'Terms & Conditions',
                            onTap: () {},
                          ),
                          const SizedBox(height: 32),
                          
                          // Logout button
                          Builder(
                            builder: (context) {
                              final cs = Theme.of(context).colorScheme;
                              return FilledButton.icon(
                                onPressed: () {
                                  context.read<ProfileBloc>().add(const LogoutRequested());
                                },
                                icon: const Icon(Icons.logout),
                                label: const Text('Logout'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: cs.primary,
                                ),
                              );
                            },
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

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListTile(
      leading: Icon(icon, color: cs.onSurfaceVariant),
      title: Text(
        title,
        style: tt.bodyLarge?.copyWith(color: cs.onSurface),
      ),
      trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
      onTap: onTap,
    );
  }
}
