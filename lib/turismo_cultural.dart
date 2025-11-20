import 'package:flutter/material.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'destino_simple.dart';
import 'icon_utils.dart';

class CulturalTourismPage extends StatelessWidget {
  const CulturalTourismPage({super.key});

  @override
  Widget build(BuildContext context) {
    final culturalSites = [
      {
        'name': 'Mezquita del Cristo de la Luz',
        'descriptionKey': 'cultural_cristo_desc',
        'icon': 'account_balance',
        'address': 'Calle Cristo de la Luz, 22, 45003 Toledo',
        'schedule': '10:00 - 18:00',
        'price': '3€ (consultar descuentos y horarios actualizados)',
        'extraInfo':
            'Declarada Bien de Interés Cultural\nVisitas guiadas disponibles\nCercana a la Puerta del Sol',
      },
      {
        'name': 'Museo de Santa Cruz',
        'descriptionKey': 'cultural_santacruz_desc',
        'icon': 'museum',
        'address': 'Calle Miguel de Cervantes, 3, 45001 Toledo',
        'schedule':
            'Martes a sábado: 10:00 - 18:30\nDomingos y festivos: 9:00 - 15:00',
        'price': 'Entrada general: 5€',
        'extraInfo': 'Museo ubicado en un antiguo hospital renacentista.',
      },
      {
        'name': 'Sinagoga de Santa María la Blanca',
        'descriptionKey': 'cultural_sinagoga_desc',
        'icon': 'account_balance_wallet',
        'address': 'Calle de los Reyes Católicos, 4, 45002 Toledo',
        'schedule': '10:00 - 18:45',
        'price': '3€',
        'extraInfo': 'Ejemplo de arquitectura mudéjar.',
      },
      {
        'name': 'Museo del Greco',
        'descriptionKey': 'cultural_greco_desc',
        'icon': 'brush',
        'address': 'Paseo del Tránsito, s/n, 45002 Toledo',
        'schedule':
            'Martes a sábado: 9:30 - 18:30\nDomingos y festivos: 10:00 - 15:00',
        'price': '3€',
        'extraInfo': 'Colección de obras y objetos del pintor.',
      },
      {
        'name': 'Mezquita de las Tornerías',
        'descriptionKey': 'cultural_tornerias_desc',
        'icon': 'account_balance',
        'address': 'Calle Tornerías, 10, 45001 Toledo',
        'schedule': 'Consultar horarios',
        'price': 'Consultar',
        'extraInfo': 'Ejemplo de arquitectura islámica en Toledo.',
      },
      {
        'name': 'Museo Sefardí',
        'descriptionKey': 'cultural_sefardi_desc',
        'icon': 'history_edu',
        'address': 'Calle Samuel Levi, s/n, 45002 Toledo',
        'schedule':
            'Martes a sábado: 9:30 - 18:30\nDomingos y festivos: 10:00 - 15:00',
        'price': '3€',
        'extraInfo': 'Ubicado en la Sinagoga del Tránsito.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'cultural_tourism'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Contenido editorial rico para cumplir políticas de AdSense
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 24),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Turismo Cultural en Toledo: Guía Completa de la Ciudad Imperial',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'La Ciudad de las Tres Culturas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Toledo es conocida mundialmente como la "Ciudad de las Tres Culturas" debido a la convivencia '
                    'histórica y pacífica de cristianos, musulmanes y judíos durante siglos. Este legado único '
                    'se refleja de manera extraordinaria en su impresionante patrimonio arquitectónico, artístico '
                    'y cultural. Declarada Patrimonio de la Humanidad por la UNESCO en 1986, Toledo representa '
                    'uno de los conjuntos históricos más importantes y mejor conservados de Europa.',
                    style: TextStyle(fontSize: 16, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Patrimonio Arquitectónico Excepcional',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'La ciudad alberga magníficos ejemplos de arquitectura mudéjar, un estilo único que fusiona '
                    'elementos cristianos e islámicos, también declarado Patrimonio de la Humanidad por la UNESCO. '
                    'Sus monumentos narran más de dos mil años de historia, desde vestigios de la época romana '
                    'y visigoda, pasando por el esplendor medieval, hasta alcanzar su máximo apogeo durante el '
                    'Renacimiento español cuando fue capital del Imperio bajo Carlos V.',
                    style: TextStyle(fontSize: 16, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Museos y Sitios Culturales de Referencia',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Visitar Toledo es sumergirse en un auténtico museo al aire libre donde cada calle empedrada, '
                    'cada plaza centenaria y cada edificio histórico tiene una fascinante historia que contar. '
                    'Los museos y sitios culturales de la ciudad ofrecen experiencias únicas e irrepetibles para '
                    'comprender en profundidad la riqueza histórica, artística y cultural no solo de Toledo, '
                    'sino de toda España. Desde la Mezquita del Cristo de la Luz, joya del arte islámico, hasta '
                    'el Museo del Greco, cada rincón es testimonio vivo de siglos de civilización.',
                    style: TextStyle(fontSize: 16, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Planifica tu Visita Cultural',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Para aprovechar al máximo tu experiencia cultural en Toledo, te recomendamos dedicar al menos '
                    'dos días completos a la visita de sus principales monumentos y museos. Cada sitio cultural '
                    'requiere tiempo para ser apreciado en toda su magnitud. A continuación, te presentamos una '
                    'selección cuidadosamente elaborada de los principales destinos culturales que no puedes '
                    'perderte durante tu visita a la Ciudad Imperial:',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          // Lista de sitios culturales
          ...culturalSites.map((site) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              child: ListTile(
                leading: Icon(
                  getIconData(site['icon'] as String),
                  size: 36,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  site['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(tr(context, site['descriptionKey'] as String)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DestinoPage(
                        title: site['name'] as String,
                        description: tr(
                          context,
                          site['descriptionKey'] as String,
                        ),
                        icon: site['icon'] as String,
                        address: site['address'] as String,
                        schedule: site['schedule'] as String,
                        price: site['price'] as String,
                        extraInfo: site['extraInfo'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
      // DISABLED: All ads removed for AdSense editorial content policy compliance
    );
  }
}
