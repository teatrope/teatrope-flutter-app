import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_bloc.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_event.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_state.dart';

class AddObraPage extends StatefulWidget {
  const AddObraPage({super.key});

  @override
  State<AddObraPage> createState() => _AddObraPageState();
}

class _AddObraPageState extends State<AddObraPage> {
  final _tituloController = TextEditingController();
  final _directorNombreController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _buyUrlController = TextEditingController();
  String? _selectedGenero;
  String? _selectedDirectorRol;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _tituloController.dispose();
    _directorNombreController.dispose();
    _imageUrlController.dispose();
    _buyUrlController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final state = context.read<AdminBloc>().state;
    if (state.selectedTheater == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Add'),
        content: const Text('Are you sure you want to add this play?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final newData = {
        'teatro': state.selectedTheater!.id,
        'titulo': _tituloController.text,
        'genero': _selectedGenero,
        'director_nombre': _directorNombreController.text,
        'director_rol': _selectedDirectorRol,
        'image_url': _imageUrlController.text,
        'buy_url': _buyUrlController.text,
      };

      if (mounted) {
        context.read<AdminBloc>().add(CreateObra(newData));
      }
    }
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listenWhen: (previous, current) =>
          previous.updateStatus != current.updateStatus,
      listener: (context, state) {
        if (state.updateStatus == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Play added successfully')),
          );
          Navigator.pop(context);
        } else if (state.updateStatus == Status.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('Add Play'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: DarkBlurBackground(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Theater Name (Read-only)
                        BlocBuilder<AdminBloc, AdminState>(
                          builder: (context, state) {
                            return Text(
                              'Theater: ${state.selectedTheater?.nombre ?? "Unknown"}',
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Image Preview
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _imageUrlController.text,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey,
                                child: const Icon(
                                  Icons.add_photo_alternate,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        TextFormField(
                          controller: _tituloController,
                          decoration: const InputDecoration(labelText: 'Title'),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),

                        // Genre
                        DropdownButtonFormField<String>(
                          value: _selectedGenero,
                          decoration: const InputDecoration(labelText: 'Genre'),
                          items: ['DRAMA', 'COMEDIA', 'MUSICAL', 'EXPERIMENTAL']
                              .map(
                                (g) =>
                                    DropdownMenuItem(value: g, child: Text(g)),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _selectedGenero = v),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),

                        // Director Name
                        TextFormField(
                          controller: _directorNombreController,
                          decoration: const InputDecoration(
                            labelText: 'Director Name',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Director Role
                        DropdownButtonFormField<String>(
                          value: _selectedDirectorRol,
                          decoration: const InputDecoration(labelText: 'Role'),
                          items: ['DIRECTOR', 'ACTOR']
                              .map(
                                (r) =>
                                    DropdownMenuItem(value: r, child: Text(r)),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedDirectorRol = v),
                        ),
                        const SizedBox(height: 16),

                        // Image URL
                        TextFormField(
                          controller: _imageUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Image URL',
                          ),
                          onChanged: (_) => setState(() {}), // Update preview
                        ),
                        const SizedBox(height: 16),

                        // Buy URL
                        TextFormField(
                          controller: _buyUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Buy URL',
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _onCancel,
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: FilledButton(
                                onPressed: _onSave,
                                child: const Text('Add'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Loading Overlay
          BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              if (state.updateStatus == Status.loading) {
                return Container(
                  color: Colors.black54,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
