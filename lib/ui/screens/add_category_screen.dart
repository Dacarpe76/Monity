import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';

class AddCategoryScreen extends ConsumerStatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  ConsumerState<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends ConsumerState<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Color _selectedColor = Colors.blue;
  TipoCategoria _tipo = TipoCategoria.gasto;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCategory() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final colorString = '#${_selectedColor.red.toRadixString(16).padLeft(2, '0')}${_selectedColor.green.toRadixString(16).padLeft(2, '0')}${_selectedColor.blue.toRadixString(16).padLeft(2, '0')}'.toUpperCase();

      await ref.read(categoriasDaoProvider).upsertCategoria(
            CategoriasCompanion.insert(
              nombre: _nameController.text,
              tipo: _tipo,
              color: colorString,
              icono: const drift.Value(''),
            ),
          );
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Categoría'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TipoCategoria>(
                initialValue: _tipo,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: TipoCategoria.values.map((TipoCategoria type) {
                  return DropdownMenuItem<TipoCategoria>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _tipo = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Color:'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Selecciona un color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: _selectedColor,
                              onColorChanged: (color) {
                                setState(() {
                                  _selectedColor = color;
                                });
                              },
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Hecho'),
                            )
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveCategory,
                child: const Text('Guardar Categoría'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}