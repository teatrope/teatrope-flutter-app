import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/home/presentation/pages/obra_detail_page.dart';

class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          final List<Obra> obras = state.obras;

          if (obras.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          return ListView.separated(
            itemCount: obras.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final o = obras[i];
              return ListTile(
                leading: o.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(o.imageUrl, width: 56, height: 56, fit: BoxFit.cover),
                      )
                    : const Icon(Icons.image_not_supported),
                title: Text(o.nombre, style: tt.titleMedium),
                subtitle: Text(o.genero),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ObraDetailPage(obra: o)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
