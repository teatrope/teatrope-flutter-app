import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/presentation/pages/obra_detail_page.dart';
import 'package:teatrope_flutter_app/features/home/widgets/obra_card.dart';

import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_event.dart';

class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(const LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: DarkBlurBackground(
        child: SafeArea(
          child: Column(
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

              // Content
              Expanded(
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    final List<Obra> obras = state.obras;

                    if (obras.isEmpty) {
                      return Center(
                        child: Text(
                          'No favorites yet',
                          style: tt.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: obras.length,
                      itemBuilder: (context, index) {
                        final obra = obras[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ObraDetailPage(obra: obra),
                              ),
                            ),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ObraCard(obra: obra),
                            ),
                          ),
                        );
                      },
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
}
