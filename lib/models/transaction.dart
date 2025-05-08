import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final bool isIncome;

  @HiveField(6)
  final String accountId;

  @HiveField(7) // Nuevo campo para la categoría de origen.
  final String? originalCategory;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.description,
    required this.isIncome,
    required this.accountId,
    this.originalCategory, // Campo opcional.
  });
}
