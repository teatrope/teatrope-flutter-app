import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_preferences.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == Status.success && state.profile != null) {
          _emailController.text = state.profile!.email;
        }
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final profile = state.profile;
        final prefs = state.preferences ?? UserPreferences.initial();

        if (profile != null && _emailController.text.isEmpty) {
          _emailController.text = profile.email;
        }

        final bool notifications = prefs.notificationsEnabled;
        final bool location = prefs.locationEnabled ?? false;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Settings'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: DarkBlurBackground(
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Account section
                  Text(
                    'Account',
                    style: tt.titleMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Email field
                  Text(
                    'E-mail',
                    style: tt.labelLarge?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: cs.onSurface),
                    decoration: InputDecoration(
                      hintText: 'user@gmail.com',
                      hintStyle: TextStyle(color: cs.onSurfaceVariant),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  Text(
                    'Password',
                    style: tt.labelLarge?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: TextStyle(color: cs.onSurface),
                    decoration: InputDecoration(
                      hintText: '**********',
                      hintStyle: TextStyle(color: cs.onSurfaceVariant),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: cs.onSurfaceVariant,
                        ),
                        onPressed: () {
                          setState(
                                () => _isPasswordVisible = !_isPasswordVisible,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Update button
                  FilledButton(
                    onPressed: _loading
                        ? null
                        : () => _updateProfile(context, state),
                    child: _loading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Update'),
                  ),
                  const SizedBox(height: 32),

                  // Permissions section
                  Text(
                    'Permissions',
                    style: tt.titleMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  SwitchListTile(
                    value: notifications,
                    title: const Text('Notifications'),
                    subtitle: const Text('Receive push notifications'),
                    onChanged: (value) {
                      _savePreferences(
                        context,
                        prefs.copyWith(notificationsEnabled: value),
                      );
                    },
                  ),
                  SwitchListTile(
                    value: location,
                    title: const Text('Location'),
                    subtitle: const Text('Allow location access'),
                    onChanged: (value) {
                      _savePreferences(
                        context,
                        prefs.copyWith(locationEnabled: value),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Information links
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text('About us'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Terms & Conditions'),
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),

                  // Logout button
                  FilledButton.icon(
                    onPressed: () {
                      context
                          .read<ProfileBloc>()
                          .add(const LogoutRequested());
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateProfile(
      BuildContext context,
      ProfileState state,
      ) async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El email es requerido')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final profile = state.profile;
      if (profile == null) {
        setState(() => _loading = false);
        return;
      }

      // 1) Actualizar email vía BLoC (PATCH /auth/users/{id}/)
      final updatedProfile = profile.copyWith(email: _emailController.text);
      context
          .read<ProfileBloc>()
          .add(UpdateProfilePressed(updatedProfile));

      // 2) Actualizar password si se proporcionó
      if (_passwordController.text.isNotEmpty &&
          _passwordController.text.length >= 6) {
        final repository = context.read<ProfileBloc>().repository;
        await repository.updatePassword(_passwordController.text);
        _passwordController.clear();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil actualizado exitosamente')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _savePreferences(
      BuildContext context,
      UserPreferences updated,
      ) {
    context
        .read<ProfileBloc>()
        .add(UpdatePreferencesPressed(updated));
  }
}
