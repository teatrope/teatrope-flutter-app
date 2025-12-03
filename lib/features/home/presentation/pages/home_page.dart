import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart'; // DarkBlurBackground
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_event.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_state.dart';
import 'package:teatrope_flutter_app/features/home/presentation/pages/obra_detail_page.dart';
import 'package:teatrope_flutter_app/features/home/widgets/obra_card.dart';
import 'package:teatrope_flutter_app/features/home/widgets/theater_card.dart';
import 'package:teatrope_flutter_app/features/search/data/search_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Altura fija del carrusel; el ancho se maneja con AspectRatio
  static const double _carouselHeight = 300;

  final _cities = const ['Lima', 'Arequipa', 'Cusco'];
  final _districts = const ['Surco', 'Miraflores', 'San Isidro'];

  String _selectedCity = 'Lima';
  String _selectedDistrict = 'Surco';
  GenresType? _selectedGenre;
  bool _isTheaters = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: DarkBlurBackground(
        // mismo fondo usado en SignIn/SignUp
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Header
              Row(
                children: [
                  Text(
                    'teatrope',
                    style: tt.headlineMedium?.copyWith(
                      color: cs.primary, // acento rojo
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  _roundedIcon(
                    context,
                    Icons.notifications_none,
                    onTap: () =>
                        Navigator.of(context).pushNamed('/notifications'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // City + search + ajustes
              Row(
                children: [
                  Expanded(
                    child: _ChipDropdown<String>(
                      label: 'Choose city',
                      value: _selectedCity,
                      items: _cities,
                      onChanged: (v) =>
                          setState(() => _selectedCity = v ?? _selectedCity),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _roundedIcon(
                    context,
                    Icons.search,
                    onTap: () => _showSearchDialog(context),
                  ),
                  const SizedBox(width: 8),
                  _roundedIcon(context, Icons.tune, onTap: () {}),
                ],
              ),
              const SizedBox(height: 16),

              // Promo
              _PromoCard(
                title: 'Know the promotions of',
                highlight: 'Tuesdays & Monday',
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Toggle Services/Theaters
              _SegmentedTwo(
                leftLabel: 'Services',
                rightLabel: 'Theaters',
                isRightSelected: _isTheaters,
                onChanged: (v) {
                  setState(() => _isTheaters = v);
                  // When switching, reload with current genre
                  if (_isTheaters) {
                    context.read<HomeBloc>().add(const GetTheaters());
                  } else {
                    if (_selectedGenre != null) {
                      context.read<HomeBloc>().add(
                        GetObrasByGenre(genre: _selectedGenre!),
                      );
                    } else {
                      context.read<HomeBloc>().add(
                        const GetObrasByGenre(genre: GenresType.all),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 12),

              // Filtros: District / Genre
              Row(
                children: [
                  Expanded(
                    child: _ChipDropdown<String>(
                      label: 'District',
                      value: _selectedDistrict,
                      items: _districts,
                      onChanged: (v) => setState(
                        () => _selectedDistrict = v ?? _selectedDistrict,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ChipDropdown<GenresType>(
                      label: 'Genre',
                      value: _selectedGenre,
                      items: GenresType.values,
                      itemLabel: (g) => g.label,
                      onChanged: (g) {
                        setState(() => _selectedGenre = g);
                        if (g != null) {
                          context.read<HomeBloc>().add(
                            GetObrasByGenre(genre: g),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              BlocSelector<
                HomeBloc,
                HomeState,
                (Status, List<Obra>, List<Theater>, String?)
              >(
                selector: (s) => (s.status, s.obras, s.theaters, s.message),
                builder: (context, tuple) {
                  final (status, obras, theaters, message) = tuple;

                  if (status == Status.loading) {
                    return SizedBox(
                      height: _carouselHeight,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (status == Status.failure) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          message ?? 'Error',
                          style: tt.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    );
                  }

                  if (_isTheaters) {
                    if (theaters.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'No hay teatros para mostrar',
                            style: tt.bodyMedium?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio:
                                0.7, // Adjust as needed to match card design
                          ),
                      itemCount: theaters.length,
                      itemBuilder: (context, i) {
                        return TheaterCard(theater: theaters[i]);
                      },
                    );
                  }

                  if (obras.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No hay obras para mostrar',
                          style: tt.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio:
                              0.7, // Adjust as needed to match card design
                        ),
                    itemCount: obras.length,
                    itemBuilder: (context, i) {
                      final obra = obras[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ObraDetailPage(obra: obra),
                          ),
                        ),
                        child: ObraCard(obra: obra),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundedIcon(
    BuildContext context,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: cs.onSurfaceVariant),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final searchController = TextEditingController();
    final searchService = SearchService();
    bool loading = false;
    List<Obra> searchResults = [];

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: cs.surfaceContainerHigh,
          title: Text(
            'Search service actor',
            style: tt.titleLarge?.copyWith(color: cs.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: searchController,
                style: TextStyle(color: cs.onSurface),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: cs.onSurfaceVariant),
                  prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant),
                ),
                onSubmitted: (query) async {
                  if (query.isEmpty) return;
                  setState(() => loading = true);
                  try {
                    final token = await TokenStorage().read();
                    if (token != null && token.isNotEmpty) {
                      final results = await searchService.searchObras(
                        query: query,
                        token: token,
                      );
                      setState(() {
                        searchResults = results;
                        loading = false;
                      });
                    }
                  } catch (e) {
                    setState(() => loading = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                },
              ),
              if (loading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              if (searchResults.isNotEmpty)
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final obra = searchResults[index];
                      return ListTile(
                        leading: obra.imageUrl.isNotEmpty
                            ? Image.network(
                                obra.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image),
                        title: Text(
                          obra.nombre,
                          style: TextStyle(color: cs.onSurface),
                        ),
                        subtitle: Text(
                          obra.genero,
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ObraDetailPage(obra: obra),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Close', style: TextStyle(color: cs.primary)),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------- Helpers UI (respetan tu ColorScheme) ----------

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.title, required this.highlight, this.onTap});
  final String title;
  final String highlight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                children: [
                  TextSpan(text: '$title '),
                  TextSpan(
                    text: highlight,
                    style: tt.titleMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: cs.primary,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.arrow_right_alt, color: cs.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedTwo extends StatelessWidget {
  const _SegmentedTwo({
    required this.leftLabel,
    required this.rightLabel,
    required this.isRightSelected,
    required this.onChanged,
  });

  final String leftLabel;
  final String rightLabel;
  final bool isRightSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: _segItem(
              label: leftLabel,
              selected: !isRightSelected,
              onTap: () => onChanged(false),
              cs: cs,
              tt: tt,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _segItem(
              label: rightLabel,
              selected: isRightSelected,
              onTap: () => onChanged(true),
              cs: cs,
              tt: tt,
            ),
          ),
        ],
      ),
    );
  }

  Widget _segItem({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required ColorScheme cs,
    required TextTheme tt,
  }) {
    return Material(
      color: selected ? cs.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Text(
            label,
            style: tt.labelLarge?.copyWith(
              color: selected ? cs.onPrimary : cs.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipDropdown<T> extends StatelessWidget {
  const _ChipDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.itemLabel,
    this.onChanged,
  });

  final String label;
  final T? value;
  final List<T> items;
  final String Function(T value)? itemLabel;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final labeler = (T v) => itemLabel != null ? itemLabel!(v) : v.toString();

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: Text(
            label,
            style: tt.labelLarge?.copyWith(color: cs.onSurfaceVariant),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
          dropdownColor: cs.surfaceContainerHigh,
          style: tt.bodyLarge?.copyWith(color: cs.onSurface),
          items: items.map((e) {
            return DropdownMenuItem<T>(value: e, child: Text(labeler(e)));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
