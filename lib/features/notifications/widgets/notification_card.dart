import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  const NotificationCard({super.key, required this.emoji, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B38).withOpacity(0.65),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFFFFFFF).withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFFFFFFF).withOpacity(0.72),
                      height: 1.25,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
