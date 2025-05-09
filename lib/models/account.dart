import 'package:hive/hive.dart';
import 'transaction.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double balance;

  @HiveField(3)
  double monthlyLimit;

  @HiveField(4)
  double limitSpend;

  @HiveField(5)
  int order;

  Account({
    required this.id,
    required this.name,
    this.balance = 0.0,
    this.monthlyLimit = 0.0,
    this.limitSpend = 0.0,
    this.order = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'monthlyLimit': monthlyLimit,
      'limitSpend': limitSpend,
      'order': order,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as String,
      name: map['name'] as String,
      balance: map['balance'] as double,
      monthlyLimit: map['monthlyLimit'] as double,
      limitSpend: map['limitSpend'] as double,
      order: map['order'] as int,
    );
  }

  Account copyWith({
    String? id,
    String? name,
    double? balance,
    double? monthlyLimit,
    double? limitSpend,
    int? order,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      monthlyLimit: monthlyLimit ?? this.monthlyLimit,
      limitSpend: limitSpend ?? this.limitSpend,
      order: order ?? this.order,
    );
  }

  double getMonthlySpending(int month, int year) {
    final box = Hive.box<Transaction>('transactions');
    if (!box.isOpen) return 0.0;

    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);

    final transactions = box.values.where((t) {
      if (t.accountId != id || t.isIncome) return false;

      return t.date
              .isAfter(firstDayOfMonth.subtract(const Duration(days: 1))) &&
          t.date.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
    });

    return transactions.fold(0.0, (sum, t) => sum + t.amount);
  }
}
