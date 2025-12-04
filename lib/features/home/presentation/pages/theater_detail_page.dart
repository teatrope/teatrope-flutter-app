import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:teatrope_flutter_app/features/home/presentation/pages/obra_detail_page.dart';
import 'package:teatrope_flutter_app/features/home/widgets/obra_poster_card.dart';

class TheaterDetailPage extends StatefulWidget {
  const TheaterDetailPage({super.key, required this.theater});

  final Theater theater;

  @override
  State<TheaterDetailPage> createState() => _TheaterDetailPageState();
}

class _TheaterDetailPageState extends State<TheaterDetailPage> {
  late Future<List<Obra>> _worksFuture;

  @override
  void initState() {
    super.initState();
    _worksFuture = _fetchWorks();
  }

  Future<List<Obra>> _fetchWorks() async {
    try {
      final token = await TokenStorage().read();
      if (token == null) return [];

      // Access service from HomeBloc
      final service = context.read<HomeBloc>().service;

      // Fetch all works (genre: null)
      final allWorks = await service.getObras(token: token, genero: null);

      // Filter by theater ID
      return allWorks.where((o) => o.teatroId == widget.theater.id).toList();
    } catch (e) {
      debugPrint('Error fetching works for theater: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DarkBlurBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Theater Image
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  widget.theater.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.theater_comedy, size: 64),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      widget.theater.nombre,
                      style: tt.headlineSmall?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Address
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: cs.primary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${widget.theater.calle}, ${widget.theater.distrito}',
                            style: tt.bodyMedium?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description
                    if (widget.theater.descripcion.isNotEmpty) ...[
                      Text(
                        widget.theater.descripcion,
                        style: tt.bodyMedium?.copyWith(
                          color: cs.onSurface.withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Works Section
                    Text(
                      'Works at this theater',
                      style: tt.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    FutureBuilder<List<Obra>>(
                      future: _worksFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: cs.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.event_busy,
                                  color: cs.onSurfaceVariant,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No works available at the moment',
                                  style: tt.bodyMedium?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final works = snapshot.data!;
                        return SizedBox(
                          height: 180, // Height for card + padding
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: works.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final obra = works[index];
                              return ObraPosterCard(
                                imageUrl: obra.imageUrl,
                                width: 120,
                                height: 180,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ObraDetailPage(obra: obra),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
