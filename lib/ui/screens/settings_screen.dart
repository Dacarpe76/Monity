import 'package:drift/drift.dart' as drift;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:monity/ui/screens/add_category_screen.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:convert';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          _buildDisplaySettingsSection(ref, context),
          const Divider(),
          _buildCuentasSection(ref, context),
          const Divider(),
          _buildCategoriasSection(ref, context, TipoCategoria.ingreso),
          const Divider(),
          _buildCategoriasSection(ref, context, TipoCategoria.gasto),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Añadir nueva categoría'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCategoryScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Exportar transacciones a CSV'),
            onTap: () => _exportCsv(ref, context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.upload),
            title: const Text('Importar transacciones desde CSV'),
            onTap: () => _importCsv(ref, context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Borrar todos los datos'),
            onTap: () => _showResetConfirmationDialog(ref, context),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplaySettingsSection(WidgetRef ref, BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    return settings.when(
      data: (appSettings) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Pantalla Principal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SwitchListTile(
              title: const Text('Mostrar límite de presupuesto'),
              value: appSettings.showBudgetLimit,
              onChanged: (value) {
                ref.read(appSettingsDaoProvider).updateSettings(
                      AppSettingsCompanion(showBudgetLimit: drift.Value(value)),
                    );
              },
            ),
            SwitchListTile(
              title: const Text('Mostrar límite'),
              value: appSettings.showMaxBalance,
              onChanged: (value) {
                ref.read(appSettingsDaoProvider).updateSettings(
                      AppSettingsCompanion(showMaxBalance: drift.Value(value)),
                    );
              },
            ),
            SwitchListTile(
              title: const Text('Mostrar gasto mensual'),
              value: appSettings.showMonthlySpending,
              onChanged: (value) {
                ref.read(appSettingsDaoProvider).updateSettings(
                      AppSettingsCompanion(
                          showMonthlySpending: drift.Value(value)),
                    );
              },
            ),
            SwitchListTile(
              title: const Text('Mostrar proyección'),
              value: appSettings.showProjection,
              onChanged: (value) {
                ref.read(appSettingsDaoProvider).updateSettings(
                      AppSettingsCompanion(showProjection: drift.Value(value)),
                    );
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildCuentasSection(WidgetRef ref, BuildContext context) {
    final cuentasStream = ref.watch(cuentasDaoProvider).watchAllCuentas();
    return StreamBuilder<List<Cuenta>>(
      stream: cuentasStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return ListTile(
            title: const Text('No hay cuentas'),
            subtitle: const Text('Añade una cuenta para empezar'),
            onTap: () => _addAccount(context, ref),
          );
        }

        final cuentas = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Cuentas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) async {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final reorderedCuentas = List.of(cuentas);
                final movedCuenta = reorderedCuentas.removeAt(oldIndex);
                reorderedCuentas.insert(newIndex, movedCuenta);

                for (var i = 0; i < reorderedCuentas.length; i++) {
                  await ref
                      .read(cuentasDaoProvider)
                      .updateOrden(reorderedCuentas[i].id, i);
                }
              },
              children: [
                for (final cuenta in cuentas)
                  ListTile(
                    key: ValueKey(cuenta.id),
                    title: Text(cuenta.nombre),
                    subtitle: Text(
                        'Saldo: ${cuenta.saldoActual} / Límite: ${cuenta.limiteGastoMensual} / Máximo: ${cuenta.saldoMaximoMensual}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editAccount(context, ref, cuenta),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteAccount(context, ref, cuenta),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Añadir nueva cuenta'),
              onTap: () => _addAccount(context, ref),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoriasSection(
      WidgetRef ref, BuildContext context, TipoCategoria tipo) {
    final categoriesProvider = ref.watch(sortedCategoriesProvider);

    return categoriesProvider.when(
      data: (categoriesWithUsage) {
        final categories = categoriesWithUsage
            .where((c) => c.categoria.tipo == tipo)
            .map((c) => c.categoria)
            .toList();

        if (categories.isEmpty) {
          return ListTile(
            title:
                Text('No hay categorías de ${tipo.toString().split('.').last}'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categorías de ${tipo.toString().split('.').last}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCategoriesList(ref, context, categories),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildCategoriesList(
      WidgetRef ref, BuildContext context, List<Categoria> categories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final color = _safeParseColor(category.color);
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(category.nombre[0]),
          ),
          title: Text(category.nombre),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editCategory(context, ref, category),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final dao = ref.read(categoriasDaoProvider);
                  await dao.deleteCategoria(category.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Color _safeParseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.grey;
    }
  }

  void _addAccount(BuildContext context, WidgetRef ref) {
    final nombreController = TextEditingController();
    final saldoActualController = TextEditingController();
    final saldoMaximoMensualController = TextEditingController();
    final limiteGastoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir Cuenta'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: saldoActualController,
                decoration: const InputDecoration(labelText: 'Saldo Actual'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: saldoMaximoMensualController,
                decoration:
                    const InputDecoration(labelText: 'Saldo Máximo Mensual'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: limiteGastoController,
                decoration:
                    const InputDecoration(labelText: 'Límite de Gasto Mensual'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final dao = ref.read(cuentasDaoProvider);
              final newAccount = CuentasCompanion.insert(
                nombre: nombreController.text,
                saldoActual: double.parse(saldoActualController.text),
                saldoMaximoMensual:
                    double.parse(saldoMaximoMensualController.text),
                limiteGastoMensual: double.parse(limiteGastoController.text),
                orden: drift.Value((await dao.allCuentas).length),
              );
              await dao.upsertCuenta(newAccount);
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _editAccount(BuildContext context, WidgetRef ref, Cuenta cuenta) {
    final nombreController = TextEditingController(text: cuenta.nombre);
    final saldoActualController =
        TextEditingController(text: cuenta.saldoActual.toString());
    final saldoMaximoController =
        TextEditingController(text: cuenta.saldoMaximoMensual.toString());
    final limiteGastoController =
        TextEditingController(text: cuenta.limiteGastoMensual.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Cuenta'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: saldoActualController,
                decoration: const InputDecoration(labelText: 'Saldo Actual'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: saldoMaximoController,
                decoration:
                    const InputDecoration(labelText: 'Saldo Máximo Mensual'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: limiteGastoController,
                decoration:
                    const InputDecoration(labelText: 'Límite de Gasto Mensual'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final newNombre = nombreController.text;
              final newSaldo = double.tryParse(saldoActualController.text) ??
                  cuenta.saldoActual;
              final newSaldoMaximo =
                  double.tryParse(saldoMaximoController.text) ??
                      cuenta.saldoMaximoMensual;
              final newLimiteGasto =
                  double.tryParse(limiteGastoController.text) ??
                      cuenta.limiteGastoMensual;

              final updatedCuenta = cuenta.copyWith(
                nombre: newNombre,
                saldoActual: newSaldo,
                saldoMaximoMensual: newSaldoMaximo,
                limiteGastoMensual: newLimiteGasto,
              );
              await ref
                  .read(cuentasDaoProvider)
                  .upsertCuenta(updatedCuenta.toCompanion(true));
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _deleteAccount(BuildContext context, WidgetRef ref, Cuenta cuenta) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Cuenta'),
        content: Text(
            '¿Estás seguro de que deseas eliminar la cuenta "${cuenta.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(cuentasDaoProvider).deleteCuenta(cuenta.id);
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _editCategory(BuildContext context, WidgetRef ref, Categoria category) {
    final nombreController = TextEditingController(text: category.nombre);
    Color selectedColor = _safeParseColor(category.color);
    TipoCategoria tipo = category.tipo;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Categoría'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  DropdownButton<TipoCategoria>(
                    value: tipo,
                    items: TipoCategoria.values.map((TipoCategoria aType) {
                      return DropdownMenuItem<TipoCategoria>(
                        value: aType,
                        child: Text(aType.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        tipo = newValue!;
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
                                  pickerColor: selectedColor,
                                  onColorChanged: (color) {
                                    setState(() {
                                      selectedColor = color;
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
                            color: selectedColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
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
              final colorString =
                  '#${selectedColor.value.toRadixString(16).substring(2)}'
                      .toUpperCase();
              final updatedCategory = category.copyWith(
                nombre: nombreController.text,
                tipo: tipo,
                color: colorString,
              );
              await ref
                  .read(categoriasDaoProvider)
                  .upsertCategoria(updatedCategory.toCompanion(true));
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _importCsv(WidgetRef ref, BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        final content = await file.readAsString(encoding: Latin1Codec());
        final List<List<dynamic>> rows =
            const CsvToListConverter().convert(content);
        rows.removeAt(0); // Remove header

        final cuentasDao = ref.read(cuentasDaoProvider);
        final categoriasDao = ref.read(categoriasDaoProvider);
        final gastosDao = ref.read(gastosDaoProvider);
        final ingresosDao = ref.read(ingresosDaoProvider);
        final transaccionesDao = ref.read(transaccionesDaoProvider);

        for (final row in rows) {
          final fecha = DateTime.parse(row[1]);
          final cuentaNombre = row[2].toString();
          final tipoString = row[3].toString().split('.').last;
          final cantidad = double.parse(row[4].toString());
          final concepto = row[5].toString();
          final categoriaNombre = row[6].toString();

          var cuenta = await (cuentasDao.select(cuentasDao.cuentas)
                ..where((tbl) => tbl.nombre.equals(cuentaNombre)))
              .getSingleOrNull();
          if (cuenta == null) {
            final newAccount = CuentasCompanion.insert(
              nombre: cuentaNombre,
              saldoActual: 0,
              saldoMaximoMensual: 1000,
              limiteGastoMensual: 500,
              orden: drift.Value((await cuentasDao.allCuentas).length),
            );
            await cuentasDao.upsertCuenta(newAccount);
            cuenta = await (cuentasDao.select(cuentasDao.cuentas)
                  ..where((tbl) => tbl.nombre.equals(cuentaNombre)))
                .getSingleOrNull();
          }

          final tipo = tipoString == 'ingreso'
              ? TipoCategoria.ingreso
              : TipoCategoria.gasto;
          var categoria = await categoriasDao.getCategoryByNameAndType(
              categoriaNombre, tipo.index);
          if (categoria == null) {
            final newCategory = CategoriasCompanion.insert(
              nombre: categoriaNombre,
              tipo: tipo,
              color: '#FF0000',
            );
            await categoriasDao.upsertCategoria(newCategory);
            categoria = await categoriasDao.getCategoryByNameAndType(
                categoriaNombre, tipo.index);
          }

          if (tipo == TipoCategoria.gasto) {
            final gasto = GastosCompanion.insert(
              cantidad: cantidad,
              concepto: concepto,
              fecha: fecha,
              idCategoria: categoria!.id,
            );
            final gastoId = await gastosDao.insertGasto(gasto);

            final transaccion = TransaccionesCompanion.insert(
              idCuenta: cuenta!.id,
              cantidad: cantidad,
              tipo: TipoTransaccion.gasto,
              fecha: fecha,
              idGasto: drift.Value(gastoId),
            );
            await transaccionesDao.insertTransaccion(transaccion);
          } else {
            final ingreso = IngresosCompanion.insert(
              cantidadTotal: cantidad,
              fecha: fecha,
              idCategoria: categoria!.id,
            );
            final ingresoId = await ingresosDao.insertIngreso(ingreso);

            final transaccion = TransaccionesCompanion.insert(
              idCuenta: cuenta!.id,
              cantidad: cantidad,
              tipo: TipoTransaccion.ingreso,
              fecha: fecha,
              idIngreso: drift.Value(ingresoId),
            );
            await transaccionesDao.insertTransaccion(transaccion);
          }

          final updatedCuenta = cuenta.copyWith(
            saldoActual: cuenta.saldoActual + cantidad,
          );
          await cuentasDao.upsertCuenta(updatedCuenta.toCompanion(true));
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CSV importado correctamente')),
        );
      } else {
        // User canceled the picker
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al importar el CSV: $e')),
      );
    }
  }

  void _exportCsv(WidgetRef ref, BuildContext context) async {
    final transactions =
        await ref.read(transaccionesDaoProvider).allTransacciones;
    List<List<dynamic>> rows = [];
    rows.add(
        ['ID', 'Fecha', 'Tipo', 'Cantidad', 'Concepto', 'Categoria', 'Cuenta']);

    for (var tx in transactions) {
      rows.add([
        tx.id,
        tx.fecha.toIso8601String(),
        tx.tipo.toString(),
        tx.cantidad,
        tx.idGasto,
        tx.idIngreso,
        tx.idCuenta,
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/monity_transactions.csv";
    final file = File(path);
    await file.writeAsString(csv);

    await Share.shareXFiles([XFile(path)], text: 'Transacciones de Monity');
  }

  void _showResetConfirmationDialog(WidgetRef ref, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar reseteo'),
          content: const Text(
              '¿Estás seguro de que quieres borrar todos los datos? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Resetear'),
              onPressed: () async {
                await ref.read(databaseProvider).resetDatabase();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
