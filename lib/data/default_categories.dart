import 'package:drift/drift.dart';
import 'package:monity/data/database.dart';

final List<CategoriasCompanion> defaultIncomeCategories = [
  CategoriasCompanion(
    nombre: Value('Salario / Nómina'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#2ecc71'),
  ),
  CategoriasCompanion(
    nombre: Value('Ingresos de Autónomo / Freelance'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#27ae60'),
  ),
  CategoriasCompanion(
    nombre: Value('Alquileres'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#1abc9c'),
  ),
  CategoriasCompanion(
    nombre: Value('Inversiones'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#16a085'),
  ),
  CategoriasCompanion(
    nombre: Value('Venta de Artículos'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#f1c40f'),
  ),
  CategoriasCompanion(
    nombre: Value('Regalos y Ayudas'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#f39c12'),
  ),
  CategoriasCompanion(
    nombre: Value('Reembolsos / Devoluciones'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#e67e22'),
  ),
];

final List<CategoriasCompanion> defaultExpenseCategories = [
  CategoriasCompanion(
    nombre: Value('Vivienda'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#e74c3c'),
  ),
  CategoriasCompanion(
    nombre: Value('Alimentación'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#c0392b'),
  ),
  CategoriasCompanion(
    nombre: Value('Transporte'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#3498db'),
  ),
  CategoriasCompanion(
    nombre: Value('Ocio'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#2980b9'),
  ),
  CategoriasCompanion(
    nombre: Value('Compras'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#9b59b6'),
  ),
  CategoriasCompanion(
    nombre: Value('Salud y Cuidado Personal'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#8e44ad'),
  ),
  CategoriasCompanion(
    nombre: Value('Préstamos'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#34495e'),
  ),
  CategoriasCompanion(
    nombre: Value('Otros'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#95a5a6'),
  ),
];