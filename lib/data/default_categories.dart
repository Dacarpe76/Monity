import 'package:drift/drift.dart';
import 'package:monity/data/database.dart';

const List<CategoriasCompanion> defaultIncomeCategories = [
  CategoriasCompanion(
    nombre: Value('Alquileres'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#d35400'),
  ),
  CategoriasCompanion(
    nombre: Value('Becas'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#f39c12'),
  ),
  CategoriasCompanion(
    nombre: Value('Bonificaciones'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#e74c3c'),
  ),
  CategoriasCompanion(
    nombre: Value('Dividendos'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#8e44ad'),
  ),
  CategoriasCompanion(
    nombre: Value('Herencias'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#9b59b6'),
  ),
  CategoriasCompanion(
    nombre: Value('Intereses Bancarios'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#27ae60'),
  ),
  CategoriasCompanion(
    nombre: Value('Inversiones'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#f1c40f'),
  ),
  CategoriasCompanion(
    nombre: Value('Otros'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#95a5a6'),
  ),
  CategoriasCompanion(
    nombre: Value('Pensión'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#16a085'),
  ),
  CategoriasCompanion(
    nombre: Value('Premios'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#34495e'),
  ),
  CategoriasCompanion(
    nombre: Value('Regalos'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#3498db'),
  ),
  CategoriasCompanion(
    nombre: Value('Reembolsos'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#2980b9'),
  ),
  CategoriasCompanion(
    nombre: Value('Salario'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#2ecc71'),
  ),
  CategoriasCompanion(
    nombre: Value('Ventas'),
    tipo: Value(TipoCategoria.ingreso),
    color: Value('#c0392b'),
  ),
];

const List<CategoriasCompanion> defaultExpenseCategories = [
  CategoriasCompanion(
    nombre: Value('Comida y Bebida'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#e74c3c'),
  ),
  CategoriasCompanion(
    nombre: Value('Educación'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#e67e22'),
  ),
  CategoriasCompanion(
    nombre: Value('Mascotas'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#34495e'),
  ),
  CategoriasCompanion(
    nombre: Value('Ocio'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#f1c40f'),
  ),
  CategoriasCompanion(
    nombre: Value('Préstamos'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#7f8c8d'),
  ),
  CategoriasCompanion(
    nombre: Value('Otros'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#95a5a6'),
  ),
  CategoriasCompanion(
    nombre: Value('Ropa y Accesorios'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#1abc9c'),
  ),
  CategoriasCompanion(
    nombre: Value('Salud'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#2ecc71'),
  ),
  CategoriasCompanion(
    nombre: Value('Transporte'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#3498db'),
  ),
  CategoriasCompanion(
    nombre: Value('Vivienda'),
    tipo: Value(TipoCategoria.gasto),
    color: Value('#9b59b6'),
  ),
];
