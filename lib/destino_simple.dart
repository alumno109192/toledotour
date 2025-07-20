import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'icon_utils.dart';

class DestinoPage extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final String address;
  final String schedule;
  final String price;
  final String extraInfo;

  const DestinoPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.address,
    required this.schedule,
    required this.price,
    required this.extraInfo,
  });

  Map<String, double> _getCoords() {
    if (title == 'Mezquita del Cristo de la Luz') {
      return {'lat': 39.8622, 'lng': -4.0246};
    } else if (title == 'Museo de Santa Cruz') {
      return {'lat': 39.8587, 'lng': -4.0226};
    } else if (title == 'Sinagoga de Santa María la Blanca') {
      return {'lat': 39.8557, 'lng': -4.0272};
    } else if (title == 'Museo del Greco') {
      return {'lat': 39.8552, 'lng': -4.0292};
    } else if (title == 'Mezquita de las Tornerías') {
      return {'lat': 39.8595, 'lng': -4.0229};
    } else if (title == 'Museo Sefardí') {
      return {'lat': 39.8551, 'lng': -4.0297};
    } else {
      return {'lat': 39.8628, 'lng': -4.0273};
    }
  }

  @override
  Widget build(BuildContext context) {
    final coords = _getCoords();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Icon(
            getIconData(icon),
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información práctica:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('📍 Dirección: $address'),
                  const SizedBox(height: 4),
                  Text('🕒 Horario: $schedule'),
                  const SizedBox(height: 4),
                  Text('💰 Precio: $price'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (extraInfo.isNotEmpty) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información adicional:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(extraInfo),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          ElevatedButton.icon(
            icon: const Icon(Icons.directions),
            label: const Text('Ver ruta en Google Maps'),
            onPressed: () {
              final lat = coords['lat'];
              final lng = coords['lng'];
              final url =
                  'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
              launchUrl(Uri.parse(url));
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text('Buscar dirección'),
            onPressed: () {
              final query = Uri.encodeComponent(address);
              final url =
                  'https://www.google.com/maps/search/?api=1&query=$query';
              launchUrl(Uri.parse(url));
            },
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '💡 Utiliza los botones de arriba para abrir Google Maps y obtener indicaciones de navegación.',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
