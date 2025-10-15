
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';

class AddCreditScreen extends ConsumerStatefulWidget {
  final Credito? credit;
  const AddCreditScreen({super.key, this.credit});

  @override
  ConsumerState<AddCreditScreen> createState() => _AddCreditScreenState();
}

class _AddCreditScreenState extends ConsumerState<AddCreditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _totalAmountController;
  late final TextEditingController _paymentAmountController;
  late final TextEditingController _interestRateController;
  late final TextEditingController _paymentDayController;
  late final TextEditingController _plazoEnMesesController;
  late final TextEditingController _comisionAmortizacionParcialController;
  late final TextEditingController _comisionCancelacionTotalController;

  CreditType _selectedCreditType = CreditType.fijo;
  Cuenta? _selectedAccount;
  List<Cuenta> _accounts = [];

  bool get isEditing => widget.credit != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.credit?.name);
    _totalAmountController = TextEditingController(text: widget.credit?.totalAmount.toString());
    _paymentAmountController = TextEditingController(text: widget.credit?.paymentAmount.toString());
    _interestRateController = TextEditingController(text: widget.credit?.interestRate.toString());
    _paymentDayController = TextEditingController(text: widget.credit?.paymentDay.toString());
    _plazoEnMesesController = TextEditingController(text: widget.credit?.plazoEnMeses.toString());
    _comisionAmortizacionParcialController = TextEditingController(text: widget.credit?.comisionAmortizacionParcial?.toString());
    _comisionCancelacionTotalController = TextEditingController(text: widget.credit?.comisionCancelacionTotal?.toString());

    if (isEditing) {
      _selectedCreditType = widget.credit!.creditType;
    }
    _loadAccounts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _totalAmountController.dispose();
    _paymentAmountController.dispose();
    _interestRateController.dispose();
    _paymentDayController.dispose();
    _plazoEnMesesController.dispose();
    _comisionAmortizacionParcialController.dispose();
    _comisionCancelacionTotalController.dispose();
    super.dispose();
  }

  Future<void> _loadAccounts() async {
    final db = ref.read(databaseProvider);
    final accounts = await db.cuentasDao.allCuentas;
    setState(() {
      _accounts = accounts;
      if (isEditing) {
        _selectedAccount = _accounts.firstWhere((a) => a.id == widget.credit!.linkedAccountId);
      } else if (_accounts.isNotEmpty) {
        _selectedAccount = _accounts.first;
      }
    });
  }

  Future<void> _saveCredit() async {
    if (_formKey.currentState!.validate() && _selectedAccount != null) {
      final db = ref.read(databaseProvider);
      final companion = CreditosCompanion(
        id: isEditing ? Value(widget.credit!.id) : const Value.absent(),
        name: Value(_nameController.text),
        totalAmount: Value(double.parse(_totalAmountController.text)),
        remainingAmount: isEditing ? Value(widget.credit!.remainingAmount) : Value(double.parse(_totalAmountController.text)),
        paymentAmount: Value(double.parse(_paymentAmountController.text)),
        interestRate: Value(double.parse(_interestRateController.text)),
        paymentDay: Value(int.parse(_paymentDayController.text)),
        creditType: Value(_selectedCreditType),
        linkedAccountId: Value(_selectedAccount!.id),
        createdAt: isEditing ? Value(widget.credit!.createdAt) : Value(DateTime.now()),
        lastPaymentDate: isEditing ? Value(widget.credit!.lastPaymentDate) : const Value.absent(),
        plazoEnMeses: Value(int.parse(_plazoEnMesesController.text)),
        comisionAmortizacionParcial: _comisionAmortizacionParcialController.text.isNotEmpty ? Value(double.parse(_comisionAmortizacionParcialController.text)) : const Value.absent(),
        comisionCancelacionTotal: _comisionCancelacionTotalController.text.isNotEmpty ? Value(double.parse(_comisionCancelacionTotalController.text)) : const Value.absent(),
      );

      await db.creditosDao.upsertCredito(companion);

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Crédito' : 'Añadir Crédito'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCredit,
          )
        ],
      ),
      body: _accounts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nombre del crédito'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce un nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Cuenta>(
                      initialValue: _selectedAccount,
                      items: _accounts.map((account) {
                        return DropdownMenuItem(
                          value: account,
                          child: Text(account.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAccount = value;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Cuenta de pago'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _totalAmountController,
                      decoration: const InputDecoration(labelText: 'Monto total del crédito'),
                      keyboardType: TextInputType.number,
                      enabled: !isEditing,
                      validator: (value) {
                        if (value == null || double.tryParse(value) == null) {
                          return 'Introduce un monto válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _paymentAmountController,
                      decoration: const InputDecoration(labelText: 'Monto de la cuota'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || double.tryParse(value) == null) {
                          return 'Introduce un monto válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _interestRateController,
                      decoration: const InputDecoration(labelText: 'Tasa de interés (%)'),
                      keyboardType: TextInputType.number,
                       validator: (value) {
                        if (value == null || double.tryParse(value) == null) {
                          return 'Introduce un interés válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                     TextFormField(
                      controller: _paymentDayController,
                      decoration: const InputDecoration(labelText: 'Día del mes para el pago (1-31)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                       validator: (value) {
                        if (value == null || value.isEmpty) return 'Introduce un día';
                        final day = int.tryParse(value);
                        if (day == null || day < 1 || day > 31) {
                          return 'Introduce un día válido (1-31)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _plazoEnMesesController,
                      decoration: const InputDecoration(labelText: 'Plazo en meses'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                       validator: (value) {
                        if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Introduce un plazo válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _comisionAmortizacionParcialController,
                      decoration: const InputDecoration(labelText: 'Comisión Amort. Parcial (%)'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _comisionCancelacionTotalController,
                      decoration: const InputDecoration(labelText: 'Comisión Cancel. Total (%)'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<CreditType>(
                      initialValue: _selectedCreditType,
                      items: CreditType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type == CreditType.fijo ? 'Fijo' : 'Variable'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCreditType = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(labelText: 'Tipo de Crédito'),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _saveCredit,
                      child: Text(isEditing ? 'Guardar Cambios' : 'Guardar Crédito'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
