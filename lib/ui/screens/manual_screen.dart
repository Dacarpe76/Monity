import 'package:flutter/material.dart';

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual de Usuario'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manual de usuario: Monity - Tu aplicación de finanzas personales',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '¡Bienvenido al manual de usuario de Monity!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'El objetivo de este manual es ayudarte a entender y dominar Monity para que puedas optimizar tus finanzas personales, aprovechando al máximo su innovador sistema de gestión de cuentas en cascada. Aprenderás a configurar tus cuentas, a comprender cómo el flujo de dinero automático potencia tu ahorro y a interpretar la información visual para tomar el control de tu economía.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Aquí aprenderás a sacar el máximo partido a todas sus funcionalidades para gestionar tu dinero de forma sencilla y eficiente.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              '1. La pantalla principal: Tus cuentas de un vistazo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'La pantalla principal es el corazón de la aplicación. Aquí verás el estado de tus finanzas en tiempo real, distribuidas en 5 cuentas que funcionan como un sistema interconectado.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '(Imagen: Vista general de la pantalla principal con las 5 cuentas.)',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 24),
            Text(
              '2. Configuración de tus cuentas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Para establecer los valores clave de cada una de tus 5 cuentas, debes ir a la pantalla de Configuración.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'En la parte superior de la pantalla principal, verás varios iconos. El icono que te da acceso a la configuración es un engranaje (⚙️). Pulsa sobre él y serás redirigido a la sección donde puedes ajustar los parámetros de tus cuentas. Aquí también podrás alterar el orden en que aparecen tus cuentas, lo cual es fundamental para el funcionamiento en cascada.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Cada cuenta se configura con dos valores importantes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Máximo de ingreso mensual: Este es el límite de dinero que una cuenta puede recibir en un mes. Si se ingresa más de este valor, el excedente se transferirá automáticamente a la siguiente cuenta en el orden de la cascada.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Cómo cuantificarlo:',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 4),
            Text(
              '•   Bolsillo: Se puede calcular sumando tus gastos diarios estimados más otros gastos variables (por ejemplo, 2€ diarios extra para caprichos y dos depósitos de gasolina de 80€ cada uno, el total sería 2€ * 30 días + 160€ = 60€ + 160€ = 220€, redondeado a 300€ para simplificar). Otra forma es basarse en los gastos medios de los últimos meses y añadir 100€ de margen.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Diario: Si tu objetivo de gasto es 700€, el máximo de ingreso podría ser de 800€, dejando un margen de 100€.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Imprevistos: El límite máximo de ingreso debe ser el valor más alto entre tus gastos de 6 meses o tus ingresos de 3 meses.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Emergencias: El máximo de ingreso en esta cuenta podría ser el costo de un gasto grande e infrecuente, como el valor de un coche nuevo si tuvieras que reemplazarlo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Ahorro: Puedes configurarlo con un límite muy alto o sin límite, ya que esta cuenta está destinada al ahorro puro o la inversión.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Objetivo de gasto mensual: Este es el monto que te propones no superar en gastos cada mes para esa cuenta específica. Es importante destacar que la visualización de los colores de la cuenta (verde, azul, rojo) se basa en este objetivo de gasto, y no en el máximo de ingreso.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Cómo cuantificarlo:',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 4),
            Text(
              '•   Bolsillo: Aunque tu máximo de ingreso sea de 300€, tu objetivo de gasto podría ser 200€ si buscas gastar solo lo necesario en caprichos. Los colores indicarán tu progreso respecto a esos 200€.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Diario: Si tus gastos normales son 600€, podrías establecer un objetivo de gasto de 700€, dejando un margen de 100€.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Imprevistos: Un objetivo de gasto bajo, como 100€, para indicar que cualquier gasto en esta categoría debe ser una excepción.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              '3. Cómo funcionan las cuentas?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Tus cuentas funcionan de forma automatizada, como si fuera una "fuente en cascada". Esto significa que el dinero fluye de una cuenta a otra de forma ordenada, según las reglas que has establecido en la sección de "Configuración". Es crucial tener en cuenta que el orden de estas cuentas es muy importante, ya que el excedente de ingresos siempre se dirige a la siguiente cuenta en la secuencia.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Reglas de las cuentas:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '•   Límite de ingresos mensual: Cada cuenta tiene un límite máximo de ingresos. Si se ingresa más de este valor, el excedente pasará automáticamente a la siguiente cuenta de la lista. Esta "cascada" continúa hasta que todo el dinero se distribuya.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Objetivo de gasto mensual: Este valor es clave para la visualización. Te ayuda a controlar tus gastos y a saber si te estás acercando a tu meta.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Descripción de las cuentas:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Monity te ofrece 5 cuentas predefinidas, cada una diseñada para un propósito específico, facilitando así una gestión financiera organizada:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Bolsillo: Destinada a tus gastos diarios o caprichos. Incluye, por ejemplo, los cafés, salidas nocturnas, la compra del periódico, etc. (Ejemplo: Máximo ingreso 300€, Objetivo de gasto 200€)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Diario: Para los gastos recurrentes y esenciales del hogar, como la factura de la luz, el agua, la compra de alimentos, el teléfono, etc. (Ejemplo: Objetivo de gasto 700€, Límite de ingreso 800€)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Imprevistos: Un fondo para gastos inesperados pero manejables, como una multa, un impuesto no planificado o una pequeña reparación en casa o del coche. (Ejemplo: Objetivo de gasto 100€, Límite de ingreso: el mayor entre 6 meses de gastos o 3 meses de ingresos)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Emergencias: Pensada para gastos de mayor envergadura y menos frecuentes, como el cambio de una caldera, la compra de un coche o una reparación importante. (Ejemplo: Máximo de ingreso el valor de un coche nuevo)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Ahorro: Esta cuenta es para el dinero que deseas invertir o destinar a un ahorro puro a largo plazo. (Ejemplo: Sin límites o límites muy altos)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              '3.1. Monity: Tu motor de ahorro',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'La verdadera potencia de Monity para ayudarte a ahorrar reside en su sistema de cascada y en la forma en que tus cuentas están configuradas y ordenadas. Al establecer límites de ingresos para tus cuentas de gasto (Bolsillo, Diario, Imprevistos, Emergencias), te aseguras de que cualquier ingreso que supere estas necesidades prioritarias no se quede inactivo, sino que se dirija automáticamente a las siguientes cuentas, hasta llegar a tu cuenta de Ahorro.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Esto significa que:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '•   Ahorro automático: No necesitas recordar transferir dinero al ahorro. Monity lo hace por ti una vez que tus otras cuentas han alcanzado sus límites de ingreso.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Priorización inteligente: Tu dinero se distribuye primero para cubrir tus necesidades diarias y gastos inesperados, y el excedente se destina de forma natural al crecimiento de tus ahorros.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Evita el sobregasto: Al tener límites claros, es menos probable que gastes más de lo necesario en una categoría, liberando fondos para tus objetivos a largo plazo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'De esta forma, Monity convierte la gestión de tus ingresos en un proceso eficiente que potencia tu capacidad de ahorro sin esfuerzo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              '4. Colores que te guían',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Los colores de la pantalla principal te dan una señal visual instantánea de tu situación financiera.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Colores del texto de las cuentas:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '•   🟢 Verde: ¡Vas por buen camino! Estás gastando menos del 80 % de tu objetivo mensual.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   🔵 Azul: Presta atención. Estás gastando entre el 80 % y el 100 % de tu objetivo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   🔴 Rojo: ¡Alerta! Has superado el 100 % de tu objetivo de gasto para el mes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Proyeccion del gasto a fin de mes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'El color de Proyeccion a fin de mes te da una proyección de cómo terminarás el mes si mantienes tu ritmo de gasto actual.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   🟢 Fondo Verde: La proyección indica que terminarás el mes habiendo gastado menos del 80 % de tu objetivo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   🔵 Fondo Azul: La proyección indica que tu gasto total estará entre el 80 % y el 100 % de tu objetivo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   🔴 Fondo Rojo: ¡Cuidado! La proyección indica que superarás tu objetivo de gasto para el mes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              '5. Realizar movimientos: Ingresos y gastos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Añadir dinero o registrar un gasto es muy sencillo. Desde la pantalla principal, encontrarás dos botones muy claros:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '•   Botón verde: Pulsa este botón para registrar un ingreso.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Botón rojo: Pulsa este botón para registrar un gasto.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Al seleccionar cualquiera de los dos, se abrirá una pantalla donde tendrás que introducir la información del movimiento.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Información necesaria para los movimientos:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '•   Para los ingresos: Deberás especificar la fecha, la cantidad, la categoría y la cuenta de destino del dinero.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Para los gastos: Deberás introducir la fecha, la cantidad, el concepto, la categoría y la cuenta de origen del gasto.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              '6. Historial de movimientos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Si quieres ver el detalle de todos los ingresos y gastos de una cuenta específica, solo tienes que pulsar sobre el nombre de la cuenta en la pantalla principal. Esto te llevará a una nueva pantalla con el historial completo de sus movimientos.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              '7. Menú principal: Iconos de la parte superior',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'En la parte superior de la pantalla principal, encontrarás cuatro iconos que te dan acceso rápido a las funciones más importantes de la aplicación:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '•   Manual (📖): Pulsa este icono para acceder a este manual de usuario.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Configuración (⚙️): Aquí puedes personalizar la aplicación a tu medida. Podrás configurar tus cuentas, gestionar categorías, programar transacciones, exportar tus datos a un archivo CSV e incluso restablecer la aplicación para empezar de cero.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '•   Gestionar créditos (💳): Desde aquí, puedes añadir los créditos que tengas, como préstamos o hipotecas. La aplicación los descontará de forma automática de tus cuentas principales en la fecha del mes que tú decidas.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
