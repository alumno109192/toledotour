import 'package:flutter/material.dart';
import 'package:toledotour/l10n/app_localizations.dart';

class ToledoHistoryPage extends StatelessWidget {
  const ToledoHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'history_title')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B4513), Color(0xFFD2691E)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.castle, size: 80, color: Colors.white54),
              ),
            ),
            const SizedBox(height: 24),

            // Introduction
            Text(
              'Historia de Toledo: Un Viaje a Través del Tiempo',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Toledo, conocida como la "Ciudad Imperial" y la "Ciudad de las Tres Culturas", '
              'es una de las ciudades con mayor riqueza histórica de España. Su privilegiada '
              'ubicación sobre el río Tajo ha sido clave en su desarrollo a lo largo de más de '
              '2000 años de historia continua.',
              style: TextStyle(fontSize: 16, height: 1.6),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 24),

            // Época Romana
            _buildHistorySection(
              context,
              'Época Romana (Siglos II a.C. - V d.C.)',
              'Los romanos fundaron Toletum en el siglo II a.C., convirtiendo la ciudad en un importante '
                  'centro administrativo y militar. Construyeron circos, termas, acueductos y un sistema de '
                  'alcantarillado cuyos restos aún se pueden visitar. La ciudad se convirtió en la capital '
                  'de la Carpetania y un punto estratégico para el control de la península.',
              Icons.account_balance,
            ),

            // Época Visigoda
            _buildHistorySection(
              context,
              'Reino Visigodo (Siglos V - VIII)',
              'Toledo alcanzó su mayor esplendor como capital del Reino Visigodo. Los reyes visigodos '
                  'establecieron aquí su corte y se celebraron los famosos Concilios de Toledo, que marcaron '
                  'la historia religiosa y política de la península. La ciudad se convirtió en el centro '
                  'neurálgico del reino, con una próspera comunidad judía y cristiana.',
              Icons.diamond,
            ),

            // Época Musulmana
            _buildHistorySection(
              context,
              'Dominio Musulmán (711 - 1085)',
              'Tras la conquista musulmana, Toledo se convirtió en la capital de la Marca Media de Al-Andalus. '
                  'La ciudad experimentó un gran desarrollo urbano y cultural. Se construyeron mezquitas, baños '
                  'árabes y un sofisticado sistema de irrigación. La convivencia entre musulmanes, cristianos '
                  'y judíos dio lugar a un período de gran riqueza cultural conocido como la "Escuela de Traductores".',
              Icons.mosque,
            ),

            // Reconquista
            _buildHistorySection(
              context,
              'Reconquista Cristiana (1085)',
              'Alfonso VI de Castilla conquistó Toledo en 1085 sin apenas resistencia. La ciudad mantuvo '
                  'su carácter multicultural y se convirtió en un importante centro de traducción donde '
                  'sabios cristianos, musulmanes y judíos trabajaron juntos traduciendo obras clásicas '
                  'del árabe al latín, contribuyendo al renacimiento cultural europeo.',
              Icons.castle,
            ),

            // Época Imperial
            _buildHistorySection(
              context,
              'Capital Imperial (Siglos XVI - XVII)',
              'Carlos V eligió Toledo como sede de su corte imperial, convirtiendo la ciudad en el centro '
                  'político del imperio más poderoso del mundo. Se construyeron palacios, conventos y iglesias '
                  'que hoy forman parte del patrimonio histórico. El Greco desarrolló aquí su obra más importante, '
                  'inmortalizando la ciudad en sus pinturas.',
              Icons.apartment,
            ),

            // Patrimonio Actual
            _buildHistorySection(
              context,
              'Patrimonio Mundial (1986 - Presente)',
              'En 1986, la UNESCO declaró el conjunto histórico de Toledo Patrimonio de la Humanidad. '
                  'La ciudad conserva intacto su trazado medieval y alberga monumentos de todas las épocas. '
                  'Hoy Toledo es un destino turístico mundial que combina historia, cultura, gastronomía '
                  'y tradición artesanal, manteniendo vivas las tradiciones de sus ancestros.',
              Icons.public,
            ),

            const SizedBox(height: 32),

            // Call to action
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver a la Guía'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 15, height: 1.6),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
