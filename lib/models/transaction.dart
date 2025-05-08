// d:\monity\lib\models\transaction.dart
import 'package:hive/hive.dart';

part 'transaction.g.dart'; // Necesitarás generar este archivo

@HiveType(typeId: 1) // Asegúrate de que typeId sea único
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String
      accountId; // Opcional si la transacción solo vive dentro de Account.transactions

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double amount; // Asumimos que es siempre positivo

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final bool isIncome; // true para ingreso, false para gasto

  @HiveField(6)
  final String category; // Opcional, para categorizar transacciones

  @HiveField(7) // Siguiente índice de campo disponible
  final String? originalCategory; // Categoría original, opcional

  Transaction({
    required this.id,
    required this.accountId,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.category,
    this.originalCategory,
  });

  // Ejemplo de fromMap, si lo necesitas para Account.fromMap
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      accountId: map['accountId'] as String,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date'] as String),
      isIncome: map['isIncome'] as bool,
      category: map['categoryId'] as String,
      originalCategory: map['originalCategory'] as String?,
    );
  }

  // Ejemplo de toMap, si lo necesitas para Account.toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'isIncome': isIncome,
      'categoryId': category,
      'originalCategory': originalCategory,
    };
  }
}
