import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/coming_soon/presentation/blocs/coming_soon_bloc.dart';
import 'package:teatrope_flutter_app/features/coming_soon/presentation/blocs/coming_soon_event.dart';
import 'package:teatrope_flutter_app/features/coming_soon/presentation/blocs/coming_soon_state.dart';
import 'package:teatrope_flutter_app/features/home/presentation/pages/obra_detail_page.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: DarkBlurBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Text(
                      'teatrope',
                      style: tt.headlineMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: cs.onSurfaceVariant,
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/notifications'),
                    ),
                  ],
                ),
              ),

              // TODO: aquí luego puedes poner filtros (city/district/genre)
              Expanded(
                child: BlocBuilder<ComingSoonBloc, ComingSoonState>(
                  builder: (context, state) {
                    if (state.status == Status.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == Status.failure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message ?? 'Error al cargar',
                              style: tt.bodyMedium?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ComingSoonBloc>().add(
                                  const LoadComingSoon(),
                                );
                              },
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state.obras.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay próximos estrenos',
                          style: tt.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              // más alto que ancho (tipo póster)
                              childAspectRatio: 0.7,
                            ),
                        itemCount: state.obras.length,
                        itemBuilder: (context, index) {
                          final obra = state.obras[index];

                          // Para ir al detalle seguimos usando Obra
                          final obraForDetail = Obra(
                            id: obra.id,
                            nombre: obra.nombre,
                            descripcion: obra.descripcion,
                            calle: obra.calle,
                            distrito: obra.distrito,
                            latitud: obra.latitud,
                            longitud: obra.longitud,
                            imageUrl: obra.imageUrl,
                            genero: obra.genero,
                            teatroNombre: '',
                            teatroId: '',
                          );

                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ObraDetailPage(obra: obraForDetail),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Póster + fecha de estreno
                                Expanded(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Image.network(
                                          obra.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (obra.fechaEstreno != null)
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                0.6,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              'Release date | ${_formatDate(obra.fechaEstreno!)}',
                                              style: tt.labelSmall?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Título
                                Text(
                                  obra.nombre,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: tt.bodyMedium?.copyWith(
                                    color: cs.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
