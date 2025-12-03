import 'package:flutter/material.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';

class TheaterCard extends StatelessWidget {
  const TheaterCard({super.key, required this.theater});
  final Theater theater;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final subtitle = (theater.descripcion.isEmpty)
        ? [
            theater.distrito,
            theater.calle,
          ].where((e) => e.isNotEmpty).join(' • ')
        : theater.descripcion;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ocupa todo el espacio superior disponible -> no hay overflow
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: theater.imageUrl.isEmpty
                  ? Container(color: cs.surfaceContainer)
                  : Image.network(
                      theater.imageUrl,
                      fit: BoxFit
                          .cover, // recorta sin deformar para cualquier resolución
                      errorBuilder: (_, __, ___) => Container(
                        color: cs.surfaceContainer,
                      ), // no imprime texto de error
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  theater.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tt.titleMedium?.copyWith(
                    color: cs.primaryFixedDim,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
