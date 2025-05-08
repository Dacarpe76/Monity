import 'package:hive/hive.dart';
import 'transaction.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  double balance;

  @HiveField(3)
  final double limitSpend;

  @HiveField(4)
  final double monthlyLimit;

  @HiveField(5) // Asegúrate de que esta línea exista.
  final List<Transaction> transactions;

  @HiveField(6)
  int order;

  Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.limitSpend,
    required this.monthlyLimit,
    this.transactions = const [], // Valor predeterminado.
    this.order = 0,
  });
  // Método copyWith
  Account copyWith({
    String? id,
    String? name,
    double? balance,
    double? limitSpend,
    double? monthlyLimit,
    List<Transaction>? transactions,
    int? order,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      limitSpend: limitSpend ?? this.limitSpend,
      monthlyLimit: monthlyLimit ?? this.monthlyLimit,
      transactions: transactions ?? this.transactions,
      order: order ?? this.order,
    );
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    if (transaction.isIncome) {
      balance += transaction.amount;
    } else {
      balance -= transaction.amount;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'limitSpend': limitSpend,
      'monthlyLimit': monthlyLimit,
      'order': order, // Incluir el campo 'order' en el mapa.
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
      limitSpend: map['limitSpend'],
      monthlyLimit: map['monthlyLimit'],
      order: map['order'], // Leer el campo 'order' del mapa.
    );
  }
}
