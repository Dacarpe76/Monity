import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PrizeScreen extends ConsumerWidget {
  const PrizeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePrizeStream = ref.watch(premiosDaoProvider).watchActivePremio();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premios'),
        centerTitle: true,
      ),
      body: StreamBuilder<Premio?>(
        stream: activePrizeStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final activePrize = snapshot.data;

          if (activePrize == null) {
            return _buildNoPrizeView(context, ref);
          } else {
            return _buildPrizeView(context, ref, activePrize);
          }
        },
      ),
    );
  }

  Widget _buildNoPrizeView(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No hay ningún premio activo.'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _showAddPrizeDialog(context, ref),
            child: const Text('Crear nuevo premio'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeView(BuildContext context, WidgetRef ref, Premio prize) {
    final progress = prize.acumulado / prize.importe;
    final remaining = prize.importe - prize.acumulado;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (prize.fotoPath.isNotEmpty)
            Image.file(
              File(prize.fotoPath),
              height: 200,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 20),
          Text(
            prize.nombre,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '${prize.acumulado.toStringAsFixed(2)} € / ${prize.importe.toStringAsFixed(2)} €',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            minHeight: 10,
          ),
          const SizedBox(height: 10),
          Text(
            'Faltan ${remaining.toStringAsFixed(2)} € para conseguir tu premio.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await ref.read(premiosDaoProvider).upsertPremio(prize.copyWith(isCompleted: true).toCompanion(true));
            },
            child: const Text('Marcar como conseguido'),
          ),
        ],
      ),
    );
  }

  void _showAddPrizeDialog(BuildContext context, WidgetRef ref) {
    final nombreController = TextEditingController();
    final importeController = TextEditingController();
    XFile? image;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir nuevo premio'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre del premio'),
                    ),
                    TextField(
                      controller: importeController,
                      decoration: const InputDecoration(labelText: 'Importe'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    image == null
                        ? ElevatedButton(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                setState(() {
                                  image = pickedImage;
                                });
                              }
                            },
                            child: const Text('Seleccionar foto'),
                          )
                        : Image.file(
                            File(image!.path),
                            height: 100,
                          ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (image != null) {
                  final appDir = await getApplicationDocumentsDirectory();
                  final fileName = p.basename(image!.path);
                  final savedImage = await File(image!.path).copy('${appDir.path}/$fileName');

                  final newPrize = PremiosCompanion.insert(
                    nombre: nombreController.text,
                    importe: double.parse(importeController.text),
                    fotoPath: savedImage.path,
                  );
                  await ref.read(premiosDaoProvider).upsertPremio(newPrize);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}