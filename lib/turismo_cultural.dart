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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: culturalSites.length,
        itemBuilder: (context, index) {
          final site = culturalSites[index];
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
        },
      ),
      // DISABLED: All ads removed for AdSense editorial content policy compliance
    );
  }
}
