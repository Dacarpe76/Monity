// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CuentasTable extends Cuentas with TableInfo<$CuentasTable, Cuenta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CuentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _saldoActualMeta =
      const VerificationMeta('saldoActual');
  @override
  late final GeneratedColumn<double> saldoActual = GeneratedColumn<double>(
      'saldo_actual', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _saldoMaximoMensualMeta =
      const VerificationMeta('saldoMaximoMensual');
  @override
  late final GeneratedColumn<double> saldoMaximoMensual =
      GeneratedColumn<double>('saldo_maximo_mensual', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _limiteGastoMensualMeta =
      const VerificationMeta('limiteGastoMensual');
  @override
  late final GeneratedColumn<double> limiteGastoMensual =
      GeneratedColumn<double>('limite_gasto_mensual', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _gastoAcumuladoMesMeta =
      const VerificationMeta('gastoAcumuladoMes');
  @override
  late final GeneratedColumn<double> gastoAcumuladoMes =
      GeneratedColumn<double>('gasto_acumulado_mes', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _ingresoAcumuladoMesMeta =
      const VerificationMeta('ingresoAcumuladoMes');
  @override
  late final GeneratedColumn<double> ingresoAcumuladoMes =
      GeneratedColumn<double>('ingreso_acumulado_mes', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _sobranteMesAnteriorMeta =
      const VerificationMeta('sobranteMesAnterior');
  @override
  late final GeneratedColumn<double> sobranteMesAnterior =
      GeneratedColumn<double>('sobrante_mes_anterior', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
      'orden', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(999));
  static const VerificationMeta _adjustmentPercentageMeta =
      const VerificationMeta('adjustmentPercentage');
  @override
  late final GeneratedColumn<double> adjustmentPercentage =
      GeneratedColumn<double>('adjustment_percentage', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.90));
  static const VerificationMeta _maxBalancePercentageMeta =
      const VerificationMeta('maxBalancePercentage');
  @override
  late final GeneratedColumn<double> maxBalancePercentage =
      GeneratedColumn<double>('max_balance_percentage', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(1.20));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nombre,
        saldoActual,
        saldoMaximoMensual,
        limiteGastoMensual,
        gastoAcumuladoMes,
        ingresoAcumuladoMes,
        sobranteMesAnterior,
        orden,
        adjustmentPercentage,
        maxBalancePercentage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cuentas';
  @override
  VerificationContext validateIntegrity(Insertable<Cuenta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('saldo_actual')) {
      context.handle(
          _saldoActualMeta,
          saldoActual.isAcceptableOrUnknown(
              data['saldo_actual']!, _saldoActualMeta));
    } else if (isInserting) {
      context.missing(_saldoActualMeta);
    }
    if (data.containsKey('saldo_maximo_mensual')) {
      context.handle(
          _saldoMaximoMensualMeta,
          saldoMaximoMensual.isAcceptableOrUnknown(
              data['saldo_maximo_mensual']!, _saldoMaximoMensualMeta));
    } else if (isInserting) {
      context.missing(_saldoMaximoMensualMeta);
    }
    if (data.containsKey('limite_gasto_mensual')) {
      context.handle(
          _limiteGastoMensualMeta,
          limiteGastoMensual.isAcceptableOrUnknown(
              data['limite_gasto_mensual']!, _limiteGastoMensualMeta));
    } else if (isInserting) {
      context.missing(_limiteGastoMensualMeta);
    }
    if (data.containsKey('gasto_acumulado_mes')) {
      context.handle(
          _gastoAcumuladoMesMeta,
          gastoAcumuladoMes.isAcceptableOrUnknown(
              data['gasto_acumulado_mes']!, _gastoAcumuladoMesMeta));
    }
    if (data.containsKey('ingreso_acumulado_mes')) {
      context.handle(
          _ingresoAcumuladoMesMeta,
          ingresoAcumuladoMes.isAcceptableOrUnknown(
              data['ingreso_acumulado_mes']!, _ingresoAcumuladoMesMeta));
    }
    if (data.containsKey('sobrante_mes_anterior')) {
      context.handle(
          _sobranteMesAnteriorMeta,
          sobranteMesAnterior.isAcceptableOrUnknown(
              data['sobrante_mes_anterior']!, _sobranteMesAnteriorMeta));
    }
    if (data.containsKey('orden')) {
      context.handle(
          _ordenMeta, orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta));
    }
    if (data.containsKey('adjustment_percentage')) {
      context.handle(
          _adjustmentPercentageMeta,
          adjustmentPercentage.isAcceptableOrUnknown(
              data['adjustment_percentage']!, _adjustmentPercentageMeta));
    }
    if (data.containsKey('max_balance_percentage')) {
      context.handle(
          _maxBalancePercentageMeta,
          maxBalancePercentage.isAcceptableOrUnknown(
              data['max_balance_percentage']!, _maxBalancePercentageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cuenta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cuenta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      saldoActual: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}saldo_actual'])!,
      saldoMaximoMensual: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}saldo_maximo_mensual'])!,
      limiteGastoMensual: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}limite_gasto_mensual'])!,
      gastoAcumuladoMes: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}gasto_acumulado_mes'])!,
      ingresoAcumuladoMes: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}ingreso_acumulado_mes'])!,
      sobranteMesAnterior: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}sobrante_mes_anterior'])!,
      orden: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden'])!,
      adjustmentPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}adjustment_percentage'])!,
      maxBalancePercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}max_balance_percentage'])!,
    );
  }

  @override
  $CuentasTable createAlias(String alias) {
    return $CuentasTable(attachedDatabase, alias);
  }
}

class Cuenta extends DataClass implements Insertable<Cuenta> {
  final int id;
  final String nombre;
  final double saldoActual;
  final double saldoMaximoMensual;
  final double limiteGastoMensual;
  final double gastoAcumuladoMes;
  final double ingresoAcumuladoMes;
  final double sobranteMesAnterior;
  final int orden;
  final double adjustmentPercentage;
  final double maxBalancePercentage;
  const Cuenta(
      {required this.id,
      required this.nombre,
      required this.saldoActual,
      required this.saldoMaximoMensual,
      required this.limiteGastoMensual,
      required this.gastoAcumuladoMes,
      required this.ingresoAcumuladoMes,
      required this.sobranteMesAnterior,
      required this.orden,
      required this.adjustmentPercentage,
      required this.maxBalancePercentage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['saldo_actual'] = Variable<double>(saldoActual);
    map['saldo_maximo_mensual'] = Variable<double>(saldoMaximoMensual);
    map['limite_gasto_mensual'] = Variable<double>(limiteGastoMensual);
    map['gasto_acumulado_mes'] = Variable<double>(gastoAcumuladoMes);
    map['ingreso_acumulado_mes'] = Variable<double>(ingresoAcumuladoMes);
    map['sobrante_mes_anterior'] = Variable<double>(sobranteMesAnterior);
    map['orden'] = Variable<int>(orden);
    map['adjustment_percentage'] = Variable<double>(adjustmentPercentage);
    map['max_balance_percentage'] = Variable<double>(maxBalancePercentage);
    return map;
  }

  CuentasCompanion toCompanion(bool nullToAbsent) {
    return CuentasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      saldoActual: Value(saldoActual),
      saldoMaximoMensual: Value(saldoMaximoMensual),
      limiteGastoMensual: Value(limiteGastoMensual),
      gastoAcumuladoMes: Value(gastoAcumuladoMes),
      ingresoAcumuladoMes: Value(ingresoAcumuladoMes),
      sobranteMesAnterior: Value(sobranteMesAnterior),
      orden: Value(orden),
      adjustmentPercentage: Value(adjustmentPercentage),
      maxBalancePercentage: Value(maxBalancePercentage),
    );
  }

  factory Cuenta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cuenta(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      saldoActual: serializer.fromJson<double>(json['saldoActual']),
      saldoMaximoMensual:
          serializer.fromJson<double>(json['saldoMaximoMensual']),
      limiteGastoMensual:
          serializer.fromJson<double>(json['limiteGastoMensual']),
      gastoAcumuladoMes: serializer.fromJson<double>(json['gastoAcumuladoMes']),
      ingresoAcumuladoMes:
          serializer.fromJson<double>(json['ingresoAcumuladoMes']),
      sobranteMesAnterior:
          serializer.fromJson<double>(json['sobranteMesAnterior']),
      orden: serializer.fromJson<int>(json['orden']),
      adjustmentPercentage:
          serializer.fromJson<double>(json['adjustmentPercentage']),
      maxBalancePercentage:
          serializer.fromJson<double>(json['maxBalancePercentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'saldoActual': serializer.toJson<double>(saldoActual),
      'saldoMaximoMensual': serializer.toJson<double>(saldoMaximoMensual),
      'limiteGastoMensual': serializer.toJson<double>(limiteGastoMensual),
      'gastoAcumuladoMes': serializer.toJson<double>(gastoAcumuladoMes),
      'ingresoAcumuladoMes': serializer.toJson<double>(ingresoAcumuladoMes),
      'sobranteMesAnterior': serializer.toJson<double>(sobranteMesAnterior),
      'orden': serializer.toJson<int>(orden),
      'adjustmentPercentage': serializer.toJson<double>(adjustmentPercentage),
      'maxBalancePercentage': serializer.toJson<double>(maxBalancePercentage),
    };
  }

  Cuenta copyWith(
          {int? id,
          String? nombre,
          double? saldoActual,
          double? saldoMaximoMensual,
          double? limiteGastoMensual,
          double? gastoAcumuladoMes,
          double? ingresoAcumuladoMes,
          double? sobranteMesAnterior,
          int? orden,
          double? adjustmentPercentage,
          double? maxBalancePercentage}) =>
      Cuenta(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        saldoActual: saldoActual ?? this.saldoActual,
        saldoMaximoMensual: saldoMaximoMensual ?? this.saldoMaximoMensual,
        limiteGastoMensual: limiteGastoMensual ?? this.limiteGastoMensual,
        gastoAcumuladoMes: gastoAcumuladoMes ?? this.gastoAcumuladoMes,
        ingresoAcumuladoMes: ingresoAcumuladoMes ?? this.ingresoAcumuladoMes,
        sobranteMesAnterior: sobranteMesAnterior ?? this.sobranteMesAnterior,
        orden: orden ?? this.orden,
        adjustmentPercentage: adjustmentPercentage ?? this.adjustmentPercentage,
        maxBalancePercentage: maxBalancePercentage ?? this.maxBalancePercentage,
      );
  Cuenta copyWithCompanion(CuentasCompanion data) {
    return Cuenta(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      saldoActual:
          data.saldoActual.present ? data.saldoActual.value : this.saldoActual,
      saldoMaximoMensual: data.saldoMaximoMensual.present
          ? data.saldoMaximoMensual.value
          : this.saldoMaximoMensual,
      limiteGastoMensual: data.limiteGastoMensual.present
          ? data.limiteGastoMensual.value
          : this.limiteGastoMensual,
      gastoAcumuladoMes: data.gastoAcumuladoMes.present
          ? data.gastoAcumuladoMes.value
          : this.gastoAcumuladoMes,
      ingresoAcumuladoMes: data.ingresoAcumuladoMes.present
          ? data.ingresoAcumuladoMes.value
          : this.ingresoAcumuladoMes,
      sobranteMesAnterior: data.sobranteMesAnterior.present
          ? data.sobranteMesAnterior.value
          : this.sobranteMesAnterior,
      orden: data.orden.present ? data.orden.value : this.orden,
      adjustmentPercentage: data.adjustmentPercentage.present
          ? data.adjustmentPercentage.value
          : this.adjustmentPercentage,
      maxBalancePercentage: data.maxBalancePercentage.present
          ? data.maxBalancePercentage.value
          : this.maxBalancePercentage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cuenta(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('saldoActual: $saldoActual, ')
          ..write('saldoMaximoMensual: $saldoMaximoMensual, ')
          ..write('limiteGastoMensual: $limiteGastoMensual, ')
          ..write('gastoAcumuladoMes: $gastoAcumuladoMes, ')
          ..write('ingresoAcumuladoMes: $ingresoAcumuladoMes, ')
          ..write('sobranteMesAnterior: $sobranteMesAnterior, ')
          ..write('orden: $orden, ')
          ..write('adjustmentPercentage: $adjustmentPercentage, ')
          ..write('maxBalancePercentage: $maxBalancePercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nombre,
      saldoActual,
      saldoMaximoMensual,
      limiteGastoMensual,
      gastoAcumuladoMes,
      ingresoAcumuladoMes,
      sobranteMesAnterior,
      orden,
      adjustmentPercentage,
      maxBalancePercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cuenta &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.saldoActual == this.saldoActual &&
          other.saldoMaximoMensual == this.saldoMaximoMensual &&
          other.limiteGastoMensual == this.limiteGastoMensual &&
          other.gastoAcumuladoMes == this.gastoAcumuladoMes &&
          other.ingresoAcumuladoMes == this.ingresoAcumuladoMes &&
          other.sobranteMesAnterior == this.sobranteMesAnterior &&
          other.orden == this.orden &&
          other.adjustmentPercentage == this.adjustmentPercentage &&
          other.maxBalancePercentage == this.maxBalancePercentage);
}

class CuentasCompanion extends UpdateCompanion<Cuenta> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<double> saldoActual;
  final Value<double> saldoMaximoMensual;
  final Value<double> limiteGastoMensual;
  final Value<double> gastoAcumuladoMes;
  final Value<double> ingresoAcumuladoMes;
  final Value<double> sobranteMesAnterior;
  final Value<int> orden;
  final Value<double> adjustmentPercentage;
  final Value<double> maxBalancePercentage;
  const CuentasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.saldoActual = const Value.absent(),
    this.saldoMaximoMensual = const Value.absent(),
    this.limiteGastoMensual = const Value.absent(),
    this.gastoAcumuladoMes = const Value.absent(),
    this.ingresoAcumuladoMes = const Value.absent(),
    this.sobranteMesAnterior = const Value.absent(),
    this.orden = const Value.absent(),
    this.adjustmentPercentage = const Value.absent(),
    this.maxBalancePercentage = const Value.absent(),
  });
  CuentasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required double saldoActual,
    required double saldoMaximoMensual,
    required double limiteGastoMensual,
    this.gastoAcumuladoMes = const Value.absent(),
    this.ingresoAcumuladoMes = const Value.absent(),
    this.sobranteMesAnterior = const Value.absent(),
    this.orden = const Value.absent(),
    this.adjustmentPercentage = const Value.absent(),
    this.maxBalancePercentage = const Value.absent(),
  })  : nombre = Value(nombre),
        saldoActual = Value(saldoActual),
        saldoMaximoMensual = Value(saldoMaximoMensual),
        limiteGastoMensual = Value(limiteGastoMensual);
  static Insertable<Cuenta> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<double>? saldoActual,
    Expression<double>? saldoMaximoMensual,
    Expression<double>? limiteGastoMensual,
    Expression<double>? gastoAcumuladoMes,
    Expression<double>? ingresoAcumuladoMes,
    Expression<double>? sobranteMesAnterior,
    Expression<int>? orden,
    Expression<double>? adjustmentPercentage,
    Expression<double>? maxBalancePercentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (saldoActual != null) 'saldo_actual': saldoActual,
      if (saldoMaximoMensual != null)
        'saldo_maximo_mensual': saldoMaximoMensual,
      if (limiteGastoMensual != null)
        'limite_gasto_mensual': limiteGastoMensual,
      if (gastoAcumuladoMes != null) 'gasto_acumulado_mes': gastoAcumuladoMes,
      if (ingresoAcumuladoMes != null)
        'ingreso_acumulado_mes': ingresoAcumuladoMes,
      if (sobranteMesAnterior != null)
        'sobrante_mes_anterior': sobranteMesAnterior,
      if (orden != null) 'orden': orden,
      if (adjustmentPercentage != null)
        'adjustment_percentage': adjustmentPercentage,
      if (maxBalancePercentage != null)
        'max_balance_percentage': maxBalancePercentage,
    });
  }

  CuentasCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<double>? saldoActual,
      Value<double>? saldoMaximoMensual,
      Value<double>? limiteGastoMensual,
      Value<double>? gastoAcumuladoMes,
      Value<double>? ingresoAcumuladoMes,
      Value<double>? sobranteMesAnterior,
      Value<int>? orden,
      Value<double>? adjustmentPercentage,
      Value<double>? maxBalancePercentage}) {
    return CuentasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      saldoActual: saldoActual ?? this.saldoActual,
      saldoMaximoMensual: saldoMaximoMensual ?? this.saldoMaximoMensual,
      limiteGastoMensual: limiteGastoMensual ?? this.limiteGastoMensual,
      gastoAcumuladoMes: gastoAcumuladoMes ?? this.gastoAcumuladoMes,
      ingresoAcumuladoMes: ingresoAcumuladoMes ?? this.ingresoAcumuladoMes,
      sobranteMesAnterior: sobranteMesAnterior ?? this.sobranteMesAnterior,
      orden: orden ?? this.orden,
      adjustmentPercentage: adjustmentPercentage ?? this.adjustmentPercentage,
      maxBalancePercentage: maxBalancePercentage ?? this.maxBalancePercentage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (saldoActual.present) {
      map['saldo_actual'] = Variable<double>(saldoActual.value);
    }
    if (saldoMaximoMensual.present) {
      map['saldo_maximo_mensual'] = Variable<double>(saldoMaximoMensual.value);
    }
    if (limiteGastoMensual.present) {
      map['limite_gasto_mensual'] = Variable<double>(limiteGastoMensual.value);
    }
    if (gastoAcumuladoMes.present) {
      map['gasto_acumulado_mes'] = Variable<double>(gastoAcumuladoMes.value);
    }
    if (ingresoAcumuladoMes.present) {
      map['ingreso_acumulado_mes'] =
          Variable<double>(ingresoAcumuladoMes.value);
    }
    if (sobranteMesAnterior.present) {
      map['sobrante_mes_anterior'] =
          Variable<double>(sobranteMesAnterior.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (adjustmentPercentage.present) {
      map['adjustment_percentage'] =
          Variable<double>(adjustmentPercentage.value);
    }
    if (maxBalancePercentage.present) {
      map['max_balance_percentage'] =
          Variable<double>(maxBalancePercentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CuentasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('saldoActual: $saldoActual, ')
          ..write('saldoMaximoMensual: $saldoMaximoMensual, ')
          ..write('limiteGastoMensual: $limiteGastoMensual, ')
          ..write('gastoAcumuladoMes: $gastoAcumuladoMes, ')
          ..write('ingresoAcumuladoMes: $ingresoAcumuladoMes, ')
          ..write('sobranteMesAnterior: $sobranteMesAnterior, ')
          ..write('orden: $orden, ')
          ..write('adjustmentPercentage: $adjustmentPercentage, ')
          ..write('maxBalancePercentage: $maxBalancePercentage')
          ..write(')'))
        .toString();
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TipoCategoria, int> tipo =
      GeneratedColumn<int>('tipo', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TipoCategoria>($CategoriasTable.$convertertipo);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconoMeta = const VerificationMeta('icono');
  @override
  late final GeneratedColumn<String> icono = GeneratedColumn<String>(
      'icono', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, nombre, tipo, color, icono];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(Insertable<Categoria> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icono')) {
      context.handle(
          _iconoMeta, icono.isAcceptableOrUnknown(data['icono']!, _iconoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      tipo: $CategoriasTable.$convertertipo.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tipo'])!),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      icono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icono'])!,
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoCategoria, int, int> $convertertipo =
      const EnumIndexConverter<TipoCategoria>(TipoCategoria.values);
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String nombre;
  final TipoCategoria tipo;
  final String color;
  final String icono;
  const Categoria(
      {required this.id,
      required this.nombre,
      required this.tipo,
      required this.color,
      required this.icono});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    {
      map['tipo'] = Variable<int>($CategoriasTable.$convertertipo.toSql(tipo));
    }
    map['color'] = Variable<String>(color);
    map['icono'] = Variable<String>(icono);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      tipo: Value(tipo),
      color: Value(color),
      icono: Value(icono),
    );
  }

  factory Categoria.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      tipo: $CategoriasTable.$convertertipo
          .fromJson(serializer.fromJson<int>(json['tipo'])),
      color: serializer.fromJson<String>(json['color']),
      icono: serializer.fromJson<String>(json['icono']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'tipo':
          serializer.toJson<int>($CategoriasTable.$convertertipo.toJson(tipo)),
      'color': serializer.toJson<String>(color),
      'icono': serializer.toJson<String>(icono),
    };
  }

  Categoria copyWith(
          {int? id,
          String? nombre,
          TipoCategoria? tipo,
          String? color,
          String? icono}) =>
      Categoria(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        tipo: tipo ?? this.tipo,
        color: color ?? this.color,
        icono: icono ?? this.icono,
      );
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      color: data.color.present ? data.color.value : this.color,
      icono: data.icono.present ? data.icono.value : this.icono,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('color: $color, ')
          ..write('icono: $icono')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, tipo, color, icono);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.tipo == this.tipo &&
          other.color == this.color &&
          other.icono == this.icono);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<TipoCategoria> tipo;
  final Value<String> color;
  final Value<String> icono;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.tipo = const Value.absent(),
    this.color = const Value.absent(),
    this.icono = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required TipoCategoria tipo,
    required String color,
    this.icono = const Value.absent(),
  })  : nombre = Value(nombre),
        tipo = Value(tipo),
        color = Value(color);
  static Insertable<Categoria> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? tipo,
    Expression<String>? color,
    Expression<String>? icono,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (tipo != null) 'tipo': tipo,
      if (color != null) 'color': color,
      if (icono != null) 'icono': icono,
    });
  }

  CategoriasCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<TipoCategoria>? tipo,
      Value<String>? color,
      Value<String>? icono}) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      color: color ?? this.color,
      icono: icono ?? this.icono,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (tipo.present) {
      map['tipo'] =
          Variable<int>($CategoriasTable.$convertertipo.toSql(tipo.value));
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icono.present) {
      map['icono'] = Variable<String>(icono.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('color: $color, ')
          ..write('icono: $icono')
          ..write(')'))
        .toString();
  }
}

class $IngresosTable extends Ingresos with TableInfo<$IngresosTable, Ingreso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngresosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cantidadTotalMeta =
      const VerificationMeta('cantidadTotal');
  @override
  late final GeneratedColumn<double> cantidadTotal = GeneratedColumn<double>(
      'cantidad_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _idCategoriaMeta =
      const VerificationMeta('idCategoria');
  @override
  late final GeneratedColumn<int> idCategoria = GeneratedColumn<int>(
      'id_categoria', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categorias (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, cantidadTotal, fecha, idCategoria];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingresos';
  @override
  VerificationContext validateIntegrity(Insertable<Ingreso> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cantidad_total')) {
      context.handle(
          _cantidadTotalMeta,
          cantidadTotal.isAcceptableOrUnknown(
              data['cantidad_total']!, _cantidadTotalMeta));
    } else if (isInserting) {
      context.missing(_cantidadTotalMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('id_categoria')) {
      context.handle(
          _idCategoriaMeta,
          idCategoria.isAcceptableOrUnknown(
              data['id_categoria']!, _idCategoriaMeta));
    } else if (isInserting) {
      context.missing(_idCategoriaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingreso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingreso(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cantidadTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cantidad_total'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      idCategoria: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_categoria'])!,
    );
  }

  @override
  $IngresosTable createAlias(String alias) {
    return $IngresosTable(attachedDatabase, alias);
  }
}

class Ingreso extends DataClass implements Insertable<Ingreso> {
  final int id;
  final double cantidadTotal;
  final DateTime fecha;
  final int idCategoria;
  const Ingreso(
      {required this.id,
      required this.cantidadTotal,
      required this.fecha,
      required this.idCategoria});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cantidad_total'] = Variable<double>(cantidadTotal);
    map['fecha'] = Variable<DateTime>(fecha);
    map['id_categoria'] = Variable<int>(idCategoria);
    return map;
  }

  IngresosCompanion toCompanion(bool nullToAbsent) {
    return IngresosCompanion(
      id: Value(id),
      cantidadTotal: Value(cantidadTotal),
      fecha: Value(fecha),
      idCategoria: Value(idCategoria),
    );
  }

  factory Ingreso.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingreso(
      id: serializer.fromJson<int>(json['id']),
      cantidadTotal: serializer.fromJson<double>(json['cantidadTotal']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      idCategoria: serializer.fromJson<int>(json['idCategoria']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cantidadTotal': serializer.toJson<double>(cantidadTotal),
      'fecha': serializer.toJson<DateTime>(fecha),
      'idCategoria': serializer.toJson<int>(idCategoria),
    };
  }

  Ingreso copyWith(
          {int? id,
          double? cantidadTotal,
          DateTime? fecha,
          int? idCategoria}) =>
      Ingreso(
        id: id ?? this.id,
        cantidadTotal: cantidadTotal ?? this.cantidadTotal,
        fecha: fecha ?? this.fecha,
        idCategoria: idCategoria ?? this.idCategoria,
      );
  Ingreso copyWithCompanion(IngresosCompanion data) {
    return Ingreso(
      id: data.id.present ? data.id.value : this.id,
      cantidadTotal: data.cantidadTotal.present
          ? data.cantidadTotal.value
          : this.cantidadTotal,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      idCategoria:
          data.idCategoria.present ? data.idCategoria.value : this.idCategoria,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingreso(')
          ..write('id: $id, ')
          ..write('cantidadTotal: $cantidadTotal, ')
          ..write('fecha: $fecha, ')
          ..write('idCategoria: $idCategoria')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cantidadTotal, fecha, idCategoria);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingreso &&
          other.id == this.id &&
          other.cantidadTotal == this.cantidadTotal &&
          other.fecha == this.fecha &&
          other.idCategoria == this.idCategoria);
}

class IngresosCompanion extends UpdateCompanion<Ingreso> {
  final Value<int> id;
  final Value<double> cantidadTotal;
  final Value<DateTime> fecha;
  final Value<int> idCategoria;
  const IngresosCompanion({
    this.id = const Value.absent(),
    this.cantidadTotal = const Value.absent(),
    this.fecha = const Value.absent(),
    this.idCategoria = const Value.absent(),
  });
  IngresosCompanion.insert({
    this.id = const Value.absent(),
    required double cantidadTotal,
    required DateTime fecha,
    required int idCategoria,
  })  : cantidadTotal = Value(cantidadTotal),
        fecha = Value(fecha),
        idCategoria = Value(idCategoria);
  static Insertable<Ingreso> custom({
    Expression<int>? id,
    Expression<double>? cantidadTotal,
    Expression<DateTime>? fecha,
    Expression<int>? idCategoria,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cantidadTotal != null) 'cantidad_total': cantidadTotal,
      if (fecha != null) 'fecha': fecha,
      if (idCategoria != null) 'id_categoria': idCategoria,
    });
  }

  IngresosCompanion copyWith(
      {Value<int>? id,
      Value<double>? cantidadTotal,
      Value<DateTime>? fecha,
      Value<int>? idCategoria}) {
    return IngresosCompanion(
      id: id ?? this.id,
      cantidadTotal: cantidadTotal ?? this.cantidadTotal,
      fecha: fecha ?? this.fecha,
      idCategoria: idCategoria ?? this.idCategoria,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cantidadTotal.present) {
      map['cantidad_total'] = Variable<double>(cantidadTotal.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (idCategoria.present) {
      map['id_categoria'] = Variable<int>(idCategoria.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngresosCompanion(')
          ..write('id: $id, ')
          ..write('cantidadTotal: $cantidadTotal, ')
          ..write('fecha: $fecha, ')
          ..write('idCategoria: $idCategoria')
          ..write(')'))
        .toString();
  }
}

class $GastosTable extends Gastos with TableInfo<$GastosTable, Gasto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _conceptoMeta =
      const VerificationMeta('concepto');
  @override
  late final GeneratedColumn<String> concepto = GeneratedColumn<String>(
      'concepto', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _idCategoriaMeta =
      const VerificationMeta('idCategoria');
  @override
  late final GeneratedColumn<int> idCategoria = GeneratedColumn<int>(
      'id_categoria', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categorias (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, cantidad, concepto, fecha, idCategoria];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos';
  @override
  VerificationContext validateIntegrity(Insertable<Gasto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('concepto')) {
      context.handle(_conceptoMeta,
          concepto.isAcceptableOrUnknown(data['concepto']!, _conceptoMeta));
    } else if (isInserting) {
      context.missing(_conceptoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('id_categoria')) {
      context.handle(
          _idCategoriaMeta,
          idCategoria.isAcceptableOrUnknown(
              data['id_categoria']!, _idCategoriaMeta));
    } else if (isInserting) {
      context.missing(_idCategoriaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gasto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gasto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cantidad'])!,
      concepto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}concepto'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      idCategoria: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_categoria'])!,
    );
  }

  @override
  $GastosTable createAlias(String alias) {
    return $GastosTable(attachedDatabase, alias);
  }
}

class Gasto extends DataClass implements Insertable<Gasto> {
  final int id;
  final double cantidad;
  final String concepto;
  final DateTime fecha;
  final int idCategoria;
  const Gasto(
      {required this.id,
      required this.cantidad,
      required this.concepto,
      required this.fecha,
      required this.idCategoria});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cantidad'] = Variable<double>(cantidad);
    map['concepto'] = Variable<String>(concepto);
    map['fecha'] = Variable<DateTime>(fecha);
    map['id_categoria'] = Variable<int>(idCategoria);
    return map;
  }

  GastosCompanion toCompanion(bool nullToAbsent) {
    return GastosCompanion(
      id: Value(id),
      cantidad: Value(cantidad),
      concepto: Value(concepto),
      fecha: Value(fecha),
      idCategoria: Value(idCategoria),
    );
  }

  factory Gasto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gasto(
      id: serializer.fromJson<int>(json['id']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      concepto: serializer.fromJson<String>(json['concepto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      idCategoria: serializer.fromJson<int>(json['idCategoria']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cantidad': serializer.toJson<double>(cantidad),
      'concepto': serializer.toJson<String>(concepto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'idCategoria': serializer.toJson<int>(idCategoria),
    };
  }

  Gasto copyWith(
          {int? id,
          double? cantidad,
          String? concepto,
          DateTime? fecha,
          int? idCategoria}) =>
      Gasto(
        id: id ?? this.id,
        cantidad: cantidad ?? this.cantidad,
        concepto: concepto ?? this.concepto,
        fecha: fecha ?? this.fecha,
        idCategoria: idCategoria ?? this.idCategoria,
      );
  Gasto copyWithCompanion(GastosCompanion data) {
    return Gasto(
      id: data.id.present ? data.id.value : this.id,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      concepto: data.concepto.present ? data.concepto.value : this.concepto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      idCategoria:
          data.idCategoria.present ? data.idCategoria.value : this.idCategoria,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gasto(')
          ..write('id: $id, ')
          ..write('cantidad: $cantidad, ')
          ..write('concepto: $concepto, ')
          ..write('fecha: $fecha, ')
          ..write('idCategoria: $idCategoria')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cantidad, concepto, fecha, idCategoria);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gasto &&
          other.id == this.id &&
          other.cantidad == this.cantidad &&
          other.concepto == this.concepto &&
          other.fecha == this.fecha &&
          other.idCategoria == this.idCategoria);
}

class GastosCompanion extends UpdateCompanion<Gasto> {
  final Value<int> id;
  final Value<double> cantidad;
  final Value<String> concepto;
  final Value<DateTime> fecha;
  final Value<int> idCategoria;
  const GastosCompanion({
    this.id = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.concepto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.idCategoria = const Value.absent(),
  });
  GastosCompanion.insert({
    this.id = const Value.absent(),
    required double cantidad,
    required String concepto,
    required DateTime fecha,
    required int idCategoria,
  })  : cantidad = Value(cantidad),
        concepto = Value(concepto),
        fecha = Value(fecha),
        idCategoria = Value(idCategoria);
  static Insertable<Gasto> custom({
    Expression<int>? id,
    Expression<double>? cantidad,
    Expression<String>? concepto,
    Expression<DateTime>? fecha,
    Expression<int>? idCategoria,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cantidad != null) 'cantidad': cantidad,
      if (concepto != null) 'concepto': concepto,
      if (fecha != null) 'fecha': fecha,
      if (idCategoria != null) 'id_categoria': idCategoria,
    });
  }

  GastosCompanion copyWith(
      {Value<int>? id,
      Value<double>? cantidad,
      Value<String>? concepto,
      Value<DateTime>? fecha,
      Value<int>? idCategoria}) {
    return GastosCompanion(
      id: id ?? this.id,
      cantidad: cantidad ?? this.cantidad,
      concepto: concepto ?? this.concepto,
      fecha: fecha ?? this.fecha,
      idCategoria: idCategoria ?? this.idCategoria,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (concepto.present) {
      map['concepto'] = Variable<String>(concepto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (idCategoria.present) {
      map['id_categoria'] = Variable<int>(idCategoria.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosCompanion(')
          ..write('id: $id, ')
          ..write('cantidad: $cantidad, ')
          ..write('concepto: $concepto, ')
          ..write('fecha: $fecha, ')
          ..write('idCategoria: $idCategoria')
          ..write(')'))
        .toString();
  }
}

class $TransaccionesTable extends Transacciones
    with TableInfo<$TransaccionesTable, Transaccion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransaccionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idCuentaMeta =
      const VerificationMeta('idCuenta');
  @override
  late final GeneratedColumn<int> idCuenta = GeneratedColumn<int>(
      'id_cuenta', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cuentas (id)'));
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TipoTransaccion, int> tipo =
      GeneratedColumn<int>('tipo', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TipoTransaccion>($TransaccionesTable.$convertertipo);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _idGastoMeta =
      const VerificationMeta('idGasto');
  @override
  late final GeneratedColumn<int> idGasto = GeneratedColumn<int>(
      'id_gasto', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES gastos (id)'));
  static const VerificationMeta _idIngresoMeta =
      const VerificationMeta('idIngreso');
  @override
  late final GeneratedColumn<int> idIngreso = GeneratedColumn<int>(
      'id_ingreso', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ingresos (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, idCuenta, cantidad, tipo, fecha, idGasto, idIngreso];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transacciones';
  @override
  VerificationContext validateIntegrity(Insertable<Transaccion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_cuenta')) {
      context.handle(_idCuentaMeta,
          idCuenta.isAcceptableOrUnknown(data['id_cuenta']!, _idCuentaMeta));
    } else if (isInserting) {
      context.missing(_idCuentaMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('id_gasto')) {
      context.handle(_idGastoMeta,
          idGasto.isAcceptableOrUnknown(data['id_gasto']!, _idGastoMeta));
    }
    if (data.containsKey('id_ingreso')) {
      context.handle(_idIngresoMeta,
          idIngreso.isAcceptableOrUnknown(data['id_ingreso']!, _idIngresoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaccion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaccion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idCuenta: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_cuenta'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cantidad'])!,
      tipo: $TransaccionesTable.$convertertipo.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tipo'])!),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      idGasto: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_gasto']),
      idIngreso: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_ingreso']),
    );
  }

  @override
  $TransaccionesTable createAlias(String alias) {
    return $TransaccionesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoTransaccion, int, int> $convertertipo =
      const EnumIndexConverter<TipoTransaccion>(TipoTransaccion.values);
}

class Transaccion extends DataClass implements Insertable<Transaccion> {
  final int id;
  final int idCuenta;
  final double cantidad;
  final TipoTransaccion tipo;
  final DateTime fecha;
  final int? idGasto;
  final int? idIngreso;
  const Transaccion(
      {required this.id,
      required this.idCuenta,
      required this.cantidad,
      required this.tipo,
      required this.fecha,
      this.idGasto,
      this.idIngreso});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_cuenta'] = Variable<int>(idCuenta);
    map['cantidad'] = Variable<double>(cantidad);
    {
      map['tipo'] =
          Variable<int>($TransaccionesTable.$convertertipo.toSql(tipo));
    }
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || idGasto != null) {
      map['id_gasto'] = Variable<int>(idGasto);
    }
    if (!nullToAbsent || idIngreso != null) {
      map['id_ingreso'] = Variable<int>(idIngreso);
    }
    return map;
  }

  TransaccionesCompanion toCompanion(bool nullToAbsent) {
    return TransaccionesCompanion(
      id: Value(id),
      idCuenta: Value(idCuenta),
      cantidad: Value(cantidad),
      tipo: Value(tipo),
      fecha: Value(fecha),
      idGasto: idGasto == null && nullToAbsent
          ? const Value.absent()
          : Value(idGasto),
      idIngreso: idIngreso == null && nullToAbsent
          ? const Value.absent()
          : Value(idIngreso),
    );
  }

  factory Transaccion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaccion(
      id: serializer.fromJson<int>(json['id']),
      idCuenta: serializer.fromJson<int>(json['idCuenta']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      tipo: $TransaccionesTable.$convertertipo
          .fromJson(serializer.fromJson<int>(json['tipo'])),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      idGasto: serializer.fromJson<int?>(json['idGasto']),
      idIngreso: serializer.fromJson<int?>(json['idIngreso']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idCuenta': serializer.toJson<int>(idCuenta),
      'cantidad': serializer.toJson<double>(cantidad),
      'tipo': serializer
          .toJson<int>($TransaccionesTable.$convertertipo.toJson(tipo)),
      'fecha': serializer.toJson<DateTime>(fecha),
      'idGasto': serializer.toJson<int?>(idGasto),
      'idIngreso': serializer.toJson<int?>(idIngreso),
    };
  }

  Transaccion copyWith(
          {int? id,
          int? idCuenta,
          double? cantidad,
          TipoTransaccion? tipo,
          DateTime? fecha,
          Value<int?> idGasto = const Value.absent(),
          Value<int?> idIngreso = const Value.absent()}) =>
      Transaccion(
        id: id ?? this.id,
        idCuenta: idCuenta ?? this.idCuenta,
        cantidad: cantidad ?? this.cantidad,
        tipo: tipo ?? this.tipo,
        fecha: fecha ?? this.fecha,
        idGasto: idGasto.present ? idGasto.value : this.idGasto,
        idIngreso: idIngreso.present ? idIngreso.value : this.idIngreso,
      );
  Transaccion copyWithCompanion(TransaccionesCompanion data) {
    return Transaccion(
      id: data.id.present ? data.id.value : this.id,
      idCuenta: data.idCuenta.present ? data.idCuenta.value : this.idCuenta,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      idGasto: data.idGasto.present ? data.idGasto.value : this.idGasto,
      idIngreso: data.idIngreso.present ? data.idIngreso.value : this.idIngreso,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaccion(')
          ..write('id: $id, ')
          ..write('idCuenta: $idCuenta, ')
          ..write('cantidad: $cantidad, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('idGasto: $idGasto, ')
          ..write('idIngreso: $idIngreso')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, idCuenta, cantidad, tipo, fecha, idGasto, idIngreso);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaccion &&
          other.id == this.id &&
          other.idCuenta == this.idCuenta &&
          other.cantidad == this.cantidad &&
          other.tipo == this.tipo &&
          other.fecha == this.fecha &&
          other.idGasto == this.idGasto &&
          other.idIngreso == this.idIngreso);
}

class TransaccionesCompanion extends UpdateCompanion<Transaccion> {
  final Value<int> id;
  final Value<int> idCuenta;
  final Value<double> cantidad;
  final Value<TipoTransaccion> tipo;
  final Value<DateTime> fecha;
  final Value<int?> idGasto;
  final Value<int?> idIngreso;
  const TransaccionesCompanion({
    this.id = const Value.absent(),
    this.idCuenta = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.tipo = const Value.absent(),
    this.fecha = const Value.absent(),
    this.idGasto = const Value.absent(),
    this.idIngreso = const Value.absent(),
  });
  TransaccionesCompanion.insert({
    this.id = const Value.absent(),
    required int idCuenta,
    required double cantidad,
    required TipoTransaccion tipo,
    required DateTime fecha,
    this.idGasto = const Value.absent(),
    this.idIngreso = const Value.absent(),
  })  : idCuenta = Value(idCuenta),
        cantidad = Value(cantidad),
        tipo = Value(tipo),
        fecha = Value(fecha);
  static Insertable<Transaccion> custom({
    Expression<int>? id,
    Expression<int>? idCuenta,
    Expression<double>? cantidad,
    Expression<int>? tipo,
    Expression<DateTime>? fecha,
    Expression<int>? idGasto,
    Expression<int>? idIngreso,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idCuenta != null) 'id_cuenta': idCuenta,
      if (cantidad != null) 'cantidad': cantidad,
      if (tipo != null) 'tipo': tipo,
      if (fecha != null) 'fecha': fecha,
      if (idGasto != null) 'id_gasto': idGasto,
      if (idIngreso != null) 'id_ingreso': idIngreso,
    });
  }

  TransaccionesCompanion copyWith(
      {Value<int>? id,
      Value<int>? idCuenta,
      Value<double>? cantidad,
      Value<TipoTransaccion>? tipo,
      Value<DateTime>? fecha,
      Value<int?>? idGasto,
      Value<int?>? idIngreso}) {
    return TransaccionesCompanion(
      id: id ?? this.id,
      idCuenta: idCuenta ?? this.idCuenta,
      cantidad: cantidad ?? this.cantidad,
      tipo: tipo ?? this.tipo,
      fecha: fecha ?? this.fecha,
      idGasto: idGasto ?? this.idGasto,
      idIngreso: idIngreso ?? this.idIngreso,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idCuenta.present) {
      map['id_cuenta'] = Variable<int>(idCuenta.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (tipo.present) {
      map['tipo'] =
          Variable<int>($TransaccionesTable.$convertertipo.toSql(tipo.value));
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (idGasto.present) {
      map['id_gasto'] = Variable<int>(idGasto.value);
    }
    if (idIngreso.present) {
      map['id_ingreso'] = Variable<int>(idIngreso.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransaccionesCompanion(')
          ..write('id: $id, ')
          ..write('idCuenta: $idCuenta, ')
          ..write('cantidad: $cantidad, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('idGasto: $idGasto, ')
          ..write('idIngreso: $idIngreso')
          ..write(')'))
        .toString();
  }
}

class $TransaccionesProgramadasTable extends TransaccionesProgramadas
    with TableInfo<$TransaccionesProgramadasTable, TransaccionProgramada> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransaccionesProgramadasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TipoTransaccion, int> tipo =
      GeneratedColumn<int>('tipo', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TipoTransaccion>(
              $TransaccionesProgramadasTable.$convertertipo);
  static const VerificationMeta _idCategoriaMeta =
      const VerificationMeta('idCategoria');
  @override
  late final GeneratedColumn<int> idCategoria = GeneratedColumn<int>(
      'id_categoria', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categorias (id)'));
  static const VerificationMeta _idCuentaOrigenMeta =
      const VerificationMeta('idCuentaOrigen');
  @override
  late final GeneratedColumn<int> idCuentaOrigen = GeneratedColumn<int>(
      'id_cuenta_origen', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cuentas (id)'));
  static const VerificationMeta _idCuentaDestinoMeta =
      const VerificationMeta('idCuentaDestino');
  @override
  late final GeneratedColumn<int> idCuentaDestino = GeneratedColumn<int>(
      'id_cuenta_destino', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cuentas (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<Frecuencia, int> frecuencia =
      GeneratedColumn<int>('frecuencia', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Frecuencia>(
              $TransaccionesProgramadasTable.$converterfrecuencia);
  static const VerificationMeta _fechaInicioMeta =
      const VerificationMeta('fechaInicio');
  @override
  late final GeneratedColumn<DateTime> fechaInicio = GeneratedColumn<DateTime>(
      'fecha_inicio', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _proximaEjecucionMeta =
      const VerificationMeta('proximaEjecucion');
  @override
  late final GeneratedColumn<DateTime> proximaEjecucion =
      GeneratedColumn<DateTime>('proxima_ejecucion', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaFinMeta =
      const VerificationMeta('fechaFin');
  @override
  late final GeneratedColumn<DateTime> fechaFin = GeneratedColumn<DateTime>(
      'fecha_fin', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isTransferenciaMeta =
      const VerificationMeta('isTransferencia');
  @override
  late final GeneratedColumn<bool> isTransferencia = GeneratedColumn<bool>(
      'is_transferencia', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_transferencia" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _diaDelMesMeta =
      const VerificationMeta('diaDelMes');
  @override
  late final GeneratedColumn<int> diaDelMes = GeneratedColumn<int>(
      'dia_del_mes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _diaDeLaSemanaMeta =
      const VerificationMeta('diaDeLaSemana');
  @override
  late final GeneratedColumn<int> diaDeLaSemana = GeneratedColumn<int>(
      'dia_de_la_semana', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        descripcion,
        cantidad,
        tipo,
        idCategoria,
        idCuentaOrigen,
        idCuentaDestino,
        frecuencia,
        fechaInicio,
        proximaEjecucion,
        fechaFin,
        isTransferencia,
        diaDelMes,
        diaDeLaSemana
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transacciones_programadas';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransaccionProgramada> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('id_categoria')) {
      context.handle(
          _idCategoriaMeta,
          idCategoria.isAcceptableOrUnknown(
              data['id_categoria']!, _idCategoriaMeta));
    }
    if (data.containsKey('id_cuenta_origen')) {
      context.handle(
          _idCuentaOrigenMeta,
          idCuentaOrigen.isAcceptableOrUnknown(
              data['id_cuenta_origen']!, _idCuentaOrigenMeta));
    }
    if (data.containsKey('id_cuenta_destino')) {
      context.handle(
          _idCuentaDestinoMeta,
          idCuentaDestino.isAcceptableOrUnknown(
              data['id_cuenta_destino']!, _idCuentaDestinoMeta));
    }
    if (data.containsKey('fecha_inicio')) {
      context.handle(
          _fechaInicioMeta,
          fechaInicio.isAcceptableOrUnknown(
              data['fecha_inicio']!, _fechaInicioMeta));
    } else if (isInserting) {
      context.missing(_fechaInicioMeta);
    }
    if (data.containsKey('proxima_ejecucion')) {
      context.handle(
          _proximaEjecucionMeta,
          proximaEjecucion.isAcceptableOrUnknown(
              data['proxima_ejecucion']!, _proximaEjecucionMeta));
    } else if (isInserting) {
      context.missing(_proximaEjecucionMeta);
    }
    if (data.containsKey('fecha_fin')) {
      context.handle(_fechaFinMeta,
          fechaFin.isAcceptableOrUnknown(data['fecha_fin']!, _fechaFinMeta));
    }
    if (data.containsKey('is_transferencia')) {
      context.handle(
          _isTransferenciaMeta,
          isTransferencia.isAcceptableOrUnknown(
              data['is_transferencia']!, _isTransferenciaMeta));
    }
    if (data.containsKey('dia_del_mes')) {
      context.handle(
          _diaDelMesMeta,
          diaDelMes.isAcceptableOrUnknown(
              data['dia_del_mes']!, _diaDelMesMeta));
    }
    if (data.containsKey('dia_de_la_semana')) {
      context.handle(
          _diaDeLaSemanaMeta,
          diaDeLaSemana.isAcceptableOrUnknown(
              data['dia_de_la_semana']!, _diaDeLaSemanaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransaccionProgramada map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransaccionProgramada(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cantidad'])!,
      tipo: $TransaccionesProgramadasTable.$convertertipo.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}tipo'])!),
      idCategoria: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_categoria']),
      idCuentaOrigen: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_cuenta_origen']),
      idCuentaDestino: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_cuenta_destino']),
      frecuencia: $TransaccionesProgramadasTable.$converterfrecuencia.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}frecuencia'])!),
      fechaInicio: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_inicio'])!,
      proximaEjecucion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}proxima_ejecucion'])!,
      fechaFin: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_fin']),
      isTransferencia: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_transferencia'])!,
      diaDelMes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dia_del_mes']),
      diaDeLaSemana: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dia_de_la_semana']),
    );
  }

  @override
  $TransaccionesProgramadasTable createAlias(String alias) {
    return $TransaccionesProgramadasTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoTransaccion, int, int> $convertertipo =
      const EnumIndexConverter<TipoTransaccion>(TipoTransaccion.values);
  static JsonTypeConverter2<Frecuencia, int, int> $converterfrecuencia =
      const EnumIndexConverter<Frecuencia>(Frecuencia.values);
}

class TransaccionProgramada extends DataClass
    implements Insertable<TransaccionProgramada> {
  final int id;
  final String descripcion;
  final double cantidad;
  final TipoTransaccion tipo;
  final int? idCategoria;
  final int? idCuentaOrigen;
  final int? idCuentaDestino;
  final Frecuencia frecuencia;
  final DateTime fechaInicio;
  final DateTime proximaEjecucion;
  final DateTime? fechaFin;
  final bool isTransferencia;
  final int? diaDelMes;
  final int? diaDeLaSemana;
  const TransaccionProgramada(
      {required this.id,
      required this.descripcion,
      required this.cantidad,
      required this.tipo,
      this.idCategoria,
      this.idCuentaOrigen,
      this.idCuentaDestino,
      required this.frecuencia,
      required this.fechaInicio,
      required this.proximaEjecucion,
      this.fechaFin,
      required this.isTransferencia,
      this.diaDelMes,
      this.diaDeLaSemana});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['descripcion'] = Variable<String>(descripcion);
    map['cantidad'] = Variable<double>(cantidad);
    {
      map['tipo'] = Variable<int>(
          $TransaccionesProgramadasTable.$convertertipo.toSql(tipo));
    }
    if (!nullToAbsent || idCategoria != null) {
      map['id_categoria'] = Variable<int>(idCategoria);
    }
    if (!nullToAbsent || idCuentaOrigen != null) {
      map['id_cuenta_origen'] = Variable<int>(idCuentaOrigen);
    }
    if (!nullToAbsent || idCuentaDestino != null) {
      map['id_cuenta_destino'] = Variable<int>(idCuentaDestino);
    }
    {
      map['frecuencia'] = Variable<int>($TransaccionesProgramadasTable
          .$converterfrecuencia
          .toSql(frecuencia));
    }
    map['fecha_inicio'] = Variable<DateTime>(fechaInicio);
    map['proxima_ejecucion'] = Variable<DateTime>(proximaEjecucion);
    if (!nullToAbsent || fechaFin != null) {
      map['fecha_fin'] = Variable<DateTime>(fechaFin);
    }
    map['is_transferencia'] = Variable<bool>(isTransferencia);
    if (!nullToAbsent || diaDelMes != null) {
      map['dia_del_mes'] = Variable<int>(diaDelMes);
    }
    if (!nullToAbsent || diaDeLaSemana != null) {
      map['dia_de_la_semana'] = Variable<int>(diaDeLaSemana);
    }
    return map;
  }

  TransaccionesProgramadasCompanion toCompanion(bool nullToAbsent) {
    return TransaccionesProgramadasCompanion(
      id: Value(id),
      descripcion: Value(descripcion),
      cantidad: Value(cantidad),
      tipo: Value(tipo),
      idCategoria: idCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(idCategoria),
      idCuentaOrigen: idCuentaOrigen == null && nullToAbsent
          ? const Value.absent()
          : Value(idCuentaOrigen),
      idCuentaDestino: idCuentaDestino == null && nullToAbsent
          ? const Value.absent()
          : Value(idCuentaDestino),
      frecuencia: Value(frecuencia),
      fechaInicio: Value(fechaInicio),
      proximaEjecucion: Value(proximaEjecucion),
      fechaFin: fechaFin == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaFin),
      isTransferencia: Value(isTransferencia),
      diaDelMes: diaDelMes == null && nullToAbsent
          ? const Value.absent()
          : Value(diaDelMes),
      diaDeLaSemana: diaDeLaSemana == null && nullToAbsent
          ? const Value.absent()
          : Value(diaDeLaSemana),
    );
  }

  factory TransaccionProgramada.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransaccionProgramada(
      id: serializer.fromJson<int>(json['id']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      tipo: $TransaccionesProgramadasTable.$convertertipo
          .fromJson(serializer.fromJson<int>(json['tipo'])),
      idCategoria: serializer.fromJson<int?>(json['idCategoria']),
      idCuentaOrigen: serializer.fromJson<int?>(json['idCuentaOrigen']),
      idCuentaDestino: serializer.fromJson<int?>(json['idCuentaDestino']),
      frecuencia: $TransaccionesProgramadasTable.$converterfrecuencia
          .fromJson(serializer.fromJson<int>(json['frecuencia'])),
      fechaInicio: serializer.fromJson<DateTime>(json['fechaInicio']),
      proximaEjecucion: serializer.fromJson<DateTime>(json['proximaEjecucion']),
      fechaFin: serializer.fromJson<DateTime?>(json['fechaFin']),
      isTransferencia: serializer.fromJson<bool>(json['isTransferencia']),
      diaDelMes: serializer.fromJson<int?>(json['diaDelMes']),
      diaDeLaSemana: serializer.fromJson<int?>(json['diaDeLaSemana']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'descripcion': serializer.toJson<String>(descripcion),
      'cantidad': serializer.toJson<double>(cantidad),
      'tipo': serializer.toJson<int>(
          $TransaccionesProgramadasTable.$convertertipo.toJson(tipo)),
      'idCategoria': serializer.toJson<int?>(idCategoria),
      'idCuentaOrigen': serializer.toJson<int?>(idCuentaOrigen),
      'idCuentaDestino': serializer.toJson<int?>(idCuentaDestino),
      'frecuencia': serializer.toJson<int>($TransaccionesProgramadasTable
          .$converterfrecuencia
          .toJson(frecuencia)),
      'fechaInicio': serializer.toJson<DateTime>(fechaInicio),
      'proximaEjecucion': serializer.toJson<DateTime>(proximaEjecucion),
      'fechaFin': serializer.toJson<DateTime?>(fechaFin),
      'isTransferencia': serializer.toJson<bool>(isTransferencia),
      'diaDelMes': serializer.toJson<int?>(diaDelMes),
      'diaDeLaSemana': serializer.toJson<int?>(diaDeLaSemana),
    };
  }

  TransaccionProgramada copyWith(
          {int? id,
          String? descripcion,
          double? cantidad,
          TipoTransaccion? tipo,
          Value<int?> idCategoria = const Value.absent(),
          Value<int?> idCuentaOrigen = const Value.absent(),
          Value<int?> idCuentaDestino = const Value.absent(),
          Frecuencia? frecuencia,
          DateTime? fechaInicio,
          DateTime? proximaEjecucion,
          Value<DateTime?> fechaFin = const Value.absent(),
          bool? isTransferencia,
          Value<int?> diaDelMes = const Value.absent(),
          Value<int?> diaDeLaSemana = const Value.absent()}) =>
      TransaccionProgramada(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        cantidad: cantidad ?? this.cantidad,
        tipo: tipo ?? this.tipo,
        idCategoria: idCategoria.present ? idCategoria.value : this.idCategoria,
        idCuentaOrigen:
            idCuentaOrigen.present ? idCuentaOrigen.value : this.idCuentaOrigen,
        idCuentaDestino: idCuentaDestino.present
            ? idCuentaDestino.value
            : this.idCuentaDestino,
        frecuencia: frecuencia ?? this.frecuencia,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        proximaEjecucion: proximaEjecucion ?? this.proximaEjecucion,
        fechaFin: fechaFin.present ? fechaFin.value : this.fechaFin,
        isTransferencia: isTransferencia ?? this.isTransferencia,
        diaDelMes: diaDelMes.present ? diaDelMes.value : this.diaDelMes,
        diaDeLaSemana:
            diaDeLaSemana.present ? diaDeLaSemana.value : this.diaDeLaSemana,
      );
  TransaccionProgramada copyWithCompanion(
      TransaccionesProgramadasCompanion data) {
    return TransaccionProgramada(
      id: data.id.present ? data.id.value : this.id,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      idCategoria:
          data.idCategoria.present ? data.idCategoria.value : this.idCategoria,
      idCuentaOrigen: data.idCuentaOrigen.present
          ? data.idCuentaOrigen.value
          : this.idCuentaOrigen,
      idCuentaDestino: data.idCuentaDestino.present
          ? data.idCuentaDestino.value
          : this.idCuentaDestino,
      frecuencia:
          data.frecuencia.present ? data.frecuencia.value : this.frecuencia,
      fechaInicio:
          data.fechaInicio.present ? data.fechaInicio.value : this.fechaInicio,
      proximaEjecucion: data.proximaEjecucion.present
          ? data.proximaEjecucion.value
          : this.proximaEjecucion,
      fechaFin: data.fechaFin.present ? data.fechaFin.value : this.fechaFin,
      isTransferencia: data.isTransferencia.present
          ? data.isTransferencia.value
          : this.isTransferencia,
      diaDelMes: data.diaDelMes.present ? data.diaDelMes.value : this.diaDelMes,
      diaDeLaSemana: data.diaDeLaSemana.present
          ? data.diaDeLaSemana.value
          : this.diaDeLaSemana,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransaccionProgramada(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('cantidad: $cantidad, ')
          ..write('tipo: $tipo, ')
          ..write('idCategoria: $idCategoria, ')
          ..write('idCuentaOrigen: $idCuentaOrigen, ')
          ..write('idCuentaDestino: $idCuentaDestino, ')
          ..write('frecuencia: $frecuencia, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('proximaEjecucion: $proximaEjecucion, ')
          ..write('fechaFin: $fechaFin, ')
          ..write('isTransferencia: $isTransferencia, ')
          ..write('diaDelMes: $diaDelMes, ')
          ..write('diaDeLaSemana: $diaDeLaSemana')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      descripcion,
      cantidad,
      tipo,
      idCategoria,
      idCuentaOrigen,
      idCuentaDestino,
      frecuencia,
      fechaInicio,
      proximaEjecucion,
      fechaFin,
      isTransferencia,
      diaDelMes,
      diaDeLaSemana);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransaccionProgramada &&
          other.id == this.id &&
          other.descripcion == this.descripcion &&
          other.cantidad == this.cantidad &&
          other.tipo == this.tipo &&
          other.idCategoria == this.idCategoria &&
          other.idCuentaOrigen == this.idCuentaOrigen &&
          other.idCuentaDestino == this.idCuentaDestino &&
          other.frecuencia == this.frecuencia &&
          other.fechaInicio == this.fechaInicio &&
          other.proximaEjecucion == this.proximaEjecucion &&
          other.fechaFin == this.fechaFin &&
          other.isTransferencia == this.isTransferencia &&
          other.diaDelMes == this.diaDelMes &&
          other.diaDeLaSemana == this.diaDeLaSemana);
}

class TransaccionesProgramadasCompanion
    extends UpdateCompanion<TransaccionProgramada> {
  final Value<int> id;
  final Value<String> descripcion;
  final Value<double> cantidad;
  final Value<TipoTransaccion> tipo;
  final Value<int?> idCategoria;
  final Value<int?> idCuentaOrigen;
  final Value<int?> idCuentaDestino;
  final Value<Frecuencia> frecuencia;
  final Value<DateTime> fechaInicio;
  final Value<DateTime> proximaEjecucion;
  final Value<DateTime?> fechaFin;
  final Value<bool> isTransferencia;
  final Value<int?> diaDelMes;
  final Value<int?> diaDeLaSemana;
  const TransaccionesProgramadasCompanion({
    this.id = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.tipo = const Value.absent(),
    this.idCategoria = const Value.absent(),
    this.idCuentaOrigen = const Value.absent(),
    this.idCuentaDestino = const Value.absent(),
    this.frecuencia = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.proximaEjecucion = const Value.absent(),
    this.fechaFin = const Value.absent(),
    this.isTransferencia = const Value.absent(),
    this.diaDelMes = const Value.absent(),
    this.diaDeLaSemana = const Value.absent(),
  });
  TransaccionesProgramadasCompanion.insert({
    this.id = const Value.absent(),
    required String descripcion,
    required double cantidad,
    required TipoTransaccion tipo,
    this.idCategoria = const Value.absent(),
    this.idCuentaOrigen = const Value.absent(),
    this.idCuentaDestino = const Value.absent(),
    required Frecuencia frecuencia,
    required DateTime fechaInicio,
    required DateTime proximaEjecucion,
    this.fechaFin = const Value.absent(),
    this.isTransferencia = const Value.absent(),
    this.diaDelMes = const Value.absent(),
    this.diaDeLaSemana = const Value.absent(),
  })  : descripcion = Value(descripcion),
        cantidad = Value(cantidad),
        tipo = Value(tipo),
        frecuencia = Value(frecuencia),
        fechaInicio = Value(fechaInicio),
        proximaEjecucion = Value(proximaEjecucion);
  static Insertable<TransaccionProgramada> custom({
    Expression<int>? id,
    Expression<String>? descripcion,
    Expression<double>? cantidad,
    Expression<int>? tipo,
    Expression<int>? idCategoria,
    Expression<int>? idCuentaOrigen,
    Expression<int>? idCuentaDestino,
    Expression<int>? frecuencia,
    Expression<DateTime>? fechaInicio,
    Expression<DateTime>? proximaEjecucion,
    Expression<DateTime>? fechaFin,
    Expression<bool>? isTransferencia,
    Expression<int>? diaDelMes,
    Expression<int>? diaDeLaSemana,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descripcion != null) 'descripcion': descripcion,
      if (cantidad != null) 'cantidad': cantidad,
      if (tipo != null) 'tipo': tipo,
      if (idCategoria != null) 'id_categoria': idCategoria,
      if (idCuentaOrigen != null) 'id_cuenta_origen': idCuentaOrigen,
      if (idCuentaDestino != null) 'id_cuenta_destino': idCuentaDestino,
      if (frecuencia != null) 'frecuencia': frecuencia,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (proximaEjecucion != null) 'proxima_ejecucion': proximaEjecucion,
      if (fechaFin != null) 'fecha_fin': fechaFin,
      if (isTransferencia != null) 'is_transferencia': isTransferencia,
      if (diaDelMes != null) 'dia_del_mes': diaDelMes,
      if (diaDeLaSemana != null) 'dia_de_la_semana': diaDeLaSemana,
    });
  }

  TransaccionesProgramadasCompanion copyWith(
      {Value<int>? id,
      Value<String>? descripcion,
      Value<double>? cantidad,
      Value<TipoTransaccion>? tipo,
      Value<int?>? idCategoria,
      Value<int?>? idCuentaOrigen,
      Value<int?>? idCuentaDestino,
      Value<Frecuencia>? frecuencia,
      Value<DateTime>? fechaInicio,
      Value<DateTime>? proximaEjecucion,
      Value<DateTime?>? fechaFin,
      Value<bool>? isTransferencia,
      Value<int?>? diaDelMes,
      Value<int?>? diaDeLaSemana}) {
    return TransaccionesProgramadasCompanion(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      cantidad: cantidad ?? this.cantidad,
      tipo: tipo ?? this.tipo,
      idCategoria: idCategoria ?? this.idCategoria,
      idCuentaOrigen: idCuentaOrigen ?? this.idCuentaOrigen,
      idCuentaDestino: idCuentaDestino ?? this.idCuentaDestino,
      frecuencia: frecuencia ?? this.frecuencia,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      proximaEjecucion: proximaEjecucion ?? this.proximaEjecucion,
      fechaFin: fechaFin ?? this.fechaFin,
      isTransferencia: isTransferencia ?? this.isTransferencia,
      diaDelMes: diaDelMes ?? this.diaDelMes,
      diaDeLaSemana: diaDeLaSemana ?? this.diaDeLaSemana,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<int>(
          $TransaccionesProgramadasTable.$convertertipo.toSql(tipo.value));
    }
    if (idCategoria.present) {
      map['id_categoria'] = Variable<int>(idCategoria.value);
    }
    if (idCuentaOrigen.present) {
      map['id_cuenta_origen'] = Variable<int>(idCuentaOrigen.value);
    }
    if (idCuentaDestino.present) {
      map['id_cuenta_destino'] = Variable<int>(idCuentaDestino.value);
    }
    if (frecuencia.present) {
      map['frecuencia'] = Variable<int>($TransaccionesProgramadasTable
          .$converterfrecuencia
          .toSql(frecuencia.value));
    }
    if (fechaInicio.present) {
      map['fecha_inicio'] = Variable<DateTime>(fechaInicio.value);
    }
    if (proximaEjecucion.present) {
      map['proxima_ejecucion'] = Variable<DateTime>(proximaEjecucion.value);
    }
    if (fechaFin.present) {
      map['fecha_fin'] = Variable<DateTime>(fechaFin.value);
    }
    if (isTransferencia.present) {
      map['is_transferencia'] = Variable<bool>(isTransferencia.value);
    }
    if (diaDelMes.present) {
      map['dia_del_mes'] = Variable<int>(diaDelMes.value);
    }
    if (diaDeLaSemana.present) {
      map['dia_de_la_semana'] = Variable<int>(diaDeLaSemana.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransaccionesProgramadasCompanion(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('cantidad: $cantidad, ')
          ..write('tipo: $tipo, ')
          ..write('idCategoria: $idCategoria, ')
          ..write('idCuentaOrigen: $idCuentaOrigen, ')
          ..write('idCuentaDestino: $idCuentaDestino, ')
          ..write('frecuencia: $frecuencia, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('proximaEjecucion: $proximaEjecucion, ')
          ..write('fechaFin: $fechaFin, ')
          ..write('isTransferencia: $isTransferencia, ')
          ..write('diaDelMes: $diaDelMes, ')
          ..write('diaDeLaSemana: $diaDeLaSemana')
          ..write(')'))
        .toString();
  }
}

class $CreditosTable extends Creditos with TableInfo<$CreditosTable, Credito> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<CreditType, int> creditType =
      GeneratedColumn<int>('credit_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<CreditType>($CreditosTable.$convertercreditType);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _remainingAmountMeta =
      const VerificationMeta('remainingAmount');
  @override
  late final GeneratedColumn<double> remainingAmount = GeneratedColumn<double>(
      'remaining_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentAmountMeta =
      const VerificationMeta('paymentAmount');
  @override
  late final GeneratedColumn<double> paymentAmount = GeneratedColumn<double>(
      'payment_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _interestRateMeta =
      const VerificationMeta('interestRate');
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
      'interest_rate', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentDayMeta =
      const VerificationMeta('paymentDay');
  @override
  late final GeneratedColumn<int> paymentDay = GeneratedColumn<int>(
      'payment_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _linkedAccountIdMeta =
      const VerificationMeta('linkedAccountId');
  @override
  late final GeneratedColumn<int> linkedAccountId = GeneratedColumn<int>(
      'linked_account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cuentas (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastPaymentDateMeta =
      const VerificationMeta('lastPaymentDate');
  @override
  late final GeneratedColumn<DateTime> lastPaymentDate =
      GeneratedColumn<DateTime>('last_payment_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _plazoEnMesesMeta =
      const VerificationMeta('plazoEnMeses');
  @override
  late final GeneratedColumn<int> plazoEnMeses = GeneratedColumn<int>(
      'plazo_en_meses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _comisionAmortizacionParcialMeta =
      const VerificationMeta('comisionAmortizacionParcial');
  @override
  late final GeneratedColumn<double> comisionAmortizacionParcial =
      GeneratedColumn<double>(
          'comision_amortizacion_parcial', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _comisionCancelacionTotalMeta =
      const VerificationMeta('comisionCancelacionTotal');
  @override
  late final GeneratedColumn<double> comisionCancelacionTotal =
      GeneratedColumn<double>('comision_cancelacion_total', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        creditType,
        totalAmount,
        remainingAmount,
        paymentAmount,
        interestRate,
        paymentDay,
        linkedAccountId,
        createdAt,
        lastPaymentDate,
        plazoEnMeses,
        comisionAmortizacionParcial,
        comisionCancelacionTotal
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'creditos';
  @override
  VerificationContext validateIntegrity(Insertable<Credito> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('remaining_amount')) {
      context.handle(
          _remainingAmountMeta,
          remainingAmount.isAcceptableOrUnknown(
              data['remaining_amount']!, _remainingAmountMeta));
    } else if (isInserting) {
      context.missing(_remainingAmountMeta);
    }
    if (data.containsKey('payment_amount')) {
      context.handle(
          _paymentAmountMeta,
          paymentAmount.isAcceptableOrUnknown(
              data['payment_amount']!, _paymentAmountMeta));
    } else if (isInserting) {
      context.missing(_paymentAmountMeta);
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
          _interestRateMeta,
          interestRate.isAcceptableOrUnknown(
              data['interest_rate']!, _interestRateMeta));
    } else if (isInserting) {
      context.missing(_interestRateMeta);
    }
    if (data.containsKey('payment_day')) {
      context.handle(
          _paymentDayMeta,
          paymentDay.isAcceptableOrUnknown(
              data['payment_day']!, _paymentDayMeta));
    } else if (isInserting) {
      context.missing(_paymentDayMeta);
    }
    if (data.containsKey('linked_account_id')) {
      context.handle(
          _linkedAccountIdMeta,
          linkedAccountId.isAcceptableOrUnknown(
              data['linked_account_id']!, _linkedAccountIdMeta));
    } else if (isInserting) {
      context.missing(_linkedAccountIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_payment_date')) {
      context.handle(
          _lastPaymentDateMeta,
          lastPaymentDate.isAcceptableOrUnknown(
              data['last_payment_date']!, _lastPaymentDateMeta));
    }
    if (data.containsKey('plazo_en_meses')) {
      context.handle(
          _plazoEnMesesMeta,
          plazoEnMeses.isAcceptableOrUnknown(
              data['plazo_en_meses']!, _plazoEnMesesMeta));
    }
    if (data.containsKey('comision_amortizacion_parcial')) {
      context.handle(
          _comisionAmortizacionParcialMeta,
          comisionAmortizacionParcial.isAcceptableOrUnknown(
              data['comision_amortizacion_parcial']!,
              _comisionAmortizacionParcialMeta));
    }
    if (data.containsKey('comision_cancelacion_total')) {
      context.handle(
          _comisionCancelacionTotalMeta,
          comisionCancelacionTotal.isAcceptableOrUnknown(
              data['comision_cancelacion_total']!,
              _comisionCancelacionTotalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Credito map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Credito(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      creditType: $CreditosTable.$convertercreditType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}credit_type'])!),
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      remainingAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}remaining_amount'])!,
      paymentAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}payment_amount'])!,
      interestRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}interest_rate'])!,
      paymentDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_day'])!,
      linkedAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}linked_account_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastPaymentDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_payment_date']),
      plazoEnMeses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}plazo_en_meses'])!,
      comisionAmortizacionParcial: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}comision_amortizacion_parcial']),
      comisionCancelacionTotal: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}comision_cancelacion_total']),
    );
  }

  @override
  $CreditosTable createAlias(String alias) {
    return $CreditosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CreditType, int, int> $convertercreditType =
      const EnumIndexConverter<CreditType>(CreditType.values);
}

class Credito extends DataClass implements Insertable<Credito> {
  final int id;
  final String name;
  final CreditType creditType;
  final double totalAmount;
  final double remainingAmount;
  final double paymentAmount;
  final double interestRate;
  final int paymentDay;
  final int linkedAccountId;
  final DateTime createdAt;
  final DateTime? lastPaymentDate;
  final int plazoEnMeses;
  final double? comisionAmortizacionParcial;
  final double? comisionCancelacionTotal;
  const Credito(
      {required this.id,
      required this.name,
      required this.creditType,
      required this.totalAmount,
      required this.remainingAmount,
      required this.paymentAmount,
      required this.interestRate,
      required this.paymentDay,
      required this.linkedAccountId,
      required this.createdAt,
      this.lastPaymentDate,
      required this.plazoEnMeses,
      this.comisionAmortizacionParcial,
      this.comisionCancelacionTotal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['credit_type'] =
          Variable<int>($CreditosTable.$convertercreditType.toSql(creditType));
    }
    map['total_amount'] = Variable<double>(totalAmount);
    map['remaining_amount'] = Variable<double>(remainingAmount);
    map['payment_amount'] = Variable<double>(paymentAmount);
    map['interest_rate'] = Variable<double>(interestRate);
    map['payment_day'] = Variable<int>(paymentDay);
    map['linked_account_id'] = Variable<int>(linkedAccountId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastPaymentDate != null) {
      map['last_payment_date'] = Variable<DateTime>(lastPaymentDate);
    }
    map['plazo_en_meses'] = Variable<int>(plazoEnMeses);
    if (!nullToAbsent || comisionAmortizacionParcial != null) {
      map['comision_amortizacion_parcial'] =
          Variable<double>(comisionAmortizacionParcial);
    }
    if (!nullToAbsent || comisionCancelacionTotal != null) {
      map['comision_cancelacion_total'] =
          Variable<double>(comisionCancelacionTotal);
    }
    return map;
  }

  CreditosCompanion toCompanion(bool nullToAbsent) {
    return CreditosCompanion(
      id: Value(id),
      name: Value(name),
      creditType: Value(creditType),
      totalAmount: Value(totalAmount),
      remainingAmount: Value(remainingAmount),
      paymentAmount: Value(paymentAmount),
      interestRate: Value(interestRate),
      paymentDay: Value(paymentDay),
      linkedAccountId: Value(linkedAccountId),
      createdAt: Value(createdAt),
      lastPaymentDate: lastPaymentDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPaymentDate),
      plazoEnMeses: Value(plazoEnMeses),
      comisionAmortizacionParcial:
          comisionAmortizacionParcial == null && nullToAbsent
              ? const Value.absent()
              : Value(comisionAmortizacionParcial),
      comisionCancelacionTotal: comisionCancelacionTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(comisionCancelacionTotal),
    );
  }

  factory Credito.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Credito(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      creditType: $CreditosTable.$convertercreditType
          .fromJson(serializer.fromJson<int>(json['creditType'])),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      remainingAmount: serializer.fromJson<double>(json['remainingAmount']),
      paymentAmount: serializer.fromJson<double>(json['paymentAmount']),
      interestRate: serializer.fromJson<double>(json['interestRate']),
      paymentDay: serializer.fromJson<int>(json['paymentDay']),
      linkedAccountId: serializer.fromJson<int>(json['linkedAccountId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastPaymentDate: serializer.fromJson<DateTime?>(json['lastPaymentDate']),
      plazoEnMeses: serializer.fromJson<int>(json['plazoEnMeses']),
      comisionAmortizacionParcial:
          serializer.fromJson<double?>(json['comisionAmortizacionParcial']),
      comisionCancelacionTotal:
          serializer.fromJson<double?>(json['comisionCancelacionTotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'creditType': serializer
          .toJson<int>($CreditosTable.$convertercreditType.toJson(creditType)),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'remainingAmount': serializer.toJson<double>(remainingAmount),
      'paymentAmount': serializer.toJson<double>(paymentAmount),
      'interestRate': serializer.toJson<double>(interestRate),
      'paymentDay': serializer.toJson<int>(paymentDay),
      'linkedAccountId': serializer.toJson<int>(linkedAccountId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastPaymentDate': serializer.toJson<DateTime?>(lastPaymentDate),
      'plazoEnMeses': serializer.toJson<int>(plazoEnMeses),
      'comisionAmortizacionParcial':
          serializer.toJson<double?>(comisionAmortizacionParcial),
      'comisionCancelacionTotal':
          serializer.toJson<double?>(comisionCancelacionTotal),
    };
  }

  Credito copyWith(
          {int? id,
          String? name,
          CreditType? creditType,
          double? totalAmount,
          double? remainingAmount,
          double? paymentAmount,
          double? interestRate,
          int? paymentDay,
          int? linkedAccountId,
          DateTime? createdAt,
          Value<DateTime?> lastPaymentDate = const Value.absent(),
          int? plazoEnMeses,
          Value<double?> comisionAmortizacionParcial = const Value.absent(),
          Value<double?> comisionCancelacionTotal = const Value.absent()}) =>
      Credito(
        id: id ?? this.id,
        name: name ?? this.name,
        creditType: creditType ?? this.creditType,
        totalAmount: totalAmount ?? this.totalAmount,
        remainingAmount: remainingAmount ?? this.remainingAmount,
        paymentAmount: paymentAmount ?? this.paymentAmount,
        interestRate: interestRate ?? this.interestRate,
        paymentDay: paymentDay ?? this.paymentDay,
        linkedAccountId: linkedAccountId ?? this.linkedAccountId,
        createdAt: createdAt ?? this.createdAt,
        lastPaymentDate: lastPaymentDate.present
            ? lastPaymentDate.value
            : this.lastPaymentDate,
        plazoEnMeses: plazoEnMeses ?? this.plazoEnMeses,
        comisionAmortizacionParcial: comisionAmortizacionParcial.present
            ? comisionAmortizacionParcial.value
            : this.comisionAmortizacionParcial,
        comisionCancelacionTotal: comisionCancelacionTotal.present
            ? comisionCancelacionTotal.value
            : this.comisionCancelacionTotal,
      );
  Credito copyWithCompanion(CreditosCompanion data) {
    return Credito(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      creditType:
          data.creditType.present ? data.creditType.value : this.creditType,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      remainingAmount: data.remainingAmount.present
          ? data.remainingAmount.value
          : this.remainingAmount,
      paymentAmount: data.paymentAmount.present
          ? data.paymentAmount.value
          : this.paymentAmount,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      paymentDay:
          data.paymentDay.present ? data.paymentDay.value : this.paymentDay,
      linkedAccountId: data.linkedAccountId.present
          ? data.linkedAccountId.value
          : this.linkedAccountId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastPaymentDate: data.lastPaymentDate.present
          ? data.lastPaymentDate.value
          : this.lastPaymentDate,
      plazoEnMeses: data.plazoEnMeses.present
          ? data.plazoEnMeses.value
          : this.plazoEnMeses,
      comisionAmortizacionParcial: data.comisionAmortizacionParcial.present
          ? data.comisionAmortizacionParcial.value
          : this.comisionAmortizacionParcial,
      comisionCancelacionTotal: data.comisionCancelacionTotal.present
          ? data.comisionCancelacionTotal.value
          : this.comisionCancelacionTotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Credito(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('creditType: $creditType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('interestRate: $interestRate, ')
          ..write('paymentDay: $paymentDay, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastPaymentDate: $lastPaymentDate, ')
          ..write('plazoEnMeses: $plazoEnMeses, ')
          ..write('comisionAmortizacionParcial: $comisionAmortizacionParcial, ')
          ..write('comisionCancelacionTotal: $comisionCancelacionTotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      creditType,
      totalAmount,
      remainingAmount,
      paymentAmount,
      interestRate,
      paymentDay,
      linkedAccountId,
      createdAt,
      lastPaymentDate,
      plazoEnMeses,
      comisionAmortizacionParcial,
      comisionCancelacionTotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Credito &&
          other.id == this.id &&
          other.name == this.name &&
          other.creditType == this.creditType &&
          other.totalAmount == this.totalAmount &&
          other.remainingAmount == this.remainingAmount &&
          other.paymentAmount == this.paymentAmount &&
          other.interestRate == this.interestRate &&
          other.paymentDay == this.paymentDay &&
          other.linkedAccountId == this.linkedAccountId &&
          other.createdAt == this.createdAt &&
          other.lastPaymentDate == this.lastPaymentDate &&
          other.plazoEnMeses == this.plazoEnMeses &&
          other.comisionAmortizacionParcial ==
              this.comisionAmortizacionParcial &&
          other.comisionCancelacionTotal == this.comisionCancelacionTotal);
}

class CreditosCompanion extends UpdateCompanion<Credito> {
  final Value<int> id;
  final Value<String> name;
  final Value<CreditType> creditType;
  final Value<double> totalAmount;
  final Value<double> remainingAmount;
  final Value<double> paymentAmount;
  final Value<double> interestRate;
  final Value<int> paymentDay;
  final Value<int> linkedAccountId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastPaymentDate;
  final Value<int> plazoEnMeses;
  final Value<double?> comisionAmortizacionParcial;
  final Value<double?> comisionCancelacionTotal;
  const CreditosCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.creditType = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.paymentAmount = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.paymentDay = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastPaymentDate = const Value.absent(),
    this.plazoEnMeses = const Value.absent(),
    this.comisionAmortizacionParcial = const Value.absent(),
    this.comisionCancelacionTotal = const Value.absent(),
  });
  CreditosCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required CreditType creditType,
    required double totalAmount,
    required double remainingAmount,
    required double paymentAmount,
    required double interestRate,
    required int paymentDay,
    required int linkedAccountId,
    required DateTime createdAt,
    this.lastPaymentDate = const Value.absent(),
    this.plazoEnMeses = const Value.absent(),
    this.comisionAmortizacionParcial = const Value.absent(),
    this.comisionCancelacionTotal = const Value.absent(),
  })  : name = Value(name),
        creditType = Value(creditType),
        totalAmount = Value(totalAmount),
        remainingAmount = Value(remainingAmount),
        paymentAmount = Value(paymentAmount),
        interestRate = Value(interestRate),
        paymentDay = Value(paymentDay),
        linkedAccountId = Value(linkedAccountId),
        createdAt = Value(createdAt);
  static Insertable<Credito> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? creditType,
    Expression<double>? totalAmount,
    Expression<double>? remainingAmount,
    Expression<double>? paymentAmount,
    Expression<double>? interestRate,
    Expression<int>? paymentDay,
    Expression<int>? linkedAccountId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastPaymentDate,
    Expression<int>? plazoEnMeses,
    Expression<double>? comisionAmortizacionParcial,
    Expression<double>? comisionCancelacionTotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (creditType != null) 'credit_type': creditType,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (remainingAmount != null) 'remaining_amount': remainingAmount,
      if (paymentAmount != null) 'payment_amount': paymentAmount,
      if (interestRate != null) 'interest_rate': interestRate,
      if (paymentDay != null) 'payment_day': paymentDay,
      if (linkedAccountId != null) 'linked_account_id': linkedAccountId,
      if (createdAt != null) 'created_at': createdAt,
      if (lastPaymentDate != null) 'last_payment_date': lastPaymentDate,
      if (plazoEnMeses != null) 'plazo_en_meses': plazoEnMeses,
      if (comisionAmortizacionParcial != null)
        'comision_amortizacion_parcial': comisionAmortizacionParcial,
      if (comisionCancelacionTotal != null)
        'comision_cancelacion_total': comisionCancelacionTotal,
    });
  }

  CreditosCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<CreditType>? creditType,
      Value<double>? totalAmount,
      Value<double>? remainingAmount,
      Value<double>? paymentAmount,
      Value<double>? interestRate,
      Value<int>? paymentDay,
      Value<int>? linkedAccountId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastPaymentDate,
      Value<int>? plazoEnMeses,
      Value<double?>? comisionAmortizacionParcial,
      Value<double?>? comisionCancelacionTotal}) {
    return CreditosCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      creditType: creditType ?? this.creditType,
      totalAmount: totalAmount ?? this.totalAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      interestRate: interestRate ?? this.interestRate,
      paymentDay: paymentDay ?? this.paymentDay,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
      createdAt: createdAt ?? this.createdAt,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      plazoEnMeses: plazoEnMeses ?? this.plazoEnMeses,
      comisionAmortizacionParcial:
          comisionAmortizacionParcial ?? this.comisionAmortizacionParcial,
      comisionCancelacionTotal:
          comisionCancelacionTotal ?? this.comisionCancelacionTotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creditType.present) {
      map['credit_type'] = Variable<int>(
          $CreditosTable.$convertercreditType.toSql(creditType.value));
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (remainingAmount.present) {
      map['remaining_amount'] = Variable<double>(remainingAmount.value);
    }
    if (paymentAmount.present) {
      map['payment_amount'] = Variable<double>(paymentAmount.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (paymentDay.present) {
      map['payment_day'] = Variable<int>(paymentDay.value);
    }
    if (linkedAccountId.present) {
      map['linked_account_id'] = Variable<int>(linkedAccountId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastPaymentDate.present) {
      map['last_payment_date'] = Variable<DateTime>(lastPaymentDate.value);
    }
    if (plazoEnMeses.present) {
      map['plazo_en_meses'] = Variable<int>(plazoEnMeses.value);
    }
    if (comisionAmortizacionParcial.present) {
      map['comision_amortizacion_parcial'] =
          Variable<double>(comisionAmortizacionParcial.value);
    }
    if (comisionCancelacionTotal.present) {
      map['comision_cancelacion_total'] =
          Variable<double>(comisionCancelacionTotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditosCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('creditType: $creditType, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('interestRate: $interestRate, ')
          ..write('paymentDay: $paymentDay, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastPaymentDate: $lastPaymentDate, ')
          ..write('plazoEnMeses: $plazoEnMeses, ')
          ..write('comisionAmortizacionParcial: $comisionAmortizacionParcial, ')
          ..write('comisionCancelacionTotal: $comisionCancelacionTotal')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('EUR'));
  static const VerificationMeta _showBudgetLimitMeta =
      const VerificationMeta('showBudgetLimit');
  @override
  late final GeneratedColumn<bool> showBudgetLimit = GeneratedColumn<bool>(
      'show_budget_limit', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_budget_limit" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showMaxBalanceMeta =
      const VerificationMeta('showMaxBalance');
  @override
  late final GeneratedColumn<bool> showMaxBalance = GeneratedColumn<bool>(
      'show_max_balance', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_max_balance" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showMonthlySpendingMeta =
      const VerificationMeta('showMonthlySpending');
  @override
  late final GeneratedColumn<bool> showMonthlySpending = GeneratedColumn<bool>(
      'show_monthly_spending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_monthly_spending" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showProjectionMeta =
      const VerificationMeta('showProjection');
  @override
  late final GeneratedColumn<bool> showProjection = GeneratedColumn<bool>(
      'show_projection', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_projection" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastResetDateMeta =
      const VerificationMeta('lastResetDate');
  @override
  late final GeneratedColumn<DateTime> lastResetDate =
      GeneratedColumn<DateTime>('last_reset_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _monityControlEnabledMeta =
      const VerificationMeta('monityControlEnabled');
  @override
  late final GeneratedColumn<bool> monityControlEnabled = GeneratedColumn<bool>(
      'monity_control_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("monity_control_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        currency,
        showBudgetLimit,
        showMaxBalance,
        showMonthlySpending,
        showProjection,
        lastResetDate,
        monityControlEnabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('show_budget_limit')) {
      context.handle(
          _showBudgetLimitMeta,
          showBudgetLimit.isAcceptableOrUnknown(
              data['show_budget_limit']!, _showBudgetLimitMeta));
    }
    if (data.containsKey('show_max_balance')) {
      context.handle(
          _showMaxBalanceMeta,
          showMaxBalance.isAcceptableOrUnknown(
              data['show_max_balance']!, _showMaxBalanceMeta));
    }
    if (data.containsKey('show_monthly_spending')) {
      context.handle(
          _showMonthlySpendingMeta,
          showMonthlySpending.isAcceptableOrUnknown(
              data['show_monthly_spending']!, _showMonthlySpendingMeta));
    }
    if (data.containsKey('show_projection')) {
      context.handle(
          _showProjectionMeta,
          showProjection.isAcceptableOrUnknown(
              data['show_projection']!, _showProjectionMeta));
    }
    if (data.containsKey('last_reset_date')) {
      context.handle(
          _lastResetDateMeta,
          lastResetDate.isAcceptableOrUnknown(
              data['last_reset_date']!, _lastResetDateMeta));
    }
    if (data.containsKey('monity_control_enabled')) {
      context.handle(
          _monityControlEnabledMeta,
          monityControlEnabled.isAcceptableOrUnknown(
              data['monity_control_enabled']!, _monityControlEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      showBudgetLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_budget_limit'])!,
      showMaxBalance: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_max_balance'])!,
      showMonthlySpending: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_monthly_spending'])!,
      showProjection: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_projection'])!,
      lastResetDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_reset_date']),
      monityControlEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}monity_control_enabled'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String currency;
  final bool showBudgetLimit;
  final bool showMaxBalance;
  final bool showMonthlySpending;
  final bool showProjection;
  final DateTime? lastResetDate;
  final bool monityControlEnabled;
  const AppSetting(
      {required this.id,
      required this.currency,
      required this.showBudgetLimit,
      required this.showMaxBalance,
      required this.showMonthlySpending,
      required this.showProjection,
      this.lastResetDate,
      required this.monityControlEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency'] = Variable<String>(currency);
    map['show_budget_limit'] = Variable<bool>(showBudgetLimit);
    map['show_max_balance'] = Variable<bool>(showMaxBalance);
    map['show_monthly_spending'] = Variable<bool>(showMonthlySpending);
    map['show_projection'] = Variable<bool>(showProjection);
    if (!nullToAbsent || lastResetDate != null) {
      map['last_reset_date'] = Variable<DateTime>(lastResetDate);
    }
    map['monity_control_enabled'] = Variable<bool>(monityControlEnabled);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      currency: Value(currency),
      showBudgetLimit: Value(showBudgetLimit),
      showMaxBalance: Value(showMaxBalance),
      showMonthlySpending: Value(showMonthlySpending),
      showProjection: Value(showProjection),
      lastResetDate: lastResetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastResetDate),
      monityControlEnabled: Value(monityControlEnabled),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      currency: serializer.fromJson<String>(json['currency']),
      showBudgetLimit: serializer.fromJson<bool>(json['showBudgetLimit']),
      showMaxBalance: serializer.fromJson<bool>(json['showMaxBalance']),
      showMonthlySpending:
          serializer.fromJson<bool>(json['showMonthlySpending']),
      showProjection: serializer.fromJson<bool>(json['showProjection']),
      lastResetDate: serializer.fromJson<DateTime?>(json['lastResetDate']),
      monityControlEnabled:
          serializer.fromJson<bool>(json['monityControlEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currency': serializer.toJson<String>(currency),
      'showBudgetLimit': serializer.toJson<bool>(showBudgetLimit),
      'showMaxBalance': serializer.toJson<bool>(showMaxBalance),
      'showMonthlySpending': serializer.toJson<bool>(showMonthlySpending),
      'showProjection': serializer.toJson<bool>(showProjection),
      'lastResetDate': serializer.toJson<DateTime?>(lastResetDate),
      'monityControlEnabled': serializer.toJson<bool>(monityControlEnabled),
    };
  }

  AppSetting copyWith(
          {int? id,
          String? currency,
          bool? showBudgetLimit,
          bool? showMaxBalance,
          bool? showMonthlySpending,
          bool? showProjection,
          Value<DateTime?> lastResetDate = const Value.absent(),
          bool? monityControlEnabled}) =>
      AppSetting(
        id: id ?? this.id,
        currency: currency ?? this.currency,
        showBudgetLimit: showBudgetLimit ?? this.showBudgetLimit,
        showMaxBalance: showMaxBalance ?? this.showMaxBalance,
        showMonthlySpending: showMonthlySpending ?? this.showMonthlySpending,
        showProjection: showProjection ?? this.showProjection,
        lastResetDate:
            lastResetDate.present ? lastResetDate.value : this.lastResetDate,
        monityControlEnabled: monityControlEnabled ?? this.monityControlEnabled,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      currency: data.currency.present ? data.currency.value : this.currency,
      showBudgetLimit: data.showBudgetLimit.present
          ? data.showBudgetLimit.value
          : this.showBudgetLimit,
      showMaxBalance: data.showMaxBalance.present
          ? data.showMaxBalance.value
          : this.showMaxBalance,
      showMonthlySpending: data.showMonthlySpending.present
          ? data.showMonthlySpending.value
          : this.showMonthlySpending,
      showProjection: data.showProjection.present
          ? data.showProjection.value
          : this.showProjection,
      lastResetDate: data.lastResetDate.present
          ? data.lastResetDate.value
          : this.lastResetDate,
      monityControlEnabled: data.monityControlEnabled.present
          ? data.monityControlEnabled.value
          : this.monityControlEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('showBudgetLimit: $showBudgetLimit, ')
          ..write('showMaxBalance: $showMaxBalance, ')
          ..write('showMonthlySpending: $showMonthlySpending, ')
          ..write('showProjection: $showProjection, ')
          ..write('lastResetDate: $lastResetDate, ')
          ..write('monityControlEnabled: $monityControlEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currency, showBudgetLimit, showMaxBalance,
      showMonthlySpending, showProjection, lastResetDate, monityControlEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.currency == this.currency &&
          other.showBudgetLimit == this.showBudgetLimit &&
          other.showMaxBalance == this.showMaxBalance &&
          other.showMonthlySpending == this.showMonthlySpending &&
          other.showProjection == this.showProjection &&
          other.lastResetDate == this.lastResetDate &&
          other.monityControlEnabled == this.monityControlEnabled);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String> currency;
  final Value<bool> showBudgetLimit;
  final Value<bool> showMaxBalance;
  final Value<bool> showMonthlySpending;
  final Value<bool> showProjection;
  final Value<DateTime?> lastResetDate;
  final Value<bool> monityControlEnabled;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.showBudgetLimit = const Value.absent(),
    this.showMaxBalance = const Value.absent(),
    this.showMonthlySpending = const Value.absent(),
    this.showProjection = const Value.absent(),
    this.lastResetDate = const Value.absent(),
    this.monityControlEnabled = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.showBudgetLimit = const Value.absent(),
    this.showMaxBalance = const Value.absent(),
    this.showMonthlySpending = const Value.absent(),
    this.showProjection = const Value.absent(),
    this.lastResetDate = const Value.absent(),
    this.monityControlEnabled = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? currency,
    Expression<bool>? showBudgetLimit,
    Expression<bool>? showMaxBalance,
    Expression<bool>? showMonthlySpending,
    Expression<bool>? showProjection,
    Expression<DateTime>? lastResetDate,
    Expression<bool>? monityControlEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currency != null) 'currency': currency,
      if (showBudgetLimit != null) 'show_budget_limit': showBudgetLimit,
      if (showMaxBalance != null) 'show_max_balance': showMaxBalance,
      if (showMonthlySpending != null)
        'show_monthly_spending': showMonthlySpending,
      if (showProjection != null) 'show_projection': showProjection,
      if (lastResetDate != null) 'last_reset_date': lastResetDate,
      if (monityControlEnabled != null)
        'monity_control_enabled': monityControlEnabled,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? currency,
      Value<bool>? showBudgetLimit,
      Value<bool>? showMaxBalance,
      Value<bool>? showMonthlySpending,
      Value<bool>? showProjection,
      Value<DateTime?>? lastResetDate,
      Value<bool>? monityControlEnabled}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      showBudgetLimit: showBudgetLimit ?? this.showBudgetLimit,
      showMaxBalance: showMaxBalance ?? this.showMaxBalance,
      showMonthlySpending: showMonthlySpending ?? this.showMonthlySpending,
      showProjection: showProjection ?? this.showProjection,
      lastResetDate: lastResetDate ?? this.lastResetDate,
      monityControlEnabled: monityControlEnabled ?? this.monityControlEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (showBudgetLimit.present) {
      map['show_budget_limit'] = Variable<bool>(showBudgetLimit.value);
    }
    if (showMaxBalance.present) {
      map['show_max_balance'] = Variable<bool>(showMaxBalance.value);
    }
    if (showMonthlySpending.present) {
      map['show_monthly_spending'] = Variable<bool>(showMonthlySpending.value);
    }
    if (showProjection.present) {
      map['show_projection'] = Variable<bool>(showProjection.value);
    }
    if (lastResetDate.present) {
      map['last_reset_date'] = Variable<DateTime>(lastResetDate.value);
    }
    if (monityControlEnabled.present) {
      map['monity_control_enabled'] =
          Variable<bool>(monityControlEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('showBudgetLimit: $showBudgetLimit, ')
          ..write('showMaxBalance: $showMaxBalance, ')
          ..write('showMonthlySpending: $showMonthlySpending, ')
          ..write('showProjection: $showProjection, ')
          ..write('lastResetDate: $lastResetDate, ')
          ..write('monityControlEnabled: $monityControlEnabled')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, Quote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _quoteTextMeta =
      const VerificationMeta('quoteText');
  @override
  late final GeneratedColumn<String> quoteText = GeneratedColumn<String>(
      'quote_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isUsedMeta = const VerificationMeta('isUsed');
  @override
  late final GeneratedColumn<bool> isUsed = GeneratedColumn<bool>(
      'is_used', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_used" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, quoteText, isUsed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(Insertable<Quote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quote_text')) {
      context.handle(_quoteTextMeta,
          quoteText.isAcceptableOrUnknown(data['quote_text']!, _quoteTextMeta));
    } else if (isInserting) {
      context.missing(_quoteTextMeta);
    }
    if (data.containsKey('is_used')) {
      context.handle(_isUsedMeta,
          isUsed.isAcceptableOrUnknown(data['is_used']!, _isUsedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      quoteText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quote_text'])!,
      isUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_used'])!,
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class Quote extends DataClass implements Insertable<Quote> {
  final int id;
  final String quoteText;
  final bool isUsed;
  const Quote(
      {required this.id, required this.quoteText, required this.isUsed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quote_text'] = Variable<String>(quoteText);
    map['is_used'] = Variable<bool>(isUsed);
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      quoteText: Value(quoteText),
      isUsed: Value(isUsed),
    );
  }

  factory Quote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quote(
      id: serializer.fromJson<int>(json['id']),
      quoteText: serializer.fromJson<String>(json['quoteText']),
      isUsed: serializer.fromJson<bool>(json['isUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quoteText': serializer.toJson<String>(quoteText),
      'isUsed': serializer.toJson<bool>(isUsed),
    };
  }

  Quote copyWith({int? id, String? quoteText, bool? isUsed}) => Quote(
        id: id ?? this.id,
        quoteText: quoteText ?? this.quoteText,
        isUsed: isUsed ?? this.isUsed,
      );
  Quote copyWithCompanion(QuotesCompanion data) {
    return Quote(
      id: data.id.present ? data.id.value : this.id,
      quoteText: data.quoteText.present ? data.quoteText.value : this.quoteText,
      isUsed: data.isUsed.present ? data.isUsed.value : this.isUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quote(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('isUsed: $isUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, quoteText, isUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          other.id == this.id &&
          other.quoteText == this.quoteText &&
          other.isUsed == this.isUsed);
}

class QuotesCompanion extends UpdateCompanion<Quote> {
  final Value<int> id;
  final Value<String> quoteText;
  final Value<bool> isUsed;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.quoteText = const Value.absent(),
    this.isUsed = const Value.absent(),
  });
  QuotesCompanion.insert({
    this.id = const Value.absent(),
    required String quoteText,
    this.isUsed = const Value.absent(),
  }) : quoteText = Value(quoteText);
  static Insertable<Quote> custom({
    Expression<int>? id,
    Expression<String>? quoteText,
    Expression<bool>? isUsed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteText != null) 'quote_text': quoteText,
      if (isUsed != null) 'is_used': isUsed,
    });
  }

  QuotesCompanion copyWith(
      {Value<int>? id, Value<String>? quoteText, Value<bool>? isUsed}) {
    return QuotesCompanion(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      isUsed: isUsed ?? this.isUsed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quoteText.present) {
      map['quote_text'] = Variable<String>(quoteText.value);
    }
    if (isUsed.present) {
      map['is_used'] = Variable<bool>(isUsed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('isUsed: $isUsed')
          ..write(')'))
        .toString();
  }
}

class $HistorialSaldosTable extends HistorialSaldos
    with TableInfo<$HistorialSaldosTable, HistorialSaldo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorialSaldosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _saldoMeta = const VerificationMeta('saldo');
  @override
  late final GeneratedColumn<double> saldo = GeneratedColumn<double>(
      'saldo', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, fecha, saldo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial_saldos';
  @override
  VerificationContext validateIntegrity(Insertable<HistorialSaldo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('saldo')) {
      context.handle(
          _saldoMeta, saldo.isAcceptableOrUnknown(data['saldo']!, _saldoMeta));
    } else if (isInserting) {
      context.missing(_saldoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistorialSaldo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorialSaldo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      saldo: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}saldo'])!,
    );
  }

  @override
  $HistorialSaldosTable createAlias(String alias) {
    return $HistorialSaldosTable(attachedDatabase, alias);
  }
}

class HistorialSaldo extends DataClass implements Insertable<HistorialSaldo> {
  final int id;
  final DateTime fecha;
  final double saldo;
  const HistorialSaldo(
      {required this.id, required this.fecha, required this.saldo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['saldo'] = Variable<double>(saldo);
    return map;
  }

  HistorialSaldosCompanion toCompanion(bool nullToAbsent) {
    return HistorialSaldosCompanion(
      id: Value(id),
      fecha: Value(fecha),
      saldo: Value(saldo),
    );
  }

  factory HistorialSaldo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorialSaldo(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      saldo: serializer.fromJson<double>(json['saldo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'saldo': serializer.toJson<double>(saldo),
    };
  }

  HistorialSaldo copyWith({int? id, DateTime? fecha, double? saldo}) =>
      HistorialSaldo(
        id: id ?? this.id,
        fecha: fecha ?? this.fecha,
        saldo: saldo ?? this.saldo,
      );
  HistorialSaldo copyWithCompanion(HistorialSaldosCompanion data) {
    return HistorialSaldo(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      saldo: data.saldo.present ? data.saldo.value : this.saldo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistorialSaldo(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('saldo: $saldo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fecha, saldo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialSaldo &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.saldo == this.saldo);
}

class HistorialSaldosCompanion extends UpdateCompanion<HistorialSaldo> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<double> saldo;
  const HistorialSaldosCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.saldo = const Value.absent(),
  });
  HistorialSaldosCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    required double saldo,
  })  : fecha = Value(fecha),
        saldo = Value(saldo);
  static Insertable<HistorialSaldo> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<double>? saldo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (saldo != null) 'saldo': saldo,
    });
  }

  HistorialSaldosCompanion copyWith(
      {Value<int>? id, Value<DateTime>? fecha, Value<double>? saldo}) {
    return HistorialSaldosCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      saldo: saldo ?? this.saldo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (saldo.present) {
      map['saldo'] = Variable<double>(saldo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialSaldosCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('saldo: $saldo')
          ..write(')'))
        .toString();
  }
}

class $PremiosTable extends Premios with TableInfo<$PremiosTable, Premio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PremiosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _importeMeta =
      const VerificationMeta('importe');
  @override
  late final GeneratedColumn<double> importe = GeneratedColumn<double>(
      'importe', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _acumuladoMeta =
      const VerificationMeta('acumulado');
  @override
  late final GeneratedColumn<double> acumulado = GeneratedColumn<double>(
      'acumulado', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _fotoPathMeta =
      const VerificationMeta('fotoPath');
  @override
  late final GeneratedColumn<String> fotoPath = GeneratedColumn<String>(
      'foto_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, importe, acumulado, fotoPath, isCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'premios';
  @override
  VerificationContext validateIntegrity(Insertable<Premio> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('importe')) {
      context.handle(_importeMeta,
          importe.isAcceptableOrUnknown(data['importe']!, _importeMeta));
    } else if (isInserting) {
      context.missing(_importeMeta);
    }
    if (data.containsKey('acumulado')) {
      context.handle(_acumuladoMeta,
          acumulado.isAcceptableOrUnknown(data['acumulado']!, _acumuladoMeta));
    }
    if (data.containsKey('foto_path')) {
      context.handle(_fotoPathMeta,
          fotoPath.isAcceptableOrUnknown(data['foto_path']!, _fotoPathMeta));
    } else if (isInserting) {
      context.missing(_fotoPathMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Premio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Premio(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      importe: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}importe'])!,
      acumulado: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}acumulado'])!,
      fotoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foto_path'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
    );
  }

  @override
  $PremiosTable createAlias(String alias) {
    return $PremiosTable(attachedDatabase, alias);
  }
}

class Premio extends DataClass implements Insertable<Premio> {
  final int id;
  final String nombre;
  final double importe;
  final double acumulado;
  final String fotoPath;
  final bool isCompleted;
  const Premio(
      {required this.id,
      required this.nombre,
      required this.importe,
      required this.acumulado,
      required this.fotoPath,
      required this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['importe'] = Variable<double>(importe);
    map['acumulado'] = Variable<double>(acumulado);
    map['foto_path'] = Variable<String>(fotoPath);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  PremiosCompanion toCompanion(bool nullToAbsent) {
    return PremiosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      importe: Value(importe),
      acumulado: Value(acumulado),
      fotoPath: Value(fotoPath),
      isCompleted: Value(isCompleted),
    );
  }

  factory Premio.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Premio(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      importe: serializer.fromJson<double>(json['importe']),
      acumulado: serializer.fromJson<double>(json['acumulado']),
      fotoPath: serializer.fromJson<String>(json['fotoPath']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'importe': serializer.toJson<double>(importe),
      'acumulado': serializer.toJson<double>(acumulado),
      'fotoPath': serializer.toJson<String>(fotoPath),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  Premio copyWith(
          {int? id,
          String? nombre,
          double? importe,
          double? acumulado,
          String? fotoPath,
          bool? isCompleted}) =>
      Premio(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        importe: importe ?? this.importe,
        acumulado: acumulado ?? this.acumulado,
        fotoPath: fotoPath ?? this.fotoPath,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  Premio copyWithCompanion(PremiosCompanion data) {
    return Premio(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      importe: data.importe.present ? data.importe.value : this.importe,
      acumulado: data.acumulado.present ? data.acumulado.value : this.acumulado,
      fotoPath: data.fotoPath.present ? data.fotoPath.value : this.fotoPath,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Premio(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('importe: $importe, ')
          ..write('acumulado: $acumulado, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, importe, acumulado, fotoPath, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Premio &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.importe == this.importe &&
          other.acumulado == this.acumulado &&
          other.fotoPath == this.fotoPath &&
          other.isCompleted == this.isCompleted);
}

class PremiosCompanion extends UpdateCompanion<Premio> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<double> importe;
  final Value<double> acumulado;
  final Value<String> fotoPath;
  final Value<bool> isCompleted;
  const PremiosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.importe = const Value.absent(),
    this.acumulado = const Value.absent(),
    this.fotoPath = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  PremiosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required double importe,
    this.acumulado = const Value.absent(),
    required String fotoPath,
    this.isCompleted = const Value.absent(),
  })  : nombre = Value(nombre),
        importe = Value(importe),
        fotoPath = Value(fotoPath);
  static Insertable<Premio> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<double>? importe,
    Expression<double>? acumulado,
    Expression<String>? fotoPath,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (importe != null) 'importe': importe,
      if (acumulado != null) 'acumulado': acumulado,
      if (fotoPath != null) 'foto_path': fotoPath,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  PremiosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<double>? importe,
      Value<double>? acumulado,
      Value<String>? fotoPath,
      Value<bool>? isCompleted}) {
    return PremiosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      importe: importe ?? this.importe,
      acumulado: acumulado ?? this.acumulado,
      fotoPath: fotoPath ?? this.fotoPath,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (importe.present) {
      map['importe'] = Variable<double>(importe.value);
    }
    if (acumulado.present) {
      map['acumulado'] = Variable<double>(acumulado.value);
    }
    if (fotoPath.present) {
      map['foto_path'] = Variable<String>(fotoPath.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PremiosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('importe: $importe, ')
          ..write('acumulado: $acumulado, ')
          ..write('fotoPath: $fotoPath, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CuentasTable cuentas = $CuentasTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $IngresosTable ingresos = $IngresosTable(this);
  late final $GastosTable gastos = $GastosTable(this);
  late final $TransaccionesTable transacciones = $TransaccionesTable(this);
  late final $TransaccionesProgramadasTable transaccionesProgramadas =
      $TransaccionesProgramadasTable(this);
  late final $CreditosTable creditos = $CreditosTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $QuotesTable quotes = $QuotesTable(this);
  late final $HistorialSaldosTable historialSaldos =
      $HistorialSaldosTable(this);
  late final $PremiosTable premios = $PremiosTable(this);
  late final CuentasDao cuentasDao = CuentasDao(this as AppDatabase);
  late final CategoriasDao categoriasDao = CategoriasDao(this as AppDatabase);
  late final IngresosDao ingresosDao = IngresosDao(this as AppDatabase);
  late final GastosDao gastosDao = GastosDao(this as AppDatabase);
  late final TransaccionesDao transaccionesDao =
      TransaccionesDao(this as AppDatabase);
  late final TransaccionesProgramadasDao transaccionesProgramadasDao =
      TransaccionesProgramadasDao(this as AppDatabase);
  late final CreditosDao creditosDao = CreditosDao(this as AppDatabase);
  late final AppSettingsDao appSettingsDao =
      AppSettingsDao(this as AppDatabase);
  late final QuotesDao quotesDao = QuotesDao(this as AppDatabase);
  late final HistorialSaldosDao historialSaldosDao =
      HistorialSaldosDao(this as AppDatabase);
  late final PremiosDao premiosDao = PremiosDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        cuentas,
        categorias,
        ingresos,
        gastos,
        transacciones,
        transaccionesProgramadas,
        creditos,
        appSettings,
        quotes,
        historialSaldos,
        premios
      ];
}

typedef $$CuentasTableCreateCompanionBuilder = CuentasCompanion Function({
  Value<int> id,
  required String nombre,
  required double saldoActual,
  required double saldoMaximoMensual,
  required double limiteGastoMensual,
  Value<double> gastoAcumuladoMes,
  Value<double> ingresoAcumuladoMes,
  Value<double> sobranteMesAnterior,
  Value<int> orden,
  Value<double> adjustmentPercentage,
  Value<double> maxBalancePercentage,
});
typedef $$CuentasTableUpdateCompanionBuilder = CuentasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<double> saldoActual,
  Value<double> saldoMaximoMensual,
  Value<double> limiteGastoMensual,
  Value<double> gastoAcumuladoMes,
  Value<double> ingresoAcumuladoMes,
  Value<double> sobranteMesAnterior,
  Value<int> orden,
  Value<double> adjustmentPercentage,
  Value<double> maxBalancePercentage,
});

final class $$CuentasTableReferences
    extends BaseReferences<_$AppDatabase, $CuentasTable, Cuenta> {
  $$CuentasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransaccionesTable, List<Transaccion>>
      _transaccionesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transacciones,
              aliasName: $_aliasNameGenerator(
                  db.cuentas.id, db.transacciones.idCuenta));

  $$TransaccionesTableProcessedTableManager get transaccionesRefs {
    final manager = $$TransaccionesTableTableManager($_db, $_db.transacciones)
        .filter((f) => f.idCuenta.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transaccionesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransaccionesProgramadasTable,
      List<TransaccionProgramada>> _TransaccionesProgramadasComoOrigenTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.transaccionesProgramadas,
          aliasName: $_aliasNameGenerator(
              db.cuentas.id, db.transaccionesProgramadas.idCuentaOrigen));

  $$TransaccionesProgramadasTableProcessedTableManager
      get TransaccionesProgramadasComoOrigen {
    final manager = $$TransaccionesProgramadasTableTableManager(
            $_db, $_db.transaccionesProgramadas)
        .filter((f) => f.idCuentaOrigen.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_TransaccionesProgramadasComoOrigenTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransaccionesProgramadasTable,
      List<TransaccionProgramada>> _TransaccionesProgramadasComoDestinoTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.transaccionesProgramadas,
          aliasName: $_aliasNameGenerator(
              db.cuentas.id, db.transaccionesProgramadas.idCuentaDestino));

  $$TransaccionesProgramadasTableProcessedTableManager
      get TransaccionesProgramadasComoDestino {
    final manager = $$TransaccionesProgramadasTableTableManager(
            $_db, $_db.transaccionesProgramadas)
        .filter(
            (f) => f.idCuentaDestino.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_TransaccionesProgramadasComoDestinoTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CreditosTable, List<Credito>> _creditosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.creditos,
          aliasName:
              $_aliasNameGenerator(db.cuentas.id, db.creditos.linkedAccountId));

  $$CreditosTableProcessedTableManager get creditosRefs {
    final manager = $$CreditosTableTableManager($_db, $_db.creditos).filter(
        (f) => f.linkedAccountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_creditosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CuentasTableFilterComposer
    extends Composer<_$AppDatabase, $CuentasTable> {
  $$CuentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get saldoActual => $composableBuilder(
      column: $table.saldoActual, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get saldoMaximoMensual => $composableBuilder(
      column: $table.saldoMaximoMensual,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get limiteGastoMensual => $composableBuilder(
      column: $table.limiteGastoMensual,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gastoAcumuladoMes => $composableBuilder(
      column: $table.gastoAcumuladoMes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get ingresoAcumuladoMes => $composableBuilder(
      column: $table.ingresoAcumuladoMes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sobranteMesAnterior => $composableBuilder(
      column: $table.sobranteMesAnterior,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orden => $composableBuilder(
      column: $table.orden, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get adjustmentPercentage => $composableBuilder(
      column: $table.adjustmentPercentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxBalancePercentage => $composableBuilder(
      column: $table.maxBalancePercentage,
      builder: (column) => ColumnFilters(column));

  Expression<bool> transaccionesRefs(
      Expression<bool> Function($$TransaccionesTableFilterComposer f) f) {
    final $$TransaccionesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transacciones,
        getReferencedColumn: (t) => t.idCuenta,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransaccionesTableFilterComposer(
              $db: $db,
              $table: $db.transacciones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> TransaccionesProgramadasComoOrigen(
      Expression<bool> Function($$TransaccionesProgramadasTableFilterComposer f)
          f) {
    final $$TransaccionesProgramadasTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transaccionesProgramadas,
            getReferencedColumn: (t) => t.idCuentaOrigen,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransaccionesProgramadasTableFilterComposer(
                  $db: $db,
                  $table: $db.transaccionesProgramadas,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> TransaccionesProgramadasComoDestino(
      Expression<bool> Function($$TransaccionesProgramadasTableFilterComposer f)
          f) {
    final $$TransaccionesProgramadasTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transaccionesProgramadas,
            getReferencedColumn: (t) => t.idCuentaDestino,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransaccionesProgramadasTableFilterComposer(
                  $db: $db,
                  $table: $db.transaccionesProgramadas,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> creditosRefs(
      Expression<bool> Function($$CreditosTableFilterComposer f) f) {
    final $$CreditosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditos,
        getReferencedColumn: (t) => t.linkedAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditosTableFilterComposer(
              $db: $db,
              $table: $db.creditos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CuentasTableOrderingComposer
    extends Composer<_$AppDatabase, $CuentasTable> {
  $$CuentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get saldoActual => $composableBuilder(
      column: $table.saldoActual, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get saldoMaximoMensual => $composableBuilder(
      column: $table.saldoMaximoMensual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get limiteGastoMensual => $composableBuilder(
      column: $table.limiteGastoMensual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gastoAcumuladoMes => $composableBuilder(
      column: $table.gastoAcumuladoMes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get ingresoAcumuladoMes => $composableBuilder(
      column: $table.ingresoAcumuladoMes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sobranteMesAnterior => $composableBuilder(
      column: $table.sobranteMesAnterior,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orden => $composableBuilder(
      column: $table.orden, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get adjustmentPercentage => $composableBuilder(
      column: $table.adjustmentPercentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxBalancePercentage => $composableBuilder(
      column: $table.maxBalancePercentage,
      builder: (column) => ColumnOrderings(column));
}

class $$CuentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CuentasTable> {
  $$CuentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get saldoActual => $composableBuilder(
      column: $table.saldoActual, builder: (column) => column);

  GeneratedColumn<double> get saldoMaximoMensual => $composableBuilder(
      column: $table.saldoMaximoMensual, builder: (column) => column);

  GeneratedColumn<double> get limiteGastoMensual => $composableBuilder(
      column: $table.limiteGastoMensual, builder: (column) => column);

  GeneratedColumn<double> get gastoAcumuladoMes => $composableBuilder(
      column: $table.gastoAcumuladoMes, builder: (column) => column);

  GeneratedColumn<double> get ingresoAcumuladoMes => $composableBuilder(
      column: $table.ingresoAcumuladoMes, builder: (column) => column);

  GeneratedColumn<double> get sobranteMesAnterior => $composableBuilder(
      column: $table.sobranteMesAnterior, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<double> get adjustmentPercentage => $composableBuilder(
      column: $table.adjustmentPercentage, builder: (column) => column);

  GeneratedColumn<double> get maxBalancePercentage => $composableBuilder(
      column: $table.maxBalancePercentage, builder: (column) => column);

  Expression<T> transaccionesRefs<T extends Object>(
      Expression<T> Function($$TransaccionesTableAnnotationComposer a) f) {
    final $$TransaccionesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transacciones,
        getReferencedColumn: (t) => t.idCuenta,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransaccionesTableAnnotationComposer(
              $db: $db,
              $table: $db.transacciones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> TransaccionesProgramadasComoOrigen<T extends Object>(
      Expression<T> Function(
              $$TransaccionesProgramadasTableAnnotationComposer a)
          f) {
    final $$TransaccionesProgramadasTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transaccionesProgramadas,
            getReferencedColumn: (t) => t.idCuentaOrigen,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransaccionesProgramadasTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transaccionesProgramadas,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> TransaccionesProgramadasComoDestino<T extends Object>(
      Expression<T> Function(
              $$TransaccionesProgramadasTableAnnotationComposer a)
          f) {
    final $$TransaccionesProgramadasTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transaccionesProgramadas,
            getReferencedColumn: (t) => t.idCuentaDestino,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransaccionesProgramadasTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transaccionesProgramadas,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> creditosRefs<T extends Object>(
      Expression<T> Function($$CreditosTableAnnotationComposer a) f) {
    final $$CreditosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditos,
        getReferencedColumn: (t) => t.linkedAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditosTableAnnotationComposer(
              $db: $db,
              $table: $db.creditos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CuentasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CuentasTable,
    Cuenta,
    $$CuentasTableFilterComposer,
    $$CuentasTableOrderingComposer,
    $$CuentasTableAnnotationComposer,
    $$CuentasTableCreateCompanionBuilder,
    $$CuentasTableUpdateCompanionBuilder,
    (Cuenta, $$CuentasTableReferences),
    Cuenta,
    PrefetchHooks Function(
        {bool transaccionesRefs,
        bool TransaccionesProgramadasComoOrigen,
        bool TransaccionesProgramadasComoDestino,
        bool creditosRefs})> {
  $$CuentasTableTableManager(_$AppDatabase db, $CuentasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CuentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CuentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CuentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<double> saldoActual = const Value.absent(),
            Value<double> saldoMaximoMensual = const Value.absent(),
            Value<double> limiteGastoMensual = const Value.absent(),
            Value<double> gastoAcumuladoMes = const Value.absent(),
            Value<double> ingresoAcumuladoMes = const Value.absent(),
            Value<double> sobranteMesAnterior = const Value.absent(),
            Value<int> orden = const Value.absent(),
            Value<double> adjustmentPercentage = const Value.absent(),
            Value<double> maxBalancePercentage = const Value.absent(),
          }) =>
              CuentasCompanion(
            id: id,
            nombre: nombre,
            saldoActual: saldoActual,
            saldoMaximoMensual: saldoMaximoMensual,
            limiteGastoMensual: limiteGastoMensual,
            gastoAcumuladoMes: gastoAcumuladoMes,
            ingresoAcumuladoMes: ingresoAcumuladoMes,
            sobranteMesAnterior: sobranteMesAnterior,
            orden: orden,
            adjustmentPercentage: adjustmentPercentage,
            maxBalancePercentage: maxBalancePercentage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required double saldoActual,
            required double saldoMaximoMensual,
            required double limiteGastoMensual,
            Value<double> gastoAcumuladoMes = const Value.absent(),
            Value<double> ingresoAcumuladoMes = const Value.absent(),
            Value<double> sobranteMesAnterior = const Value.absent(),
            Value<int> orden = const Value.absent(),
            Value<double> adjustmentPercentage = const Value.absent(),
            Value<double> maxBalancePercentage = const Value.absent(),
          }) =>
              CuentasCompanion.insert(
            id: id,
            nombre: nombre,
            saldoActual: saldoActual,
            saldoMaximoMensual: saldoMaximoMensual,
            limiteGastoMensual: limiteGastoMensual,
            gastoAcumuladoMes: gastoAcumuladoMes,
            ingresoAcumuladoMes: ingresoAcumuladoMes,
            sobranteMesAnterior: sobranteMesAnterior,
            orden: orden,
            adjustmentPercentage: adjustmentPercentage,
            maxBalancePercentage: maxBalancePercentage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CuentasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {transaccionesRefs = false,
              TransaccionesProgramadasComoOrigen = false,
              TransaccionesProgramadasComoDestino = false,
              creditosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transaccionesRefs) db.transacciones,
                if (TransaccionesProgramadasComoOrigen)
                  db.transaccionesProgramadas,
                if (TransaccionesProgramadasComoDestino)
                  db.transaccionesProgramadas,
                if (creditosRefs) db.creditos
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transaccionesRefs)
                    await $_getPrefetchedData<Cuenta, $CuentasTable,
                            Transaccion>(
                        currentTable: table,
                        referencedTable: $$CuentasTableReferences
                            ._transaccionesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CuentasTableReferences(db, table, p0)
                                .transaccionesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.idCuenta == item.id),
                        typedResults: items),
                  if (TransaccionesProgramadasComoOrigen)
                    await $_getPrefetchedData<Cuenta, $CuentasTable,
                            TransaccionProgramada>(
                        currentTable: table,
                        referencedTable: $$CuentasTableReferences
                            ._TransaccionesProgramadasComoOrigenTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CuentasTableReferences(db, table, p0)
                                .TransaccionesProgramadasComoOrigen,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idCuentaOrigen == item.id),
                        typedResults: items),
                  if (TransaccionesProgramadasComoDestino)
                    await $_getPrefetchedData<Cuenta, $CuentasTable,
                            TransaccionProgramada>(
                        currentTable: table,
                        referencedTable: $$CuentasTableReferences
                            ._TransaccionesProgramadasComoDestinoTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CuentasTableReferences(db, table, p0)
                                .TransaccionesProgramadasComoDestino,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idCuentaDestino == item.id),
                        typedResults: items),
                  if (creditosRefs)
                    await $_getPrefetchedData<Cuenta, $CuentasTable, Credito>(
                        currentTable: table,
                        referencedTable:
                            $$CuentasTableReferences._creditosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CuentasTableReferences(db, table, p0)
                                .creditosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.linkedAccountId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CuentasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CuentasTable,
    Cuenta,
    $$CuentasTableFilterComposer,
    $$CuentasTableOrderingComposer,
    $$CuentasTableAnnotationComposer,
    $$CuentasTableCreateCompanionBuilder,
    $$CuentasTableUpdateCompanionBuilder,
    (Cuenta, $$CuentasTableReferences),
    Cuenta,
    PrefetchHooks Function(
        {bool transaccionesRefs,
        bool TransaccionesProgramadasComoOrigen,
        bool TransaccionesProgramadasComoDestino,
        bool creditosRefs})>;
typedef $$CategoriasTableCreateCompanionBuilder = CategoriasCompanion Function({
  Value<int> id,
  required String nombre,
  required TipoCategoria tipo,
  required String color,
  Value<String> icono,
});
typedef $$CategoriasTableUpdateCompanionBuilder = CategoriasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<TipoCategoria> tipo,
  Value<String> color,
  Value<String> icono,
});

final class $$CategoriasTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriasTable, Categoria> {
  $$CategoriasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$IngresosTable, List<Ingreso>> _ingresosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ingresos,
          aliasName:
              $_aliasNameGenerator(db.categorias.id, db.ingresos.idCategoria));

  $$IngresosTableProcessedTableManager get ingresosRefs {
    final manager = $$IngresosTableTableManager($_db, $_db.ingresos)
        .filter((f) => f.idCategoria.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ingresosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GastosTable, List<Gasto>> _gastosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.gastos,
          aliasName:
              $_aliasNameGenerator(db.categorias.id, db.gastos.idCategoria));

  $$GastosTableProcessedTableManager get gastosRefs {
    final manager = $$GastosTableTableManager($_db, $_db.gastos)
        .filter((f) => f.idCategoria.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gastosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransaccionesProgramadasTable,
      List<TransaccionProgramada>> _transaccionesProgramadasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.transaccionesProgramadas,
          aliasName: $_aliasNameGenerator(
              db.categorias.id, db.transaccionesProgramadas.idCategoria));

  $$TransaccionesProgramadasTableProcessedTableManager
      get transaccionesProgramadasRefs {
    final manager = $$TransaccionesProgramadasTableTableManager(
            $_db, $_db.transaccionesProgramadas)
        .filter((f) => f.idCategoria.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_transaccionesProgramadasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriasTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoCategoria, TipoCategoria, int> get tipo =>
      $composableBuilder(
          column: $table.tipo,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icono => $composableBuilder(
      column: $table.icono, builder: (column) => ColumnFilters(column));

  Expression<bool> ingresosRefs(
      Expression<bool> Function($$IngresosTableFilterComposer f) f) {
    final $$IngresosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ingresos,
        getReferencedColumn: (t) => t.idCategoria,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IngresosTableFilterComposer(
              $db: $db,
              $table: $db.ingresos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> gastosRefs(
      Expression<bool> Function($$GastosTableFilterComposer f) f) {
    final $$GastosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gastos,
        getReferencedColumn: (t) => t.idCategoria,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosTableFilterComposer(
              $db: $db,
              $table: $db.gastos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transaccionesProgramadasRefs(
      Expression<bool> Function($$TransaccionesProgramadasTableFilterComposer f)
          f) {
    final $$TransaccionesProgramadasTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transaccionesProgramadas,
            getReferencedColumn: (t) => t.idCategoria,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransaccionesProgramadasTableFilterComposer(
                  $db: $db,
                  $table: $db.transaccionesProgramadas,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icono => $composableBuilder(
      column: $table.icono, builder: (column) => ColumnOrderings(column));
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoCategoria, int> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icono =>
      $composableBuilder(column: $table.icono, builder: (column) => column);

  Expression<T> ingresosRefs<T extends Object>(
      Expression<T> Function($$IngresosTableAnnotationComposer a) f) {
    final $$IngresosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ingresos,
        getReferencedColumn: (t) => t.idCategoria,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IngresosTableAnnotationComposer(
              $db: $db,
              $table: $db.ingresos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> gastosRefs<T extends Object>(
      Expression<T> Function($$GastosTableAnnotationComposer a) f) {
    final $$GastosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gastos,
        getReferencedColumn: (t) => t.idCategoria,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosTableAnnotationComposer(
              $db: $db,
              $table: $db.gastos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transaccionesProgramadasRefs<T extends Object>(
      Expression<T> Function(
              $$TransaccionesProgramadasTableAnnotationComposer a)
          f) {
    final $$TransaccionesProgramadasTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transaccionesProgramadas,
            getReferencedColumn: (t) => t.idCategoria,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransaccionesProgramadasTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transaccionesProgramadas,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoriasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriasTable,
    Categoria,
    $$CategoriasTableFilterComposer,
    $$CategoriasTableOrderingComposer,
    $$CategoriasTableAnnotationComposer,
    $$CategoriasTableCreateCompanionBuilder,
    $$CategoriasTableUpdateCompanionBuilder,
    (Categoria, $$CategoriasTableReferences),
    Categoria,
    PrefetchHooks Function(
        {bool ingresosRefs,
        bool gastosRefs,
        bool transaccionesProgramadasRefs})> {
  $$CategoriasTableTableManager(_$AppDatabase db, $CategoriasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<TipoCategoria> tipo = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<String> icono = const Value.absent(),
          }) =>
              CategoriasCompanion(
            id: id,
            nombre: nombre,
            tipo: tipo,
            color: color,
            icono: icono,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required TipoCategoria tipo,
            required String color,
            Value<String> icono = const Value.absent(),
          }) =>
              CategoriasCompanion.insert(
            id: id,
            nombre: nombre,
            tipo: tipo,
            color: color,
            icono: icono,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {ingresosRefs = false,
              gastosRefs = false,
              transaccionesProgramadasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ingresosRefs) db.ingresos,
                if (gastosRefs) db.gastos,
                if (transaccionesProgramadasRefs) db.transaccionesProgramadas
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ingresosRefs)
                    await $_getPrefetchedData<Categoria, $CategoriasTable,
                            Ingreso>(
                        currentTable: table,
                        referencedTable:
                            $$CategoriasTableReferences._ingresosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriasTableReferences(db, table, p0)
                                .ingresosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idCategoria == item.id),
                        typedResults: items),
                  if (gastosRefs)
                    await $_getPrefetchedData<Categoria, $CategoriasTable,
                            Gasto>(
                        currentTable: table,
                        referencedTable:
                            $$CategoriasTableReferences._gastosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriasTableReferences(db, table, p0)
                                .gastosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idCategoria == item.id),
                        typedResults: items),
                  if (transaccionesProgramadasRefs)
                    await $_getPrefetchedData<Categoria, $CategoriasTable,
                            TransaccionProgramada>(
                        currentTable: table,
                        referencedTable: $$CategoriasTableReferences
                            ._transaccionesProgramadasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriasTableReferences(db, table, p0)
                                .transaccionesProgramadasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idCategoria == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriasTable,
    Categoria,
    $$CategoriasTableFilterComposer,
    $$CategoriasTableOrderingComposer,
    $$CategoriasTableAnnotationComposer,
    $$CategoriasTableCreateCompanionBuilder,
    $$CategoriasTableUpdateCompanionBuilder,
    (Categoria, $$CategoriasTableReferences),
    Categoria,
    PrefetchHooks Function(
        {bool ingresosRefs,
        bool gastosRefs,
        bool transaccionesProgramadasRefs})>;
typedef $$IngresosTableCreateCompanionBuilder = IngresosCompanion Function({
  Value<int> id,
  required double cantidadTotal,
  required DateTime fecha,
  required int idCategoria,
});
typedef $$IngresosTableUpdateCompanionBuilder = IngresosCompanion Function({
  Value<int> id,
  Value<double> cantidadTotal,
  Value<DateTime> fecha,
  Value<int> idCategoria,
});

final class $$IngresosTableReferences
    extends BaseReferences<_$AppDatabase, $IngresosTable, Ingreso> {
  $$IngresosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _idCategoriaTable(_$AppDatabase db) =>
      db.categorias.createAlias(
          $_aliasNameGenerator(db.ingresos.idCategoria, db.categorias.id));

  $$CategoriasTableProcessedTableManager get idCategoria {
    final $_column = $_itemColumn<int>('id_categoria')!;

    final manager = $$CategoriasTableTableManager($_db, $_db.categorias)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCategoriaTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransaccionesTable, List<Transaccion>>
      _transaccionesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transacciones,
              aliasName: $_aliasNameGenerator(
                  db.ingresos.id, db.transacciones.idIngreso));

  $$TransaccionesTableProcessedTableManager get transaccionesRefs {
    final manager = $$TransaccionesTableTableManager($_db, $_db.transacciones)
        .filter((f) => f.idIngreso.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transaccionesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$IngresosTableFilterComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cantidadTotal => $composableBuilder(
      column: $table.cantidadTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  $$CategoriasTableFilterComposer get idCategoria {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableFilterComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transaccionesRefs(
      Expression<bool> Function($$TransaccionesTableFilterComposer f) f) {
    final $$TransaccionesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transacciones,
        getReferencedColumn: (t) => t.idIngreso,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransaccionesTableFilterComposer(
              $db: $db,
              $table: $db.transacciones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$IngresosTableOrderingComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cantidadTotal => $composableBuilder(
      column: $table.cantidadTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  $$CategoriasTableOrderingComposer get idCategoria {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableOrderingComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IngresosTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get cantidadTotal => $composableBuilder(
      column: $table.cantidadTotal, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get idCategoria {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableAnnotationComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transaccionesRefs<T extends Object>(
      Expression<T> Function($$TransaccionesTableAnnotationComposer a) f) {
    final $$TransaccionesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transacciones,
        getReferencedColumn: (t) => t.idIngreso,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransaccionesTableAnnotationComposer(
              $db: $db,
              $table: $db.transacciones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$IngresosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IngresosTable,
    Ingreso,
    $$IngresosTableFilterComposer,
    $$IngresosTableOrderingComposer,
    $$IngresosTableAnnotationComposer,
    $$IngresosTableCreateCompanionBuilder,
    $$IngresosTableUpdateCompanionBuilder,
    (Ingreso, $$IngresosTableReferences),
    Ingreso,
    PrefetchHooks Function({bool idCategoria, bool transaccionesRefs})> {
  $$IngresosTableTableManager(_$AppDatabase db, $IngresosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngresosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngresosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngresosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> cantidadTotal = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> idCategoria = const Value.absent(),
          }) =>
              IngresosCompanion(
            id: id,
            cantidadTotal: cantidadTotal,
            fecha: fecha,
            idCategoria: idCategoria,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double cantidadTotal,
            required DateTime fecha,
            required int idCategoria,
          }) =>
              IngresosCompanion.insert(
            id: id,
            cantidadTotal: cantidadTotal,
            fecha: fecha,
            idCategoria: idCategoria,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$IngresosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {idCategoria = false, transaccionesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transaccionesRefs) db.transacciones
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idCategoria) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idCategoria,
                    referencedTable:
                        $$IngresosTableReferences._idCategoriaTable(db),
                    referencedColumn:
                        $$IngresosTableReferences._idCategoriaTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transaccionesRefs)
                    await $_getPrefetchedData<Ingreso, $IngresosTable,
                            Transaccion>(
                        currentTable: table,
                        referencedTable: $$IngresosTableReferences
                            ._transaccionesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$IngresosTableReferences(db, table, p0)
                                .transaccionesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.idIngreso == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$IngresosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IngresosTable,
    Ingreso,
    $$IngresosTableFilterComposer,
    $$IngresosTableOrderingComposer,
    $$IngresosTableAnnotationComposer,
    $$IngresosTableCreateCompanionBuilder,
    $$IngresosTableUpdateCompanionBuilder,
    (Ingreso, $$IngresosTableReferences),
    Ingreso,
    PrefetchHooks Function({bool idCategoria, bool transaccionesRefs})>;
typedef $$GastosTableCreateCompanionBuilder = GastosCompanion Function({
  Value<int> id,
  required double cantidad,
  required String concepto,
  required DateTime fecha,
  required int idCategoria,
});
typedef $$GastosTableUpdateCompanionBuilder = GastosCompanion Function({
  Value<int> id,
  Value<double> cantidad,
  Value<String> concepto,
  Value<DateTime> fecha,
  Value<int> idCategoria,
});

final class $$GastosTableReferences
    extends BaseReferences<_$AppDatabase, $GastosTable, Gasto> {
  $$GastosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _idCategoriaTable(_$AppDatabase db) =>
      db.categorias.createAlias(
          $_aliasNameGenerator(db.gastos.idCategoria, db.categorias.id));

  $$CategoriasTableProcessedTableManager get idCategoria {
    final $_column = $_itemColumn<int>('id_categoria')!;

    final manager = $$CategoriasTableTableManager($_db, $_db.categorias)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCategoriaTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TransaccionesTable, List<Transaccion>>
      _transaccionesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transacciones,
              aliasName:
                  $_aliasNameGenerator(db.gastos.id, db.transacciones.idGasto));

  $$TransaccionesTableProcessedTableManager get transaccionesRefs {
    final manager = $$TransaccionesTableTableManager($_db, $_db.transacciones)
        .filter((f) => f.idGasto.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transaccionesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GastosTableFilterComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get concepto => $composableBuilder(
      column: $table.concepto, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  $$CategoriasTableFilterComposer get idCategoria {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableFilterComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> transaccionesRefs(
      Expression<bool> Function($$TransaccionesTableFilterComposer f) f) {
    final $$TransaccionesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transacciones,
        getReferencedColumn: (t) => t.idGasto,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransaccionesTableFilterComposer(
              $db: $db,
              $table: $db.transacciones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GastosTableOrderingComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get concepto => $composableBuilder(
      column: $table.concepto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  $$CategoriasTableOrderingComposer get idCategoria {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableOrderingComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GastosTableAnnotationComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get concepto =>
      $composableBuilder(column: $table.concepto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get idCategoria {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableAnnotationComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> transaccionesRefs<T extends Object>(
      Expression<T> Function($$TransaccionesTableAnnotationComposer a) f) {
    final $$TransaccionesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transacciones,
        getReferencedColumn: (t) => t.idGasto,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransaccionesTableAnnotationComposer(
              $db: $db,
              $table: $db.transacciones,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GastosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GastosTable,
    Gasto,
    $$GastosTableFilterComposer,
    $$GastosTableOrderingComposer,
    $$GastosTableAnnotationComposer,
    $$GastosTableCreateCompanionBuilder,
    $$GastosTableUpdateCompanionBuilder,
    (Gasto, $$GastosTableReferences),
    Gasto,
    PrefetchHooks Function({bool idCategoria, bool transaccionesRefs})> {
  $$GastosTableTableManager(_$AppDatabase db, $GastosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> cantidad = const Value.absent(),
            Value<String> concepto = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> idCategoria = const Value.absent(),
          }) =>
              GastosCompanion(
            id: id,
            cantidad: cantidad,
            concepto: concepto,
            fecha: fecha,
            idCategoria: idCategoria,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double cantidad,
            required String concepto,
            required DateTime fecha,
            required int idCategoria,
          }) =>
              GastosCompanion.insert(
            id: id,
            cantidad: cantidad,
            concepto: concepto,
            fecha: fecha,
            idCategoria: idCategoria,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GastosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {idCategoria = false, transaccionesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transaccionesRefs) db.transacciones
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idCategoria) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idCategoria,
                    referencedTable:
                        $$GastosTableReferences._idCategoriaTable(db),
                    referencedColumn:
                        $$GastosTableReferences._idCategoriaTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transaccionesRefs)
                    await $_getPrefetchedData<Gasto, $GastosTable, Transaccion>(
                        currentTable: table,
                        referencedTable:
                            $$GastosTableReferences._transaccionesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GastosTableReferences(db, table, p0)
                                .transaccionesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.idGasto == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GastosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GastosTable,
    Gasto,
    $$GastosTableFilterComposer,
    $$GastosTableOrderingComposer,
    $$GastosTableAnnotationComposer,
    $$GastosTableCreateCompanionBuilder,
    $$GastosTableUpdateCompanionBuilder,
    (Gasto, $$GastosTableReferences),
    Gasto,
    PrefetchHooks Function({bool idCategoria, bool transaccionesRefs})>;
typedef $$TransaccionesTableCreateCompanionBuilder = TransaccionesCompanion
    Function({
  Value<int> id,
  required int idCuenta,
  required double cantidad,
  required TipoTransaccion tipo,
  required DateTime fecha,
  Value<int?> idGasto,
  Value<int?> idIngreso,
});
typedef $$TransaccionesTableUpdateCompanionBuilder = TransaccionesCompanion
    Function({
  Value<int> id,
  Value<int> idCuenta,
  Value<double> cantidad,
  Value<TipoTransaccion> tipo,
  Value<DateTime> fecha,
  Value<int?> idGasto,
  Value<int?> idIngreso,
});

final class $$TransaccionesTableReferences
    extends BaseReferences<_$AppDatabase, $TransaccionesTable, Transaccion> {
  $$TransaccionesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CuentasTable _idCuentaTable(_$AppDatabase db) =>
      db.cuentas.createAlias(
          $_aliasNameGenerator(db.transacciones.idCuenta, db.cuentas.id));

  $$CuentasTableProcessedTableManager get idCuenta {
    final $_column = $_itemColumn<int>('id_cuenta')!;

    final manager = $$CuentasTableTableManager($_db, $_db.cuentas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCuentaTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GastosTable _idGastoTable(_$AppDatabase db) => db.gastos.createAlias(
      $_aliasNameGenerator(db.transacciones.idGasto, db.gastos.id));

  $$GastosTableProcessedTableManager? get idGasto {
    final $_column = $_itemColumn<int>('id_gasto');
    if ($_column == null) return null;
    final manager = $$GastosTableTableManager($_db, $_db.gastos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idGastoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $IngresosTable _idIngresoTable(_$AppDatabase db) =>
      db.ingresos.createAlias(
          $_aliasNameGenerator(db.transacciones.idIngreso, db.ingresos.id));

  $$IngresosTableProcessedTableManager? get idIngreso {
    final $_column = $_itemColumn<int>('id_ingreso');
    if ($_column == null) return null;
    final manager = $$IngresosTableTableManager($_db, $_db.ingresos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idIngresoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransaccionesTableFilterComposer
    extends Composer<_$AppDatabase, $TransaccionesTable> {
  $$TransaccionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoTransaccion, TipoTransaccion, int>
      get tipo => $composableBuilder(
          column: $table.tipo,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  $$CuentasTableFilterComposer get idCuenta {
    final $$CuentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuenta,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableFilterComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GastosTableFilterComposer get idGasto {
    final $$GastosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idGasto,
        referencedTable: $db.gastos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosTableFilterComposer(
              $db: $db,
              $table: $db.gastos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IngresosTableFilterComposer get idIngreso {
    final $$IngresosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idIngreso,
        referencedTable: $db.ingresos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IngresosTableFilterComposer(
              $db: $db,
              $table: $db.ingresos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransaccionesTableOrderingComposer
    extends Composer<_$AppDatabase, $TransaccionesTable> {
  $$TransaccionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  $$CuentasTableOrderingComposer get idCuenta {
    final $$CuentasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuenta,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableOrderingComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GastosTableOrderingComposer get idGasto {
    final $$GastosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idGasto,
        referencedTable: $db.gastos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosTableOrderingComposer(
              $db: $db,
              $table: $db.gastos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IngresosTableOrderingComposer get idIngreso {
    final $$IngresosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idIngreso,
        referencedTable: $db.ingresos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IngresosTableOrderingComposer(
              $db: $db,
              $table: $db.ingresos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransaccionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransaccionesTable> {
  $$TransaccionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoTransaccion, int> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$CuentasTableAnnotationComposer get idCuenta {
    final $$CuentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuenta,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableAnnotationComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GastosTableAnnotationComposer get idGasto {
    final $$GastosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idGasto,
        referencedTable: $db.gastos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosTableAnnotationComposer(
              $db: $db,
              $table: $db.gastos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$IngresosTableAnnotationComposer get idIngreso {
    final $$IngresosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idIngreso,
        referencedTable: $db.ingresos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IngresosTableAnnotationComposer(
              $db: $db,
              $table: $db.ingresos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransaccionesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransaccionesTable,
    Transaccion,
    $$TransaccionesTableFilterComposer,
    $$TransaccionesTableOrderingComposer,
    $$TransaccionesTableAnnotationComposer,
    $$TransaccionesTableCreateCompanionBuilder,
    $$TransaccionesTableUpdateCompanionBuilder,
    (Transaccion, $$TransaccionesTableReferences),
    Transaccion,
    PrefetchHooks Function({bool idCuenta, bool idGasto, bool idIngreso})> {
  $$TransaccionesTableTableManager(_$AppDatabase db, $TransaccionesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransaccionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransaccionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransaccionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idCuenta = const Value.absent(),
            Value<double> cantidad = const Value.absent(),
            Value<TipoTransaccion> tipo = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int?> idGasto = const Value.absent(),
            Value<int?> idIngreso = const Value.absent(),
          }) =>
              TransaccionesCompanion(
            id: id,
            idCuenta: idCuenta,
            cantidad: cantidad,
            tipo: tipo,
            fecha: fecha,
            idGasto: idGasto,
            idIngreso: idIngreso,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idCuenta,
            required double cantidad,
            required TipoTransaccion tipo,
            required DateTime fecha,
            Value<int?> idGasto = const Value.absent(),
            Value<int?> idIngreso = const Value.absent(),
          }) =>
              TransaccionesCompanion.insert(
            id: id,
            idCuenta: idCuenta,
            cantidad: cantidad,
            tipo: tipo,
            fecha: fecha,
            idGasto: idGasto,
            idIngreso: idIngreso,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransaccionesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {idCuenta = false, idGasto = false, idIngreso = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idCuenta) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idCuenta,
                    referencedTable:
                        $$TransaccionesTableReferences._idCuentaTable(db),
                    referencedColumn:
                        $$TransaccionesTableReferences._idCuentaTable(db).id,
                  ) as T;
                }
                if (idGasto) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idGasto,
                    referencedTable:
                        $$TransaccionesTableReferences._idGastoTable(db),
                    referencedColumn:
                        $$TransaccionesTableReferences._idGastoTable(db).id,
                  ) as T;
                }
                if (idIngreso) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idIngreso,
                    referencedTable:
                        $$TransaccionesTableReferences._idIngresoTable(db),
                    referencedColumn:
                        $$TransaccionesTableReferences._idIngresoTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TransaccionesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransaccionesTable,
    Transaccion,
    $$TransaccionesTableFilterComposer,
    $$TransaccionesTableOrderingComposer,
    $$TransaccionesTableAnnotationComposer,
    $$TransaccionesTableCreateCompanionBuilder,
    $$TransaccionesTableUpdateCompanionBuilder,
    (Transaccion, $$TransaccionesTableReferences),
    Transaccion,
    PrefetchHooks Function({bool idCuenta, bool idGasto, bool idIngreso})>;
typedef $$TransaccionesProgramadasTableCreateCompanionBuilder
    = TransaccionesProgramadasCompanion Function({
  Value<int> id,
  required String descripcion,
  required double cantidad,
  required TipoTransaccion tipo,
  Value<int?> idCategoria,
  Value<int?> idCuentaOrigen,
  Value<int?> idCuentaDestino,
  required Frecuencia frecuencia,
  required DateTime fechaInicio,
  required DateTime proximaEjecucion,
  Value<DateTime?> fechaFin,
  Value<bool> isTransferencia,
  Value<int?> diaDelMes,
  Value<int?> diaDeLaSemana,
});
typedef $$TransaccionesProgramadasTableUpdateCompanionBuilder
    = TransaccionesProgramadasCompanion Function({
  Value<int> id,
  Value<String> descripcion,
  Value<double> cantidad,
  Value<TipoTransaccion> tipo,
  Value<int?> idCategoria,
  Value<int?> idCuentaOrigen,
  Value<int?> idCuentaDestino,
  Value<Frecuencia> frecuencia,
  Value<DateTime> fechaInicio,
  Value<DateTime> proximaEjecucion,
  Value<DateTime?> fechaFin,
  Value<bool> isTransferencia,
  Value<int?> diaDelMes,
  Value<int?> diaDeLaSemana,
});

final class $$TransaccionesProgramadasTableReferences extends BaseReferences<
    _$AppDatabase, $TransaccionesProgramadasTable, TransaccionProgramada> {
  $$TransaccionesProgramadasTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _idCategoriaTable(_$AppDatabase db) =>
      db.categorias.createAlias($_aliasNameGenerator(
          db.transaccionesProgramadas.idCategoria, db.categorias.id));

  $$CategoriasTableProcessedTableManager? get idCategoria {
    final $_column = $_itemColumn<int>('id_categoria');
    if ($_column == null) return null;
    final manager = $$CategoriasTableTableManager($_db, $_db.categorias)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCategoriaTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CuentasTable _idCuentaOrigenTable(_$AppDatabase db) =>
      db.cuentas.createAlias($_aliasNameGenerator(
          db.transaccionesProgramadas.idCuentaOrigen, db.cuentas.id));

  $$CuentasTableProcessedTableManager? get idCuentaOrigen {
    final $_column = $_itemColumn<int>('id_cuenta_origen');
    if ($_column == null) return null;
    final manager = $$CuentasTableTableManager($_db, $_db.cuentas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCuentaOrigenTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CuentasTable _idCuentaDestinoTable(_$AppDatabase db) =>
      db.cuentas.createAlias($_aliasNameGenerator(
          db.transaccionesProgramadas.idCuentaDestino, db.cuentas.id));

  $$CuentasTableProcessedTableManager? get idCuentaDestino {
    final $_column = $_itemColumn<int>('id_cuenta_destino');
    if ($_column == null) return null;
    final manager = $$CuentasTableTableManager($_db, $_db.cuentas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCuentaDestinoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransaccionesProgramadasTableFilterComposer
    extends Composer<_$AppDatabase, $TransaccionesProgramadasTable> {
  $$TransaccionesProgramadasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TipoTransaccion, TipoTransaccion, int>
      get tipo => $composableBuilder(
          column: $table.tipo,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Frecuencia, Frecuencia, int> get frecuencia =>
      $composableBuilder(
          column: $table.frecuencia,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get fechaInicio => $composableBuilder(
      column: $table.fechaInicio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get proximaEjecucion => $composableBuilder(
      column: $table.proximaEjecucion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaFin => $composableBuilder(
      column: $table.fechaFin, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTransferencia => $composableBuilder(
      column: $table.isTransferencia,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diaDelMes => $composableBuilder(
      column: $table.diaDelMes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diaDeLaSemana => $composableBuilder(
      column: $table.diaDeLaSemana, builder: (column) => ColumnFilters(column));

  $$CategoriasTableFilterComposer get idCategoria {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableFilterComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CuentasTableFilterComposer get idCuentaOrigen {
    final $$CuentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuentaOrigen,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableFilterComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CuentasTableFilterComposer get idCuentaDestino {
    final $$CuentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuentaDestino,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableFilterComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransaccionesProgramadasTableOrderingComposer
    extends Composer<_$AppDatabase, $TransaccionesProgramadasTable> {
  $$TransaccionesProgramadasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get frecuencia => $composableBuilder(
      column: $table.frecuencia, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaInicio => $composableBuilder(
      column: $table.fechaInicio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get proximaEjecucion => $composableBuilder(
      column: $table.proximaEjecucion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaFin => $composableBuilder(
      column: $table.fechaFin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTransferencia => $composableBuilder(
      column: $table.isTransferencia,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diaDelMes => $composableBuilder(
      column: $table.diaDelMes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diaDeLaSemana => $composableBuilder(
      column: $table.diaDeLaSemana,
      builder: (column) => ColumnOrderings(column));

  $$CategoriasTableOrderingComposer get idCategoria {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableOrderingComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CuentasTableOrderingComposer get idCuentaOrigen {
    final $$CuentasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuentaOrigen,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableOrderingComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CuentasTableOrderingComposer get idCuentaDestino {
    final $$CuentasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuentaDestino,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableOrderingComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransaccionesProgramadasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransaccionesProgramadasTable> {
  $$TransaccionesProgramadasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoTransaccion, int> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Frecuencia, int> get frecuencia =>
      $composableBuilder(
          column: $table.frecuencia, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaInicio => $composableBuilder(
      column: $table.fechaInicio, builder: (column) => column);

  GeneratedColumn<DateTime> get proximaEjecucion => $composableBuilder(
      column: $table.proximaEjecucion, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaFin =>
      $composableBuilder(column: $table.fechaFin, builder: (column) => column);

  GeneratedColumn<bool> get isTransferencia => $composableBuilder(
      column: $table.isTransferencia, builder: (column) => column);

  GeneratedColumn<int> get diaDelMes =>
      $composableBuilder(column: $table.diaDelMes, builder: (column) => column);

  GeneratedColumn<int> get diaDeLaSemana => $composableBuilder(
      column: $table.diaDeLaSemana, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get idCategoria {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCategoria,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableAnnotationComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CuentasTableAnnotationComposer get idCuentaOrigen {
    final $$CuentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuentaOrigen,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableAnnotationComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CuentasTableAnnotationComposer get idCuentaDestino {
    final $$CuentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCuentaDestino,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableAnnotationComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransaccionesProgramadasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransaccionesProgramadasTable,
    TransaccionProgramada,
    $$TransaccionesProgramadasTableFilterComposer,
    $$TransaccionesProgramadasTableOrderingComposer,
    $$TransaccionesProgramadasTableAnnotationComposer,
    $$TransaccionesProgramadasTableCreateCompanionBuilder,
    $$TransaccionesProgramadasTableUpdateCompanionBuilder,
    (TransaccionProgramada, $$TransaccionesProgramadasTableReferences),
    TransaccionProgramada,
    PrefetchHooks Function(
        {bool idCategoria, bool idCuentaOrigen, bool idCuentaDestino})> {
  $$TransaccionesProgramadasTableTableManager(
      _$AppDatabase db, $TransaccionesProgramadasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransaccionesProgramadasTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TransaccionesProgramadasTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransaccionesProgramadasTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<double> cantidad = const Value.absent(),
            Value<TipoTransaccion> tipo = const Value.absent(),
            Value<int?> idCategoria = const Value.absent(),
            Value<int?> idCuentaOrigen = const Value.absent(),
            Value<int?> idCuentaDestino = const Value.absent(),
            Value<Frecuencia> frecuencia = const Value.absent(),
            Value<DateTime> fechaInicio = const Value.absent(),
            Value<DateTime> proximaEjecucion = const Value.absent(),
            Value<DateTime?> fechaFin = const Value.absent(),
            Value<bool> isTransferencia = const Value.absent(),
            Value<int?> diaDelMes = const Value.absent(),
            Value<int?> diaDeLaSemana = const Value.absent(),
          }) =>
              TransaccionesProgramadasCompanion(
            id: id,
            descripcion: descripcion,
            cantidad: cantidad,
            tipo: tipo,
            idCategoria: idCategoria,
            idCuentaOrigen: idCuentaOrigen,
            idCuentaDestino: idCuentaDestino,
            frecuencia: frecuencia,
            fechaInicio: fechaInicio,
            proximaEjecucion: proximaEjecucion,
            fechaFin: fechaFin,
            isTransferencia: isTransferencia,
            diaDelMes: diaDelMes,
            diaDeLaSemana: diaDeLaSemana,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String descripcion,
            required double cantidad,
            required TipoTransaccion tipo,
            Value<int?> idCategoria = const Value.absent(),
            Value<int?> idCuentaOrigen = const Value.absent(),
            Value<int?> idCuentaDestino = const Value.absent(),
            required Frecuencia frecuencia,
            required DateTime fechaInicio,
            required DateTime proximaEjecucion,
            Value<DateTime?> fechaFin = const Value.absent(),
            Value<bool> isTransferencia = const Value.absent(),
            Value<int?> diaDelMes = const Value.absent(),
            Value<int?> diaDeLaSemana = const Value.absent(),
          }) =>
              TransaccionesProgramadasCompanion.insert(
            id: id,
            descripcion: descripcion,
            cantidad: cantidad,
            tipo: tipo,
            idCategoria: idCategoria,
            idCuentaOrigen: idCuentaOrigen,
            idCuentaDestino: idCuentaDestino,
            frecuencia: frecuencia,
            fechaInicio: fechaInicio,
            proximaEjecucion: proximaEjecucion,
            fechaFin: fechaFin,
            isTransferencia: isTransferencia,
            diaDelMes: diaDelMes,
            diaDeLaSemana: diaDeLaSemana,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransaccionesProgramadasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {idCategoria = false,
              idCuentaOrigen = false,
              idCuentaDestino = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (idCategoria) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idCategoria,
                    referencedTable: $$TransaccionesProgramadasTableReferences
                        ._idCategoriaTable(db),
                    referencedColumn: $$TransaccionesProgramadasTableReferences
                        ._idCategoriaTable(db)
                        .id,
                  ) as T;
                }
                if (idCuentaOrigen) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idCuentaOrigen,
                    referencedTable: $$TransaccionesProgramadasTableReferences
                        ._idCuentaOrigenTable(db),
                    referencedColumn: $$TransaccionesProgramadasTableReferences
                        ._idCuentaOrigenTable(db)
                        .id,
                  ) as T;
                }
                if (idCuentaDestino) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idCuentaDestino,
                    referencedTable: $$TransaccionesProgramadasTableReferences
                        ._idCuentaDestinoTable(db),
                    referencedColumn: $$TransaccionesProgramadasTableReferences
                        ._idCuentaDestinoTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TransaccionesProgramadasTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $TransaccionesProgramadasTable,
        TransaccionProgramada,
        $$TransaccionesProgramadasTableFilterComposer,
        $$TransaccionesProgramadasTableOrderingComposer,
        $$TransaccionesProgramadasTableAnnotationComposer,
        $$TransaccionesProgramadasTableCreateCompanionBuilder,
        $$TransaccionesProgramadasTableUpdateCompanionBuilder,
        (TransaccionProgramada, $$TransaccionesProgramadasTableReferences),
        TransaccionProgramada,
        PrefetchHooks Function(
            {bool idCategoria, bool idCuentaOrigen, bool idCuentaDestino})>;
typedef $$CreditosTableCreateCompanionBuilder = CreditosCompanion Function({
  Value<int> id,
  required String name,
  required CreditType creditType,
  required double totalAmount,
  required double remainingAmount,
  required double paymentAmount,
  required double interestRate,
  required int paymentDay,
  required int linkedAccountId,
  required DateTime createdAt,
  Value<DateTime?> lastPaymentDate,
  Value<int> plazoEnMeses,
  Value<double?> comisionAmortizacionParcial,
  Value<double?> comisionCancelacionTotal,
});
typedef $$CreditosTableUpdateCompanionBuilder = CreditosCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<CreditType> creditType,
  Value<double> totalAmount,
  Value<double> remainingAmount,
  Value<double> paymentAmount,
  Value<double> interestRate,
  Value<int> paymentDay,
  Value<int> linkedAccountId,
  Value<DateTime> createdAt,
  Value<DateTime?> lastPaymentDate,
  Value<int> plazoEnMeses,
  Value<double?> comisionAmortizacionParcial,
  Value<double?> comisionCancelacionTotal,
});

final class $$CreditosTableReferences
    extends BaseReferences<_$AppDatabase, $CreditosTable, Credito> {
  $$CreditosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CuentasTable _linkedAccountIdTable(_$AppDatabase db) =>
      db.cuentas.createAlias(
          $_aliasNameGenerator(db.creditos.linkedAccountId, db.cuentas.id));

  $$CuentasTableProcessedTableManager get linkedAccountId {
    final $_column = $_itemColumn<int>('linked_account_id')!;

    final manager = $$CuentasTableTableManager($_db, $_db.cuentas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CreditosTableFilterComposer
    extends Composer<_$AppDatabase, $CreditosTable> {
  $$CreditosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CreditType, CreditType, int> get creditType =>
      $composableBuilder(
          column: $table.creditType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get remainingAmount => $composableBuilder(
      column: $table.remainingAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get paymentAmount => $composableBuilder(
      column: $table.paymentAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentDay => $composableBuilder(
      column: $table.paymentDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastPaymentDate => $composableBuilder(
      column: $table.lastPaymentDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get plazoEnMeses => $composableBuilder(
      column: $table.plazoEnMeses, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get comisionAmortizacionParcial => $composableBuilder(
      column: $table.comisionAmortizacionParcial,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get comisionCancelacionTotal => $composableBuilder(
      column: $table.comisionCancelacionTotal,
      builder: (column) => ColumnFilters(column));

  $$CuentasTableFilterComposer get linkedAccountId {
    final $$CuentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.linkedAccountId,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableFilterComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditosTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditosTable> {
  $$CreditosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get creditType => $composableBuilder(
      column: $table.creditType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get remainingAmount => $composableBuilder(
      column: $table.remainingAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get paymentAmount => $composableBuilder(
      column: $table.paymentAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get interestRate => $composableBuilder(
      column: $table.interestRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentDay => $composableBuilder(
      column: $table.paymentDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastPaymentDate => $composableBuilder(
      column: $table.lastPaymentDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get plazoEnMeses => $composableBuilder(
      column: $table.plazoEnMeses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get comisionAmortizacionParcial => $composableBuilder(
      column: $table.comisionAmortizacionParcial,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get comisionCancelacionTotal => $composableBuilder(
      column: $table.comisionCancelacionTotal,
      builder: (column) => ColumnOrderings(column));

  $$CuentasTableOrderingComposer get linkedAccountId {
    final $$CuentasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.linkedAccountId,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableOrderingComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditosTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditosTable> {
  $$CreditosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CreditType, int> get creditType =>
      $composableBuilder(
          column: $table.creditType, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<double> get remainingAmount => $composableBuilder(
      column: $table.remainingAmount, builder: (column) => column);

  GeneratedColumn<double> get paymentAmount => $composableBuilder(
      column: $table.paymentAmount, builder: (column) => column);

  GeneratedColumn<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => column);

  GeneratedColumn<int> get paymentDay => $composableBuilder(
      column: $table.paymentDay, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPaymentDate => $composableBuilder(
      column: $table.lastPaymentDate, builder: (column) => column);

  GeneratedColumn<int> get plazoEnMeses => $composableBuilder(
      column: $table.plazoEnMeses, builder: (column) => column);

  GeneratedColumn<double> get comisionAmortizacionParcial => $composableBuilder(
      column: $table.comisionAmortizacionParcial, builder: (column) => column);

  GeneratedColumn<double> get comisionCancelacionTotal => $composableBuilder(
      column: $table.comisionCancelacionTotal, builder: (column) => column);

  $$CuentasTableAnnotationComposer get linkedAccountId {
    final $$CuentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.linkedAccountId,
        referencedTable: $db.cuentas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CuentasTableAnnotationComposer(
              $db: $db,
              $table: $db.cuentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CreditosTable,
    Credito,
    $$CreditosTableFilterComposer,
    $$CreditosTableOrderingComposer,
    $$CreditosTableAnnotationComposer,
    $$CreditosTableCreateCompanionBuilder,
    $$CreditosTableUpdateCompanionBuilder,
    (Credito, $$CreditosTableReferences),
    Credito,
    PrefetchHooks Function({bool linkedAccountId})> {
  $$CreditosTableTableManager(_$AppDatabase db, $CreditosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<CreditType> creditType = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<double> remainingAmount = const Value.absent(),
            Value<double> paymentAmount = const Value.absent(),
            Value<double> interestRate = const Value.absent(),
            Value<int> paymentDay = const Value.absent(),
            Value<int> linkedAccountId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastPaymentDate = const Value.absent(),
            Value<int> plazoEnMeses = const Value.absent(),
            Value<double?> comisionAmortizacionParcial = const Value.absent(),
            Value<double?> comisionCancelacionTotal = const Value.absent(),
          }) =>
              CreditosCompanion(
            id: id,
            name: name,
            creditType: creditType,
            totalAmount: totalAmount,
            remainingAmount: remainingAmount,
            paymentAmount: paymentAmount,
            interestRate: interestRate,
            paymentDay: paymentDay,
            linkedAccountId: linkedAccountId,
            createdAt: createdAt,
            lastPaymentDate: lastPaymentDate,
            plazoEnMeses: plazoEnMeses,
            comisionAmortizacionParcial: comisionAmortizacionParcial,
            comisionCancelacionTotal: comisionCancelacionTotal,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required CreditType creditType,
            required double totalAmount,
            required double remainingAmount,
            required double paymentAmount,
            required double interestRate,
            required int paymentDay,
            required int linkedAccountId,
            required DateTime createdAt,
            Value<DateTime?> lastPaymentDate = const Value.absent(),
            Value<int> plazoEnMeses = const Value.absent(),
            Value<double?> comisionAmortizacionParcial = const Value.absent(),
            Value<double?> comisionCancelacionTotal = const Value.absent(),
          }) =>
              CreditosCompanion.insert(
            id: id,
            name: name,
            creditType: creditType,
            totalAmount: totalAmount,
            remainingAmount: remainingAmount,
            paymentAmount: paymentAmount,
            interestRate: interestRate,
            paymentDay: paymentDay,
            linkedAccountId: linkedAccountId,
            createdAt: createdAt,
            lastPaymentDate: lastPaymentDate,
            plazoEnMeses: plazoEnMeses,
            comisionAmortizacionParcial: comisionAmortizacionParcial,
            comisionCancelacionTotal: comisionCancelacionTotal,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CreditosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({linkedAccountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (linkedAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.linkedAccountId,
                    referencedTable:
                        $$CreditosTableReferences._linkedAccountIdTable(db),
                    referencedColumn:
                        $$CreditosTableReferences._linkedAccountIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CreditosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CreditosTable,
    Credito,
    $$CreditosTableFilterComposer,
    $$CreditosTableOrderingComposer,
    $$CreditosTableAnnotationComposer,
    $$CreditosTableCreateCompanionBuilder,
    $$CreditosTableUpdateCompanionBuilder,
    (Credito, $$CreditosTableReferences),
    Credito,
    PrefetchHooks Function({bool linkedAccountId})>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<String> currency,
  Value<bool> showBudgetLimit,
  Value<bool> showMaxBalance,
  Value<bool> showMonthlySpending,
  Value<bool> showProjection,
  Value<DateTime?> lastResetDate,
  Value<bool> monityControlEnabled,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<String> currency,
  Value<bool> showBudgetLimit,
  Value<bool> showMaxBalance,
  Value<bool> showMonthlySpending,
  Value<bool> showProjection,
  Value<DateTime?> lastResetDate,
  Value<bool> monityControlEnabled,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showBudgetLimit => $composableBuilder(
      column: $table.showBudgetLimit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showMaxBalance => $composableBuilder(
      column: $table.showMaxBalance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showMonthlySpending => $composableBuilder(
      column: $table.showMonthlySpending,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get showProjection => $composableBuilder(
      column: $table.showProjection,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastResetDate => $composableBuilder(
      column: $table.lastResetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get monityControlEnabled => $composableBuilder(
      column: $table.monityControlEnabled,
      builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showBudgetLimit => $composableBuilder(
      column: $table.showBudgetLimit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showMaxBalance => $composableBuilder(
      column: $table.showMaxBalance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showMonthlySpending => $composableBuilder(
      column: $table.showMonthlySpending,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get showProjection => $composableBuilder(
      column: $table.showProjection,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastResetDate => $composableBuilder(
      column: $table.lastResetDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get monityControlEnabled => $composableBuilder(
      column: $table.monityControlEnabled,
      builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<bool> get showBudgetLimit => $composableBuilder(
      column: $table.showBudgetLimit, builder: (column) => column);

  GeneratedColumn<bool> get showMaxBalance => $composableBuilder(
      column: $table.showMaxBalance, builder: (column) => column);

  GeneratedColumn<bool> get showMonthlySpending => $composableBuilder(
      column: $table.showMonthlySpending, builder: (column) => column);

  GeneratedColumn<bool> get showProjection => $composableBuilder(
      column: $table.showProjection, builder: (column) => column);

  GeneratedColumn<DateTime> get lastResetDate => $composableBuilder(
      column: $table.lastResetDate, builder: (column) => column);

  GeneratedColumn<bool> get monityControlEnabled => $composableBuilder(
      column: $table.monityControlEnabled, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<bool> showBudgetLimit = const Value.absent(),
            Value<bool> showMaxBalance = const Value.absent(),
            Value<bool> showMonthlySpending = const Value.absent(),
            Value<bool> showProjection = const Value.absent(),
            Value<DateTime?> lastResetDate = const Value.absent(),
            Value<bool> monityControlEnabled = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            id: id,
            currency: currency,
            showBudgetLimit: showBudgetLimit,
            showMaxBalance: showMaxBalance,
            showMonthlySpending: showMonthlySpending,
            showProjection: showProjection,
            lastResetDate: lastResetDate,
            monityControlEnabled: monityControlEnabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<bool> showBudgetLimit = const Value.absent(),
            Value<bool> showMaxBalance = const Value.absent(),
            Value<bool> showMonthlySpending = const Value.absent(),
            Value<bool> showProjection = const Value.absent(),
            Value<DateTime?> lastResetDate = const Value.absent(),
            Value<bool> monityControlEnabled = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            id: id,
            currency: currency,
            showBudgetLimit: showBudgetLimit,
            showMaxBalance: showMaxBalance,
            showMonthlySpending: showMonthlySpending,
            showProjection: showProjection,
            lastResetDate: lastResetDate,
            monityControlEnabled: monityControlEnabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()>;
typedef $$QuotesTableCreateCompanionBuilder = QuotesCompanion Function({
  Value<int> id,
  required String quoteText,
  Value<bool> isUsed,
});
typedef $$QuotesTableUpdateCompanionBuilder = QuotesCompanion Function({
  Value<int> id,
  Value<String> quoteText,
  Value<bool> isUsed,
});

class $$QuotesTableFilterComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quoteText => $composableBuilder(
      column: $table.quoteText, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUsed => $composableBuilder(
      column: $table.isUsed, builder: (column) => ColumnFilters(column));
}

class $$QuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quoteText => $composableBuilder(
      column: $table.quoteText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUsed => $composableBuilder(
      column: $table.isUsed, builder: (column) => ColumnOrderings(column));
}

class $$QuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get quoteText =>
      $composableBuilder(column: $table.quoteText, builder: (column) => column);

  GeneratedColumn<bool> get isUsed =>
      $composableBuilder(column: $table.isUsed, builder: (column) => column);
}

class $$QuotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuotesTable,
    Quote,
    $$QuotesTableFilterComposer,
    $$QuotesTableOrderingComposer,
    $$QuotesTableAnnotationComposer,
    $$QuotesTableCreateCompanionBuilder,
    $$QuotesTableUpdateCompanionBuilder,
    (Quote, BaseReferences<_$AppDatabase, $QuotesTable, Quote>),
    Quote,
    PrefetchHooks Function()> {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> quoteText = const Value.absent(),
            Value<bool> isUsed = const Value.absent(),
          }) =>
              QuotesCompanion(
            id: id,
            quoteText: quoteText,
            isUsed: isUsed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String quoteText,
            Value<bool> isUsed = const Value.absent(),
          }) =>
              QuotesCompanion.insert(
            id: id,
            quoteText: quoteText,
            isUsed: isUsed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuotesTable,
    Quote,
    $$QuotesTableFilterComposer,
    $$QuotesTableOrderingComposer,
    $$QuotesTableAnnotationComposer,
    $$QuotesTableCreateCompanionBuilder,
    $$QuotesTableUpdateCompanionBuilder,
    (Quote, BaseReferences<_$AppDatabase, $QuotesTable, Quote>),
    Quote,
    PrefetchHooks Function()>;
typedef $$HistorialSaldosTableCreateCompanionBuilder = HistorialSaldosCompanion
    Function({
  Value<int> id,
  required DateTime fecha,
  required double saldo,
});
typedef $$HistorialSaldosTableUpdateCompanionBuilder = HistorialSaldosCompanion
    Function({
  Value<int> id,
  Value<DateTime> fecha,
  Value<double> saldo,
});

class $$HistorialSaldosTableFilterComposer
    extends Composer<_$AppDatabase, $HistorialSaldosTable> {
  $$HistorialSaldosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get saldo => $composableBuilder(
      column: $table.saldo, builder: (column) => ColumnFilters(column));
}

class $$HistorialSaldosTableOrderingComposer
    extends Composer<_$AppDatabase, $HistorialSaldosTable> {
  $$HistorialSaldosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get saldo => $composableBuilder(
      column: $table.saldo, builder: (column) => ColumnOrderings(column));
}

class $$HistorialSaldosTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistorialSaldosTable> {
  $$HistorialSaldosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<double> get saldo =>
      $composableBuilder(column: $table.saldo, builder: (column) => column);
}

class $$HistorialSaldosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistorialSaldosTable,
    HistorialSaldo,
    $$HistorialSaldosTableFilterComposer,
    $$HistorialSaldosTableOrderingComposer,
    $$HistorialSaldosTableAnnotationComposer,
    $$HistorialSaldosTableCreateCompanionBuilder,
    $$HistorialSaldosTableUpdateCompanionBuilder,
    (
      HistorialSaldo,
      BaseReferences<_$AppDatabase, $HistorialSaldosTable, HistorialSaldo>
    ),
    HistorialSaldo,
    PrefetchHooks Function()> {
  $$HistorialSaldosTableTableManager(
      _$AppDatabase db, $HistorialSaldosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistorialSaldosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistorialSaldosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistorialSaldosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<double> saldo = const Value.absent(),
          }) =>
              HistorialSaldosCompanion(
            id: id,
            fecha: fecha,
            saldo: saldo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime fecha,
            required double saldo,
          }) =>
              HistorialSaldosCompanion.insert(
            id: id,
            fecha: fecha,
            saldo: saldo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistorialSaldosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistorialSaldosTable,
    HistorialSaldo,
    $$HistorialSaldosTableFilterComposer,
    $$HistorialSaldosTableOrderingComposer,
    $$HistorialSaldosTableAnnotationComposer,
    $$HistorialSaldosTableCreateCompanionBuilder,
    $$HistorialSaldosTableUpdateCompanionBuilder,
    (
      HistorialSaldo,
      BaseReferences<_$AppDatabase, $HistorialSaldosTable, HistorialSaldo>
    ),
    HistorialSaldo,
    PrefetchHooks Function()>;
typedef $$PremiosTableCreateCompanionBuilder = PremiosCompanion Function({
  Value<int> id,
  required String nombre,
  required double importe,
  Value<double> acumulado,
  required String fotoPath,
  Value<bool> isCompleted,
});
typedef $$PremiosTableUpdateCompanionBuilder = PremiosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<double> importe,
  Value<double> acumulado,
  Value<String> fotoPath,
  Value<bool> isCompleted,
});

class $$PremiosTableFilterComposer
    extends Composer<_$AppDatabase, $PremiosTable> {
  $$PremiosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get importe => $composableBuilder(
      column: $table.importe, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get acumulado => $composableBuilder(
      column: $table.acumulado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotoPath => $composableBuilder(
      column: $table.fotoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));
}

class $$PremiosTableOrderingComposer
    extends Composer<_$AppDatabase, $PremiosTable> {
  $$PremiosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get importe => $composableBuilder(
      column: $table.importe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get acumulado => $composableBuilder(
      column: $table.acumulado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotoPath => $composableBuilder(
      column: $table.fotoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));
}

class $$PremiosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PremiosTable> {
  $$PremiosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get importe =>
      $composableBuilder(column: $table.importe, builder: (column) => column);

  GeneratedColumn<double> get acumulado =>
      $composableBuilder(column: $table.acumulado, builder: (column) => column);

  GeneratedColumn<String> get fotoPath =>
      $composableBuilder(column: $table.fotoPath, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);
}

class $$PremiosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PremiosTable,
    Premio,
    $$PremiosTableFilterComposer,
    $$PremiosTableOrderingComposer,
    $$PremiosTableAnnotationComposer,
    $$PremiosTableCreateCompanionBuilder,
    $$PremiosTableUpdateCompanionBuilder,
    (Premio, BaseReferences<_$AppDatabase, $PremiosTable, Premio>),
    Premio,
    PrefetchHooks Function()> {
  $$PremiosTableTableManager(_$AppDatabase db, $PremiosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PremiosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PremiosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PremiosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<double> importe = const Value.absent(),
            Value<double> acumulado = const Value.absent(),
            Value<String> fotoPath = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              PremiosCompanion(
            id: id,
            nombre: nombre,
            importe: importe,
            acumulado: acumulado,
            fotoPath: fotoPath,
            isCompleted: isCompleted,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required double importe,
            Value<double> acumulado = const Value.absent(),
            required String fotoPath,
            Value<bool> isCompleted = const Value.absent(),
          }) =>
              PremiosCompanion.insert(
            id: id,
            nombre: nombre,
            importe: importe,
            acumulado: acumulado,
            fotoPath: fotoPath,
            isCompleted: isCompleted,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PremiosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PremiosTable,
    Premio,
    $$PremiosTableFilterComposer,
    $$PremiosTableOrderingComposer,
    $$PremiosTableAnnotationComposer,
    $$PremiosTableCreateCompanionBuilder,
    $$PremiosTableUpdateCompanionBuilder,
    (Premio, BaseReferences<_$AppDatabase, $PremiosTable, Premio>),
    Premio,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CuentasTableTableManager get cuentas =>
      $$CuentasTableTableManager(_db, _db.cuentas);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$IngresosTableTableManager get ingresos =>
      $$IngresosTableTableManager(_db, _db.ingresos);
  $$GastosTableTableManager get gastos =>
      $$GastosTableTableManager(_db, _db.gastos);
  $$TransaccionesTableTableManager get transacciones =>
      $$TransaccionesTableTableManager(_db, _db.transacciones);
  $$TransaccionesProgramadasTableTableManager get transaccionesProgramadas =>
      $$TransaccionesProgramadasTableTableManager(
          _db, _db.transaccionesProgramadas);
  $$CreditosTableTableManager get creditos =>
      $$CreditosTableTableManager(_db, _db.creditos);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$QuotesTableTableManager get quotes =>
      $$QuotesTableTableManager(_db, _db.quotes);
  $$HistorialSaldosTableTableManager get historialSaldos =>
      $$HistorialSaldosTableTableManager(_db, _db.historialSaldos);
  $$PremiosTableTableManager get premios =>
      $$PremiosTableTableManager(_db, _db.premios);
}

mixin _$CuentasDaoMixin on DatabaseAccessor<AppDatabase> {
  $CuentasTable get cuentas => attachedDatabase.cuentas;
}
mixin _$CategoriasDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriasTable get categorias => attachedDatabase.categorias;
}
mixin _$IngresosDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriasTable get categorias => attachedDatabase.categorias;
  $IngresosTable get ingresos => attachedDatabase.ingresos;
}
mixin _$GastosDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriasTable get categorias => attachedDatabase.categorias;
  $GastosTable get gastos => attachedDatabase.gastos;
}
mixin _$TransaccionesDaoMixin on DatabaseAccessor<AppDatabase> {
  $CuentasTable get cuentas => attachedDatabase.cuentas;
  $CategoriasTable get categorias => attachedDatabase.categorias;
  $GastosTable get gastos => attachedDatabase.gastos;
  $IngresosTable get ingresos => attachedDatabase.ingresos;
  $TransaccionesTable get transacciones => attachedDatabase.transacciones;
}
mixin _$TransaccionesProgramadasDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriasTable get categorias => attachedDatabase.categorias;
  $CuentasTable get cuentas => attachedDatabase.cuentas;
  $TransaccionesProgramadasTable get transaccionesProgramadas =>
      attachedDatabase.transaccionesProgramadas;
}
mixin _$CreditosDaoMixin on DatabaseAccessor<AppDatabase> {
  $CuentasTable get cuentas => attachedDatabase.cuentas;
  $CreditosTable get creditos => attachedDatabase.creditos;
}
mixin _$AppSettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
}
mixin _$QuotesDaoMixin on DatabaseAccessor<AppDatabase> {
  $QuotesTable get quotes => attachedDatabase.quotes;
}
mixin _$HistorialSaldosDaoMixin on DatabaseAccessor<AppDatabase> {
  $HistorialSaldosTable get historialSaldos => attachedDatabase.historialSaldos;
}
mixin _$PremiosDaoMixin on DatabaseAccessor<AppDatabase> {
  $PremiosTable get premios => attachedDatabase.premios;
}
