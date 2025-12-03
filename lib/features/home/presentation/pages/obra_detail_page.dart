import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/home/data/obra_service.dart';
import 'package:teatrope_flutter_app/features/home/domain/person.dart';
import 'package:teatrope_flutter_app/features/home/domain/funcion.dart';

class ObraDetailPage extends StatefulWidget {
  final Obra obra;
  const ObraDetailPage({super.key, required this.obra});

  @override
  State<ObraDetailPage> createState() => _ObraDetailPageState();
}

class _ObraDetailPageState extends State<ObraDetailPage> {
  List<Person> _cast = [];
  List<Funcion> _funciones = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await initializeDateFormatting('es');
      final token = await TokenStorage().read();
      if (token != null) {
        final service = ObraService();
        final allPersonas = await service.getPersonas(token: token);
        final allFunciones = await service.getFunciones(token: token);

        // Filtrar por obraId
        final castFiltered = allPersonas
            .where((p) => p.obraId == widget.obra.id)
            .toList();
        final funcionesFiltered = allFunciones
            .where((f) => f.obraId == widget.obra.id)
            .toList();

        if (mounted) {
          setState(() {
            _cast = castFiltered;
            _funciones = funcionesFiltered;
            _loading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final obra = widget.obra;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: SafeArea(
        child: Stack(
          children: [
            // Header con imagen
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Imagen
                          if (obra.imageUrl.isNotEmpty)
                            Image.network(obra.imageUrl, fit: BoxFit.cover)
                          else
                            Container(color: Colors.black26),
                          // Degradado inferior
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFF0B0C10).withOpacity(0.9),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Botón back
                          Positioned(
                            top: 12,
                            left: 12,
                            child: _roundButton(
                              context,
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Nombre
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        obra.nombre,
                        style: tt.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    // Chips (género)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _chip(obra.genero, context),
                          if (obra.distrito.isNotEmpty)
                            _chip(obra.distrito, context),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    if (_loading)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else ...[
                      // Reparto (Cast)
                      if (_cast.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Reparto',
                            style: tt.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 110, // Altura para foto + nombre + rol
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: _cast.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              final person = _cast[index];
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[800],
                                    backgroundImage: person.imageUrl.isNotEmpty
                                        ? NetworkImage(person.imageUrl)
                                        : null,
                                    child: person.imageUrl.isEmpty
                                        ? const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    person.nombreCompleto,
                                    style: tt.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    person.rol,
                                    style: tt.labelSmall?.copyWith(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Lugar / Horarios (simple)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('📍', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${obra.calle}${obra.calle.isNotEmpty && obra.distrito.isNotEmpty ? ', ' : ''}${obra.distrito}',
                                style: tt.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text('🧭', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Text(
                              '(${obra.latitud.toStringAsFixed(4)}, ${obra.longitud.toStringAsFixed(4)})',
                              style: tt.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Funciones
                      if (_funciones.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Funciones',
                            style: tt.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _funciones.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final funcion = _funciones[index];
                            final dateStr = DateFormat(
                              'EEE d MMM, HH:mm',
                              'es',
                            ).format(funcion.fecha);
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B2B38),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dateStr,
                                          style: tt.bodyMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${funcion.duracionMinutos} min • ${funcion.disponibilidadAsientos} asientos',
                                          style: tt.bodySmall?.copyWith(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ],
                ),
              ),
            ),

            // Bottom bar: Booking + Heart
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _BottomBar(obra: obra),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _roundButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white12,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final Obra obra;
  const _BottomBar({required this.obra});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isFav = context.select<FavoriteBloc, bool>(
      (b) => b.state.obras.any((o) => o.id == obra.id),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0C10).withOpacity(0.94),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {},
              child: const Text('Booking'),
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: const Color(0xFF2B2B38),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () =>
                  context.read<FavoriteBloc>().add(ToggleFavorite(obra)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
