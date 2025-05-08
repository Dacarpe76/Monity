import 'package:hive/hive.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../models/category.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  // Métodos para abrir cajas de Hive
  Future<Box<Account>> get accountsBox async =>
      await Hive.openBox<Account>('accounts');
  Future<Box<Transaction>> get transactionsBox async =>
      await Hive.openBox<Transaction>('transactions');
  Future<Box<Category>> get categoriesBox async =>
      await Hive.openBox<Category>('categories');

  // Método para inicializar cuentas predeterminadas
  Future<void> initializeDefaultAccounts() async {
    final box = await accountsBox;
    if (box.isEmpty) {
      final defaultAccounts = [
        Account(
          id: '1',
          name: 'Bolsillo',
          balance: 0.0,
          limitSpend: 150.0,
          monthlyLimit: 300.0,
          transactions: [], // Lista vacía de transacciones.
          order: 0, // Orden inicial.
        ),
        Account(
          id: '2',
          name: 'Diario',
          balance: 0.0,
          limitSpend: 700.0,
          monthlyLimit: 1000.0,
          transactions: [], // Lista vacía de transacciones.
          order: 1, // Orden inicial.
        ),
        Account(
          id: '3',
          name: 'Imprevistos',
          balance: 0.0,
          limitSpend: 500.0,
          monthlyLimit: 3000.0,
          transactions: [], // Lista vacía de transacciones.
          order: 2, // Orden inicial.
        ),
        Account(
          id: '4',
          name: 'Emergencias',
          balance: 0.0,
          limitSpend: 300.0,
          monthlyLimit: 10000.0,
          transactions: [], // Lista vacía de transacciones.
          order: 3, // Orden inicial.
        ),
        Account(
          id: '5',
          name: 'Ahorro',
          balance: 0.0,
          limitSpend: 1.0,
          monthlyLimit: 1000000.0,
          transactions: [], // Lista vacía de transacciones.
          order: 4, // Orden inicial.
        ),
      ];

      for (final account in defaultAccounts) {
        await addAccount(account);
      }
    }
  }

  // Método para inicializar categorías predeterminadas
  Future<void> initializeDefaultCategories() async {
    final box = await categoriesBox;
    if (box.isEmpty) {
      final defaultCategories = [
        // Categorías de Ingreso
        Category(name: 'Alquileres', isIncome: true),
        Category(name: 'Comisiones', isIncome: true),
        Category(name: 'Inversiones', isIncome: true),
        Category(name: 'Negocio', isIncome: true),
        Category(name: 'Pensiones', isIncome: true),
        Category(name: 'Royalties', isIncome: true),
        Category(name: 'Salario', isIncome: true),
        Category(name: 'Ventas', isIncome: true),
        Category(name: 'Freelance', isIncome: true),
        Category(name: 'Herencias', isIncome: true),

        // Categorías de Gasto
        Category(name: 'Alimentación', isIncome: false),
        Category(name: 'Automóvil', isIncome: false),
        Category(name: 'Deportes', isIncome: false),
        Category(name: 'Educación', isIncome: false),
        Category(name: 'Entretenimiento', isIncome: false),
        Category(name: 'Hogar', isIncome: false),
        Category(name: 'Impuestos', isIncome: false),
        Category(name: 'Mascotas', isIncome: false),
        Category(name: 'Moda', isIncome: false),
        Category(name: 'Regalos', isIncome: false),
        Category(name: 'Salud', isIncome: false),
        Category(name: 'Seguros', isIncome: false),
        Category(name: 'Tecnología', isIncome: false),
        Category(name: 'Transporte', isIncome: false),
        Category(name: 'Viajes', isIncome: false),
      ];

      for (final category in defaultCategories) {
        await addCategory(category);
      }
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    final accountsBoxLocal = await accountsBox;
    final transactionsBoxLocal = await transactionsBox;

    // Obtener la cuenta asociada a la transacción
    final account = accountsBoxLocal.get(transaction.accountId);
    if (account == null) {
      throw Exception('Cuenta no encontrada');
    }

    if (transaction.isIncome) {
      // Lógica para ingresos
      final now = DateTime.now();
      final firstDayOfMonth = DateTime(now.year, now.month, 1);
      final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

      // Calcular el acumulado de ingresos del mes
      final monthlyIncomes = transactionsBoxLocal.values.where((t) =>
          t.accountId == transaction.accountId &&
          t.isIncome &&
          t.date.isAfter(firstDayOfMonth.subtract(const Duration(days: 1))) &&
          t.date.isBefore(lastDayOfMonth.add(const Duration(days: 1))));

      final totalMonthlyIncomes =
          monthlyIncomes.fold(0.0, (sum, t) => sum + t.amount);

      // Verificar si el acumulado de ingresos supera el monthlyLimit
      final newMonthlyIncomes = totalMonthlyIncomes + transaction.amount;
      if (newMonthlyIncomes > account.monthlyLimit) {
        // Calcular el excedente
        final excessAmount = newMonthlyIncomes - account.monthlyLimit;

        // Crear una transacción parcial para la cuenta actual
        final partialTransaction = Transaction(
          id: transaction.id,
          amount: transaction.amount - excessAmount,
          date: transaction.date,
          category: transaction.category,
          description: transaction.description,
          isIncome: true,
          accountId: transaction.accountId,
        );

        // Guardar la transacción parcial en transactionsBox
        await transactionsBoxLocal.put(
            partialTransaction.id, partialTransaction);

        // Actualizar el saldo de la cuenta
        account.balance += partialTransaction.amount;
        await accountsBoxLocal.put(account.id, account);

        // Distribuir el excedente a las siguientes cuentas
        if (excessAmount > 0) {
          await _distributeExcessToAccounts(excessAmount, account, transaction);
        }
      } else {
        // El ingreso cabe en la cuenta seleccionada
        account.balance += transaction.amount;
        await accountsBoxLocal.put(account.id, account);
        await transactionsBoxLocal.put(transaction.id, transaction);
      }
    } else {
      // Lógica para gastos
      if (account.balance >= transaction.amount) {
        // El gasto cabe en la cuenta seleccionada
        account.balance -= transaction.amount;
        await accountsBoxLocal.put(account.id, account);
        await transactionsBoxLocal.put(transaction.id, transaction);
      } else {
        // El gasto supera el saldo disponible en la cuenta seleccionada
        final deficit = transaction.amount - account.balance;

        // Crear una transacción parcial para la primera cuenta
        final partialTransaction = Transaction(
          id: DateTime.now().toString(),
          amount: account.balance,
          date: transaction.date,
          category: transaction.category,
          description: transaction.description,
          isIncome: false,
          accountId: transaction.accountId,
        );

        // Registrar la transacción parcial en la primera cuenta
        await transactionsBoxLocal.put(
            partialTransaction.id, partialTransaction);

        // Restablecer el saldo de la primera cuenta a cero
        account.balance = 0.0;
        await accountsBoxLocal.put(account.id, account);

        // Distribuir el déficit entre las demás cuentas
        final remainingAccounts = await getAccountsOrdered();
        await distributeDeficit(
          deficit,
          remainingAccounts.where((acc) => acc.id != account.id).toList(),
          transaction,
        );
      }
    }
  }

  Future<void> _distributeExcessToAccounts(double excessAmount,
      Account currentAccount, Transaction originalTransaction) async {
    final allAccounts = await getAccountsOrdered();

    // Encontrar la posición de la cuenta actual
    final currentIndex =
        allAccounts.indexWhere((acc) => acc.id == currentAccount.id);

    for (int i = currentIndex + 1; i < allAccounts.length; i++) {
      final nextAccount = allAccounts[i];

      // Calcular el acumulado de ingresos del mes para la cuenta
      final now = DateTime.now();
      final firstDayOfMonth = DateTime(now.year, now.month, 1);
      final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

      final transactionsBoxLocal = await transactionsBox;
      final transactions = transactionsBoxLocal.values.where((transaction) =>
          transaction.accountId == nextAccount.id &&
          transaction.isIncome &&
          transaction.date.isAfter(firstDayOfMonth) &&
          transaction.date.isBefore(lastDayOfMonth));

      final totalMonthlyIncomes =
          transactions.fold(0.0, (sum, t) => sum + t.amount);

      // Verificar si la cuenta puede recibir más ingresos
      if (nextAccount.balance < nextAccount.monthlyLimit &&
          totalMonthlyIncomes < nextAccount.monthlyLimit) {
        final availableSpace = nextAccount.monthlyLimit - totalMonthlyIncomes;
        final amountToTransfer =
            excessAmount <= availableSpace ? excessAmount : availableSpace;

        // Crear una nueva transacción para la cuenta
        final excessTransaction = Transaction(
          id: DateTime.now().toString(),
          amount: amountToTransfer,
          date: DateTime.now(),
          category: originalTransaction.category,
          description:
              '${originalTransaction.description} Excedente transferido desde ${currentAccount.name}',
          isIncome: true,
          accountId: nextAccount.id,
        );

        // Guardar la transacción en transactionsBox
        await transactionsBoxLocal.put(excessTransaction.id, excessTransaction);

        // Actualizar el saldo de la cuenta destino
        nextAccount.balance += amountToTransfer;
        final accountsBoxLocal = await accountsBox;
        await accountsBoxLocal.put(nextAccount.id, nextAccount);

        // Reducir el excedente restante
        excessAmount -= amountToTransfer;

        // Salir del bucle si no queda excedente
        if (excessAmount <= 0) break;
      }
    }

    // Si aún queda excedente después de recorrer todas las cuentas, mostrar un mensaje
    if (excessAmount > 0 && currentAccount.name != 'Ahorro') {
      //print('Advertencia: No se pudo distribuir completamente el excedente. Excedente restante: $excessAmount');
    }
  }

  // Lógica para ingresos.
  Future<void> handleIncomeDistribution(Transaction transaction,
      List<Account> accounts, Account targetAccount) async {
    final remainingBalance = targetAccount.monthlyLimit - targetAccount.balance;
    final incomeAmount = transaction.amount;

    if (incomeAmount <= remainingBalance) {
      // El ingreso cabe en la cuenta seleccionada.
      targetAccount.balance += incomeAmount;
      final accountsBoxLocal = await accountsBox;
      await accountsBoxLocal.put(targetAccount.id, targetAccount);
      final transactionsBoxLocal = await transactionsBox;
      await transactionsBoxLocal.put(transaction.id, transaction);
    } else {
      // El ingreso supera el límite de la cuenta seleccionada.
      final excess = incomeAmount - remainingBalance;

      // Crear una transacción parcial para la primera cuenta.
      final partialTransaction = Transaction(
        id: DateTime.now().toString(),
        amount: remainingBalance,
        date: transaction.date,
        category: transaction.category,
        description: transaction.description,
        isIncome: true,
        accountId: targetAccount.id,
      );

      targetAccount.balance += remainingBalance;
      final accountsBoxLocal = await accountsBox;
      await accountsBoxLocal.put(targetAccount.id, targetAccount);
      final transactionsBoxLocal = await transactionsBox;
      await transactionsBoxLocal.put(partialTransaction.id, partialTransaction);

      // Distribuir el excedente entre las demás cuentas.
      final remainingAccounts =
          accounts.where((account) => account.id != targetAccount.id).toList();
      await distributeExcessIncome(excess, remainingAccounts);
    }
  }

  // Distribuir el excedente de ingreso entre las demás cuentas.
  Future<void> distributeExcessIncome(
      double excess, List<Account> accounts) async {
    for (final account in accounts) {
      final remainingBalance = account.monthlyLimit - account.balance;

      if (remainingBalance > 0) {
        if (excess <= remainingBalance) {
          // Asignar todo el excedente a esta cuenta.
          final partialTransaction = Transaction(
            id: DateTime.now().toString(),
            amount: excess,
            date: DateTime.now(),
            category: 'Transferencia',
            description: 'Excedente de ingreso',
            isIncome: true,
            accountId: account.id,
          );

          account.balance += excess;
          final accountsBoxLocal = await accountsBox;
          await accountsBoxLocal.put(account.id, account);
          final transactionsBoxLocal = await transactionsBox;
          await transactionsBoxLocal.put(
              partialTransaction.id, partialTransaction);

          excess = 0; // Ya no queda excedente.
          break;
        } else {
          // Asignar parte del excedente a esta cuenta.
          final partialTransaction = Transaction(
            id: DateTime.now().toString(),
            amount: remainingBalance,
            date: DateTime.now(),
            category: 'Transferencia',
            description: 'Excedente de ingreso',
            isIncome: true,
            accountId: account.id,
          );

          account.balance += remainingBalance;
          final accountsBoxLocal = await accountsBox;
          await accountsBoxLocal.put(account.id, account);
          final transactionsBoxLocal = await transactionsBox;
          await transactionsBoxLocal.put(
              partialTransaction.id, partialTransaction);

          excess -= remainingBalance; // Reducir el excedente.
        }
      }
    }
  }

  // Lógica para gastos.
  Future<void> handleExpenseDistribution(Transaction transaction,
      List<Account> accounts, Account targetAccount) async {
    if (targetAccount.balance >= transaction.amount) {
      // El gasto cabe en la cuenta seleccionada.
      targetAccount.balance -= transaction.amount;
      final accountsBoxLocal = await accountsBox;
      await accountsBoxLocal.put(targetAccount.id, targetAccount);
      final transactionsBoxLocal = await transactionsBox;
      await transactionsBoxLocal.put(transaction.id, transaction);
    } else {
      // El gasto supera el saldo disponible en la cuenta seleccionada.
      final deficit = transaction.amount - targetAccount.balance;

      // Crear una transacción parcial para la primera cuenta.
      final partialTransaction = Transaction(
        id: DateTime.now().toString(),
        amount: targetAccount.balance,
        date: transaction.date,
        category: transaction.category,
        description: transaction.description,
        isIncome: false,
        accountId: targetAccount.id,
      );

      final transactionsBoxLocal = await transactionsBox;
      await transactionsBoxLocal.put(partialTransaction.id, partialTransaction);

      // Restablecer el saldo de la primera cuenta a cero.
      targetAccount.balance = 0.0;
      final accountsBoxLocal = await accountsBox;
      await accountsBoxLocal.put(targetAccount.id, targetAccount);

      // Distribuir el déficit entre las demás cuentas.
      final remainingAccounts =
          accounts.where((account) => account.id != targetAccount.id).toList();
      await distributeDeficit(deficit, remainingAccounts, transaction);
    }
  }

  // Método para distribuir el déficit entre las cuentas restantes
  Future<void> distributeDeficit(double deficit, List<Account> accounts,
      Transaction originalTransaction) async {
    for (final account in accounts) {
      if (account.balance > 0) {
        if (deficit <= account.balance) {
          // Asignar todo el déficit a esta cuenta.
          final partialTransaction = Transaction(
            id: DateTime.now().toString(),
            amount: deficit,
            date: DateTime.now(),
            category: originalTransaction.category,
            description:
                '${originalTransaction.description} Déficit transferido desde ${originalTransaction.accountId}',
            isIncome: false,
            accountId: account.id,
          );

          // Guardar la transacción en transactionsBox
          final transactionsBoxLocal = await transactionsBox;
          await transactionsBoxLocal.put(
              partialTransaction.id, partialTransaction);

          // Actualizar el saldo de la cuenta
          account.balance -= deficit;
          final accountsBoxLocal = await accountsBox;
          await accountsBoxLocal.put(account.id, account);

          deficit = 0; // Ya no queda déficit.
          break;
        } else {
          // Asignar parte del déficit a esta cuenta.
          final partialTransaction = Transaction(
            id: DateTime.now().toString(),
            amount: account.balance,
            date: DateTime.now(),
            category: originalTransaction.category,
            description:
                '${originalTransaction.description} Déficit transferido desde ${originalTransaction.accountId}',
            isIncome: false,
            accountId: account.id,
          );

          // Guardar la transacción en transactionsBox
          final transactionsBoxLocal = await transactionsBox;
          await transactionsBoxLocal.put(
              partialTransaction.id, partialTransaction);

          // Actualizar el saldo de la cuenta
          deficit -= account.balance;
          account.balance = 0.0;
          final accountsBoxLocal = await accountsBox;
          await accountsBoxLocal.put(account.id, account);
        }
      }
    }

    // Si aún queda déficit después de recorrer todas las cuentas, mostrar un mensaje.
    if (deficit > 0) {
      //print('Advertencia: No se pudo cubrir completamente el gasto. Déficit restante: $deficit');
    }
  }

  // Guardar todos los cambios en las cuentas.
  Future<void> saveAccounts(List<Account> accounts) async {
    final box = await accountsBox;
    for (final account in accounts) {
      await box.put(account.id, account);
    }
  }

  // Método para añadir una cuenta.
  Future<void> addAccount(Account account) async {
    final box = await accountsBox;
    await box.put(account.id, account);
  }

  // Método para obtener todas las cuentas ordenadas por su campo 'order'.
  Future<List<Account>> getAccountsOrdered() async {
    final box = await accountsBox;
    final accounts = box.values.toList();
    accounts.sort((a, b) => a.order.compareTo(b.order)); // Ordenar por 'order'.
    return accounts;
  }

  // Método para actualizar el orden de las cuentas.
  Future<void> updateAccountOrder(List<Account> orderedAccounts) async {
    final box = await accountsBox;
    for (final account in orderedAccounts) {
      await box.put(
          account.id, account); // Guardar cada cuenta con su nuevo orden.
    }
  }

  // Método para obtener transacciones de una cuenta específica.
  Future<List<Transaction>> getTransactions(String accountId) async {
    final box = await transactionsBox;
    return box.values
        .where((transaction) => transaction.accountId == accountId)
        .toList();
  }

  // Métodos para categorías
  Future<void> addCategory(Category category) async {
    final box = await categoriesBox;
    await box.put(
        category.name, category); // Usamos el nombre como clave única.
  }

  Future<List<Category>> getCategories(bool isIncome) async {
    final box = await categoriesBox;
    return box.values
        .where((category) => category.isIncome == isIncome)
        .toList();
  }

  // Método para cargar todas las categorías (sin filtrar por tipo)
  Future<List<Category>> getAllCategories() async {
    final box = await categoriesBox;
    return box.values.toList();
  }

  // Método para obtener todas las transacciones
  Future<List<Transaction>> getAllTransactions() async {
    final box = await transactionsBox;
    return box.values.toList();
  }

  // Método para eliminar todas las transacciones y restablecer los saldos de las cuentas
  Future<void> clearAllTransactions() async {
    final accountsBoxLocal = await accountsBox;
    final transactionsBoxLocal = await transactionsBox;

    // Eliminar todas las transacciones
    await transactionsBoxLocal.clear();

    // Restablecer el saldo de todas las cuentas a 0
    final accounts = accountsBoxLocal.values.toList();
    for (final account in accounts) {
      account.balance = 0.0; // Actualizar el saldo a 0
      await accountsBoxLocal.put(
          account.id, account); // Guardar la cuenta actualizada
    }
  }

  // Método para calcular el gasto acumulado del mes
  Future<double> getMonthlySpent(String accountId) async {
    final box = await transactionsBox; // Esperar la resolución del Future
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    final transactions = box.values.where((transaction) =>
        transaction.accountId == accountId &&
        !transaction.isIncome &&
        transaction.date.isAfter(firstDayOfMonth) &&
        transaction.date.isBefore(lastDayOfMonth));

    return transactions.fold<double>(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );
  }
}
