import 'package:flutter/material.dart';

class ManualScreen extends StatelessWidget {
  const ManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual de Usuario'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Bienvenido a Monity! 💸',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '¿Listo para domar tus finanzas y ver cómo tu dinero fluye como una fuente zen? ¡Vamos allá! Este manual te lo explica todo de forma sencilla y divertida.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                '1. El Gran Secreto: El Funcionamiento en Cascada',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Imagina tus cuentas como una cascada de agua. Cuando recibes un ingreso, el dinero cae primero en la cuenta más importante (¡tú decides el orden!). Si esa cuenta se llena (llega a su saldo máximo mensual), el resto del dinero rebosa y sigue bajando a la siguiente cuenta, y así sucesivamente. ¡Automatiza tu ahorro y prioriza tus gastos sin mover un dedo! 🏞️',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '¿Por qué mola tanto?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                  '• Tus necesidades básicas se cubren primero.\n• El ahorro ocurre solo, sin que tengas que pensar en ello.\n• El orden de las cuentas es tuyo: ¡pon primero lo que más te importa!',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 24),
              Text(
                '2. La Pantalla Principal: Tu Panel de Control',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Aquí verás todas tus cuentas, cada una con su barra de progreso y color. ¿Verde? Vas genial. ¿Azul? Vas bien, pero ojo. ¿Rojo? ¡Cuidado, que te pasas! Y debajo, la proyección de gasto a fin de mes: si sigues así, ¿cómo acabarás el mes? ¡Monity te lo chiva con colores! 🎨',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                  '¿Quieres registrar un ingreso o un gasto? Usa los botones (+) y (-) bien grandes. ¿Quieres ver el historial? Pulsa en la cuenta que quieras. ¿Te gustan los gráficos? ¡Pulsa y explora tus estadísticas!',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 24),
              Text(
                '3. Configura tus Límites: ¡Ponle Puertas al Campo!',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 8),
              Text(
                'Entra en la configuración (icono ⚙️) y edita cada cuenta. Tienes dos superpoderes:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                  '• Saldo Máximo Mensual: El tope de la cuenta. Si lo superas, el dinero sigue bajando en la cascada.\n• Límite de Gasto Mensual: Tu objetivo personal. Si te acercas, la barra cambia de color para avisarte. ¡No hay bloqueos, solo avisos visuales!',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(
                  'Recuerda: el orden de las cuentas es clave. Arrastra y suelta para priorizar lo que más te importa.',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 24),
              Text(
                '4. El Resto de Funciones: ¡Monity es Mucho Más!',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 8),
              Text(
                  '• Categorías: Crea, edita y ponles color a tus categorías para ver en qué gastas.\n• Transacciones periódicas: Automatiza tus ingresos, gastos y transferencias recurrentes.\n• Créditos: Gestiona préstamos e hipotecas, Monity descuenta los pagos automáticamente.\n• Exporta a CSV: Descarga todas tus transacciones para analizarlas donde quieras.\n• Reset: ¿Quieres empezar de cero? Borra todos los datos desde la configuración.\n• Estadísticas: Gráficos de barras y circulares para entender tus hábitos de gasto.\n• Menú superior: Acceso rápido al manual (📖), configuración (⚙️) y gestión de créditos (💳).',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 24),
              Text(
                '¡Y Recuerda!',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                  'Monity está para hacerte la vida más fácil. Deja que la cascada y los colores te guíen, automatiza lo aburrido y disfruta viendo crecer tu ahorro. ¡Toma el control de tu dinero y conviértete en el jefe de tus finanzas! 🚀',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 32),
              Text(
                  '¿Dudas? Pulsa el icono 📖 en la app y vuelve a este manual cuando quieras. ¡Feliz ahorro!',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
}