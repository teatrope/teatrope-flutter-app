import 'package:flutter/material.dart';

class ObraPosterCard extends StatelessWidget {
  const ObraPosterCard({
    super.key,
    required this.imageUrl,
    this.onTap,
    this.width = 120,
    this.height = 160,
  });

  final String imageUrl;
  final VoidCallback? onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[800],
              child: const Icon(Icons.image_not_supported, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
