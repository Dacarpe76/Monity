import 'package:hive/hive.dart';
import 'transaction.dart'; // Asegúrate de que este import sea correcto y Transaction esté definido

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
  final double limitSpend; // Límite de gasto mensual

  @HiveField(4)
  final double monthlyLimit; // Límite de ingreso mensual (según tu aclaración)

  @HiveField(5)
  final List<Transaction> transactions;

  @HiveField(6)
  int order;

  Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.limitSpend,
    required this.monthlyLimit,
    this.transactions = const [],
    this.order = 0,
  });

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
    // Considera llamar a save() si quieres persistir este cambio inmediatamente
    // si Account es un HiveObject y está en una caja abierta.
    // Ejemplo: if (isInBox) { save(); }
  }

  // Calcula el gasto total para esta cuenta en un mes y año específicos.
  // Asume que las transacciones de gasto tienen `isIncome == false`.
  // Asume que `transaction.amount` es siempre un valor positivo.
  double getMonthlySpending(int month, int year) {
    double spending = 0;
    for (var transaction in transactions) {
      if (!transaction.isIncome &&
          transaction.date.month == month &&
          transaction.date.year == year) {
        spending += transaction.amount;
      }
    }
    return spending;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'limitSpend': limitSpend,
      'monthlyLimit': monthlyLimit,
      'order': order,
      // Nota: 'transactions' no se incluye aquí, generalmente se manejan por separado
      // o se serializan de forma diferente si es necesario para toMap/fromMap.
      // Si necesitas serializar/deserializar transacciones con este método,
      // deberás añadir lógica para convertir List<Transaction> a List<Map> y viceversa.
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
      limitSpend: map['limitSpend'],
      monthlyLimit: map['monthlyLimit'],
      order: map['order'],
      // Nota: 'transactions' no se carga desde el mapa aquí.
      // Si necesitas esto, deberás añadir lógica para convertir List<Map> a List<Transaction>.
      // Por lo general, con Hive, las relaciones se manejan a través de HiveList o referencias.
      transactions: (map['transactions'] as List<dynamic>?)
              ?.map((t) => Transaction.fromMap(t as Map<String,
                  dynamic>)) // Asumiendo que Transaction tiene fromMap
              .toList() ??
          const [],
    );
  }
}
