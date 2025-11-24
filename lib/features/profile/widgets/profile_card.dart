import 'package:flutter/material.dart';
import 'package:teatrope_flutter_app/features/profile/data/models/user_profile.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';

class ProfileCard extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onEdit;

  const ProfileCard({
    super.key,
    required this.profile,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B38),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white10,
            backgroundImage: (profile.avatarUrl != null &&
                    profile.avatarUrl!.isNotEmpty)
                ? NetworkImage(profile.avatarUrl!)
                : null,
            child: (profile.avatarUrl == null ||
                    profile.avatarUrl!.isEmpty)
                ? Text(
                    profile.name.isNotEmpty
                        ? profile.name[0].toUpperCase()
                        : '?',
                    style: textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                if (profile.city != null && profile.city!.isNotEmpty)
                  Text(
                    profile.city!,
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white54,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: MaterialTheme.brandRed),
          ),
        ],
      ),
    );
  }
}
