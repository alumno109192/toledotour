import 'package:toledotour/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'icon_utils.dart';
import 'ad_banner_widget.dart';

class GastronomiaPage extends StatefulWidget {
  const GastronomiaPage({super.key});

  @override
  State<GastronomiaPage> createState() => _GastronomiaPageState();
}

class _GastronomiaPageState extends State<GastronomiaPage> {
  Position? _currentPosition;
  bool _isLoadingLocation = false;
  bool _sortByDistance = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoadingLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoadingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final restaurantes = [
      {
        'nombre': 'Restaurante Adolfo',
        'descripcionKey': 'rest_adolfo_desc',
        'direccion': 'Calle Hombre de Palo, 7, 45001 Toledo',
        'icon': 'restaurant',
        'lat': 39.8628,
        'lng': -4.0273,
      },
      {
        'nombre': 'La Orza',
        'descripcionKey': 'rest_laorza_desc',
        'direccion': 'Calle Descalzos, 5, 45002 Toledo',
        'icon': 'restaurant_menu',
        'lat': 39.8581,
        'lng': -4.0245,
      },
      {
        'nombre': 'Restaurante Alfileritos 24',
        'descripcionKey': 'rest_alfileritos_desc',
        'direccion': 'Calle Alfileritos, 24, 45003 Toledo',
        'icon': 'dining',
        'lat': 39.8597,
        'lng': -4.0238,
      },
      {
        'nombre': 'Restaurante Venta de Aires',
        'descripcionKey': 'rest_ventaaires_desc',
        'direccion': 'Calle de Toledo, 31, 45005 Toledo',
        'icon': 'restaurant',
        'lat': 39.8642,
        'lng': -4.0298,
      },
      {
        'nombre': 'Restaurante La Ermita',
        'descripcionKey': 'rest_ermita_desc',
        'direccion': 'Carretera de la Ermita, s/n, 45004 Toledo',
        'icon': 'restaurant',
        'lat': 39.8715,
        'lng': -4.0156,
      },
      {
        'nombre': 'Restaurante La Clandestina de las Tendillas',
        'descripcionKey': 'rest_clandestina_desc',
        'direccion': 'Calle Tendillas, 3, 45002 Toledo',
        'icon': 'restaurant',
        'lat': 39.8574,
        'lng': -4.0251,
      },
      {
        'nombre': 'Restaurante Locum',
        'descripcionKey': 'rest_locum_desc',
        'direccion': 'Calle Locum, 6, 45001 Toledo',
        'icon': 'restaurant',
        'lat': 39.8612,
        'lng': -4.0265,
      },
      {
        'nombre': 'Restaurante La Fábrica de Harinas',
        'descripcionKey': 'rest_fabrica_desc',
        'direccion': 'Calle Real del Arrabal, 1, 45003 Toledo',
        'icon': 'restaurant',
        'lat': 39.8591,
        'lng': -4.0315,
      },
      {
        'nombre': 'Restaurante El Albero',
        'descripcionKey': 'rest_albero_desc',
        'direccion': 'Calle Ronda Buenavista, 27, 45005 Toledo',
        'icon': 'restaurant',
        'lat': 39.8678,
        'lng': -4.0189,
      },
      {
        'nombre': 'Restaurante La Cave',
        'descripcionKey': 'rest_cave_desc',
        'direccion': 'Callejón de los Gatos, 1, 45001 Toledo',
        'icon': 'restaurant',
        'lat': 39.8605,
        'lng': -4.0258,
      },
    ];

    final bares = [
      {
        'nombre': 'La Abadía',
        'descripcionKey': 'bar_abadia_desc',
        'direccion': 'Plaza de San Nicolás, 3, 45001 Toledo',
        'icon': 'local_bar',
        'lat': 39.8619,
        'lng': -4.0248,
      },
      {
        'nombre': 'Taberna El Botero',
        'descripcionKey': 'bar_botero_desc',
        'direccion': 'Calle de la Ciudad, 5, 45002 Toledo',
        'icon': 'local_drink',
        'lat': 39.8599,
        'lng': -4.0268,
      },
      {
        'nombre': 'Cervecería El Trébol',
        'descripcionKey': 'bar_trebol_desc',
        'direccion': 'Calle de Santa Fe, 1, 45001 Toledo',
        'icon': 'sports_bar',
        'lat': 39.8608,
        'lng': -4.0241,
      },
      {
        'nombre': 'La Malquerida',
        'descripcionKey': 'bar_malquerida_desc',
        'direccion': 'Calle Santa Leocadia, 6, 45002 Toledo',
        'icon': 'fastfood',
        'lat': 39.8588,
        'lng': -4.0256,
      },
      {
        'nombre': 'Bar Ludeña',
        'descripcionKey': 'bar_ludena_desc',
        'direccion': 'Plaza de la Magdalena, 10, 45001 Toledo',
        'icon': 'local_bar',
        'lat': 39.8614,
        'lng': -4.0233,
      },
      {
        'nombre': 'Bar Skala',
        'descripcionKey': 'bar_skala_desc',
        'direccion': 'Calle de la Sillería, 13, 45001 Toledo',
        'icon': 'local_bar',
        'lat': 39.8603,
        'lng': -4.0251,
      },
      {
        'nombre': 'Bar El Pez',
        'descripcionKey': 'bar_elpez_desc',
        'direccion': 'Callejón de Menores, 6, 45001 Toledo',
        'icon': 'local_bar',
        'lat': 39.8587,
        'lng': -4.0243,
      },
      {
        'nombre': 'Bar El Foro',
        'descripcionKey': 'bar_elforo_desc',
        'direccion': 'Calle Cardenal Cisneros, 12, 45001 Toledo',
        'icon': 'local_bar',
        'lat': 39.8621,
        'lng': -4.0259,
      },
      {
        'nombre': 'Bar El Rincón de Juan',
        'descripcionKey': 'bar_rinconjuan_desc',
        'direccion': 'Calle de la Merced, 6, 45002 Toledo',
        'icon': 'local_bar',
        'lat': 39.8592,
        'lng': -4.0247,
      },
      {
        'nombre': 'Bar La Tabernita',
        'descripcionKey': 'bar_tabernita_desc',
        'direccion': 'Calle de la Plata, 8, 45001 Toledo',
        'icon': 'local_bar',
        'lat': 39.8610,
        'lng': -4.0261,
      },
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr(context, 'gastronomy')),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              icon: Icon(
                _sortByDistance ? Icons.sort_by_alpha : Icons.near_me,
                color: _currentPosition != null && !_isLoadingLocation
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              onPressed: _currentPosition != null && !_isLoadingLocation
                  ? () {
                      setState(() {
                        _sortByDistance = !_sortByDistance;
                      });
                    }
                  : null,
              tooltip: _sortByDistance
                  ? tr(context, 'sort_alphabetically')
                  : tr(context, 'sort_by_distance'),
            ),
            if (_isLoadingLocation)
              Container(
                padding: const EdgeInsets.all(16),
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: tr(context, 'restaurants')),
              Tab(text: tr(context, 'bars')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(restaurantes, context),
            _buildList(bares, context),
          ],
        ),
        bottomNavigationBar: const AdBannerWidget(),
      ),
    );
  }

  Widget _buildList(List<Map<String, Object>> lugares, BuildContext context) {
    List<Map<String, Object>> sortedLugares = List.from(lugares);

    if (_sortByDistance && _currentPosition != null) {
      // Calcular distancia para cada lugar
      for (var lugar in sortedLugares) {
        double distance = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          lugar['lat'] as double,
          lugar['lng'] as double,
        );
        lugar['distance'] = distance;
      }

      // Ordenar por distancia
      sortedLugares.sort((a, b) {
        double distanceA = a['distance'] as double;
        double distanceB = b['distance'] as double;
        return distanceA.compareTo(distanceB);
      });
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedLugares.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final lugar = sortedLugares[index];

        // Formatear distancia si está disponible
        String? distanceText;
        if (_sortByDistance && lugar.containsKey('distance')) {
          double distance = lugar['distance'] as double;
          if (distance < 1000) {
            distanceText = '${distance.round()} m';
          } else {
            distanceText = '${(distance / 1000).toStringAsFixed(1)} km';
          }
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          child: ListTile(
            leading: Icon(
              getIconData(lugar['icon'] as String),
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    lugar['nombre'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (distanceText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      distanceText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            subtitle: Text(
              '${tr(context, lugar['descripcionKey'] as String)}\n${lugar['direccion'] as String}',
            ),
            isThreeLine: true,
            onTap: () => _showLugarDialog(context, lugar),
          ),
        );
      },
    );
  }

  void _showLugarDialog(BuildContext context, Map<String, Object> lugar) async {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                getIconData(lugar['icon'] as String),
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(lugar['nombre'] as String),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr(context, lugar['descripcionKey'] as String)),
              const SizedBox(height: 8),
              Text(lugar['direccion'] as String),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.directions),
                label: Text(tr(context, 'how_to_get')),
                onPressed: () async {
                  if (!mounted) return;
                  Navigator.of(context).pop();
                  await _navigateToLugar(lugar['direccion'] as String);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _navigateToLugar(String destinoDireccion) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (!mounted) return;
          _showErrorDialog(
            tr(context, 'permission_denied'),
            tr(context, 'location_needed'),
            context,
          );
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        _showErrorDialog(
          tr(context, 'permission_denied'),
          tr(context, 'permission_denied_permanently'),
          context,
        );
        return;
      }
      Position position = await Geolocator.getCurrentPosition();
      final origen = "${position.latitude},${position.longitude}";
      final destino = Uri.encodeComponent(destinoDireccion);
      final url =
          "https://www.google.com/maps/dir/?api=1&origin=$origen&destination=$destino&travelmode=driving";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog(
        tr(context, 'navigation_error'),
        tr(context, 'error'),
        context,
      );
    }
  }

  void _showErrorDialog(String title, String message, BuildContext context) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr(context, 'close')),
          ),
        ],
      ),
    );
  }
}
