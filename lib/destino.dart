import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'icon_utils.dart';
import 'interstitial_ad_helper.dart';

class DestinoPage extends StatefulWidget {
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

  @override
  State<DestinoPage> createState() => _DestinoPageState();
}

class _DestinoPageState extends State<DestinoPage> {
  late Map<String, double> _destinoCoords;
  final InterstitialAdHelper? _adHelper = kIsWeb
      ? null
      : (InterstitialAdHelper()..loadAd());

  @override
  void initState() {
    super.initState();
    _setDestinoCoords();
  }

  void _setDestinoCoords() {
    if (widget.title == 'Mezquita del Cristo de la Luz') {
      _destinoCoords = {'lat': 39.8622, 'lng': -4.0246};
    } else if (widget.title == 'Museo de Santa Cruz') {
      _destinoCoords = {'lat': 39.8587, 'lng': -4.0226};
    } else if (widget.title == 'Sinagoga de Santa María la Blanca') {
      _destinoCoords = {'lat': 39.8557, 'lng': -4.0272};
    } else if (widget.title == 'Museo del Greco') {
      _destinoCoords = {'lat': 39.8552, 'lng': -4.0292};
    } else if (widget.title == 'Mezquita de las Tornerías') {
      _destinoCoords = {'lat': 39.8595, 'lng': -4.0229};
    } else if (widget.title == 'Museo Sefardí') {
      _destinoCoords = {'lat': 39.8551, 'lng': -4.0297};
    } else {
      _destinoCoords = {'lat': 39.8628, 'lng': -4.0273};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Icon(
            getIconData(widget.icon),
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(widget.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Text(
            'Dirección: ${widget.address}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Horario: ${widget.schedule}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text('Precio: ${widget.price}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Text(widget.extraInfo, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.directions),
            label: const Text('Ver ruta en Google Maps'),
            onPressed: () {
              final lat = _destinoCoords['lat'];
              final lng = _destinoCoords['lng'];
              final url =
                  'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';

              if (_adHelper != null) {
                _adHelper.showAd(
                  onAdClosed: () {
                    launchUrl(Uri.parse(url));
                  },
                );
              } else {
                launchUrl(Uri.parse(url));
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.location_on),
            label: const Text('Buscar dirección'),
            onPressed: () {
              final address = widget.address;
              final query = Uri.encodeComponent(address);
              final url =
                  'https://www.google.com/maps/search/?api=1&query=$query';

              // En móvil, mostrar anuncio si está disponible
              if (_adHelper != null) {
                _adHelper.showAd(
                  onAdClosed: () {
                    launchUrl(Uri.parse(url));
                  },
                );
              } else {
                launchUrl(Uri.parse(url));
              }
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Utiliza los botones de arriba para abrir Google Maps y obtener indicaciones de navegación.',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
