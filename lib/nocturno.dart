import 'package:flutter/material.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'icon_utils.dart';

class NocturnoPage extends StatefulWidget {
  const NocturnoPage({super.key});
  @override
  State<NocturnoPage> createState() => _NocturnoPageState();
}

class _NocturnoPageState extends State<NocturnoPage> {
  @override
  Widget build(BuildContext context) {
    final actividadesNocturnas = [
      {
        'nombre': 'Ruta Nocturna por el Toledo Mágico',
        'descripcionKey': 'noche_magico_desc',
        'direccion': 'Punto de encuentro: Plaza de Zocodover',
        'icon': 'nightlight_round',
      },
      {
        'nombre': 'Tour de Fantasmas y Misterios',
        'descripcionKey': 'noche_fantasmas_desc',
        'direccion': 'Punto de encuentro: Plaza del Ayuntamiento',
        'icon': 'emoji_objects',
      },
      {
        'nombre': 'Discoteca Circulo de Arte',
        'descripcionKey': 'noche_circulo_desc',
        'direccion': 'Plaza de San Vicente, 2, 45001 Toledo',
        'icon': 'music_note',
      },
      {
        'nombre': 'Sala Pícaro',
        'descripcionKey': 'noche_picaro_desc',
        'direccion': 'Calle Cadenas, 6, 45001 Toledo',
        'icon': 'theater_comedy',
      },
      {
        'nombre': 'La Nuit Toledo',
        'descripcionKey': 'noche_nuit_desc',
        'direccion': 'Calle Río Jarama, 120, 45007 Toledo',
        'icon': 'nightlife',
      },
      {
        'nombre': 'Salón de Baile El Candil',
        'descripcionKey': 'noche_candil_desc',
        'direccion': 'Calle de la Plata, 12, 45001 Toledo',
        'icon': 'music_note',
      },
      {
        'nombre': 'Pub El Ultimo',
        'descripcionKey': 'noche_ultimo_desc',
        'direccion': 'Calle Alfileritos, 3, 45003 Toledo',
        'icon': 'local_bar',
      },
      {
        'nombre': 'Excursión Toledo de Leyenda',
        'descripcionKey': 'noche_leyenda_desc',
        'direccion': 'Punto de encuentro: Plaza de Zocodover',
        'icon': 'tour',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'nightlife')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Introducción editorial sobre vida nocturna en Toledo
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(context, 'nightlife_intro_title'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tr(context, 'nightlife_intro_text'),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tr(context, 'night_activities_title'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tr(context, 'night_activities_text'),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),

          // Lista de actividades existente
          for (var actividad in actividadesNocturnas)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              child: ListTile(
                leading: Icon(
                  getIconData(actividad['icon'] as String),
                  size: 36,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  actividad['nombre'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tr(context, actividad['descripcionKey'] as String)}\n${actividad['direccion'] as String}',
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        final direccion = actividad['direccion'] as String;
                        _abrirGoogleMaps(direccion);
                      },
                      icon: const Icon(Icons.directions),
                      label: Text(tr(context, 'como_llegar')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            ),
        ],
      ),
      // Removed ads from this page - insufficient editorial content for AdSense
    );
  }

  void _abrirGoogleMaps(String direccion) {
    final url = Uri.encodeFull(
      'https://www.google.com/maps/search/?api=1&query=$direccion',
    );
    _launchUrl(url);
  }

  Future<void> _launchUrl(String url) async {
    if (!mounted) return;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_opening_maps'))),
      );
    }
  }
}
