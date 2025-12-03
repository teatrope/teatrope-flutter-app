import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';

import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:teatrope_flutter_app/features/auth/pages/signin_page.dart';

import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_state.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/pages/settings_page.dart';

// Admin
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_bloc.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_state.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_event.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/pages/edit_obra_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Ensure profile is loaded when page is initialized
    context.read<ProfileBloc>().add(const LoadProfile());
  }

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
          body: DarkBlurBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: state.status == Status.loading && profile == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        children: [
                          // User greeting
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: cs.surfaceContainerHigh,
                                child:
                                    profile?.avatarUrl != null &&
                                        profile!.avatarUrl!.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          profile.avatarUrl!,
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: 60,
                                          cacheWidth: 120,
                                          cacheHeight: 120,
                                          errorBuilder: (_, __, ___) => Icon(
                                            Icons.person,
                                            color: cs.onSurfaceVariant,
                                            size: 30,
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: cs.onSurfaceVariant,
                                        size: 30,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile?.email ?? 'User',
                                      style: tt.titleMedium?.copyWith(
                                        color: cs.onSurface,
                                        fontWeight: FontWeight.w600,
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

                          // Logout button
                          Builder(
                            builder: (context) {
                              final cs = Theme.of(context).colorScheme;
                              return FilledButton.icon(
                                onPressed: () {
                                  context.read<ProfileBloc>().add(
                                    const LogoutRequested(),
                                  );
                                },
                                icon: const Icon(Icons.logout),
                                label: const Text('Logout'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: cs.primary,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Admin Panel Section
                          Text(
                            'Admin Panel',
                            style: tt.titleLarge?.copyWith(
                              color: cs.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const _AdminPanel(),
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

class _AdminPanel extends StatelessWidget {
  const _AdminPanel();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listenWhen: (previous, current) =>
          previous.editingObra != current.editingObra &&
          current.editingObra != null,
      listener: (context, state) {
        if (state.editingObra != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EditObraPage(obra: state.editingObra!),
            ),
          );
        }
      },
      child: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          final cs = Theme.of(context).colorScheme;
          final tt = Theme.of(context).textTheme;

          if (state.status == Status.loading && state.theaters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Theater Selector
              DropdownButtonFormField<Theater>(
                value: state.selectedTheater,
                decoration: InputDecoration(
                  labelText: 'Select Theater',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: cs.surfaceContainerHigh,
                ),
                dropdownColor: cs.surfaceContainer,
                items: state.theaters.map((theater) {
                  return DropdownMenuItem(
                    value: theater,
                    child: Text(
                      theater.nombre,
                      style: TextStyle(color: cs.onSurface),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (theater) {
                  if (theater != null) {
                    context.read<AdminBloc>().add(SelectTheater(theater));
                  }
                },
                isExpanded: true,
              ),
              const SizedBox(height: 24),

              // Works List Header
              if (state.selectedTheater != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Plays',
                      style: tt.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement Add Work
                      },
                      icon: const Icon(Icons.add_circle),
                      color: cs.primary,
                      tooltip: 'Add Play',
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Works List
                if (state.status == Status.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.obras.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No works found for this theater.',
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.obras.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final obra = state.obras[index];
                      return Card(
                        color: cs.surfaceContainerLow,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: obra.imageUrl.isNotEmpty
                                ? Image.network(
                                    obra.imageUrl,
                                    width: 50,
                                    height: 50,
                                    cacheWidth: 100,
                                    cacheHeight: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 50,
                                      height: 50,
                                      color: cs.surfaceContainerHigh,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: cs.surfaceContainerHigh,
                                    child: const Icon(
                                      Icons.image_not_supported,
                                    ),
                                  ),
                          ),
                          title: Text(
                            obra.nombre,
                            style: TextStyle(color: cs.onSurface),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            obra.genero,
                            style: TextStyle(color: cs.onSurfaceVariant),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                color: cs.primary,
                                onPressed: () {
                                  context.read<AdminBloc>().add(
                                    EditObra(obra.id),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 20),
                                color: cs.error,
                                onPressed: () {
                                  // TODO: Implement Delete Work
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}
