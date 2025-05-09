// d:\monity\lib\models\transaction.dart
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String accountId;

  @HiveField(2)
  String description;

  @HiveField(3)
  double amount;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  bool isIncome;

  @HiveField(6)
  String category;

  @HiveField(7)
  String? originalCategory;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.category,
    required this.description,
    required this.isIncome,
    required this.accountId,
    this.originalCategory,
  });
}
