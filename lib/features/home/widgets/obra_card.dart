import 'package:flutter/material.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

class ObraCard extends StatelessWidget {
  const ObraCard({super.key, required this.obra});
  final Obra obra;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final subtitle = (obra.teatroNombre.isNotEmpty)
        ? obra.teatroNombre
        : [obra.distrito, obra.calle].where((e) => e.isNotEmpty).join(' • ');

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
              child: obra.imageUrl.isEmpty
                  ? Container(color: cs.surfaceContainer)
                  : Image.network(
                      obra.imageUrl,
                      width: double
                          .infinity, // Forzar que ocupe todo el ancho disponible
                      fit: BoxFit
                          .cover, // llena todo el espacio sin deformar (puede recortar)
                      alignment: Alignment
                          .topCenter, // prioriza la parte superior (rostros, etc)
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
                  obra.nombre,
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
