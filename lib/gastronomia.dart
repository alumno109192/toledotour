import 'package:toledotour/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'icon_utils.dart';

class GastronomiaPage extends StatefulWidget {
  const GastronomiaPage({super.key});

  @override
  State<GastronomiaPage> createState() => _GastronomiaPageState();
}

class _GastronomiaPageState extends State<GastronomiaPage> {
  Position? _currentPosition;
  bool _isLoadingLocation = false;
  bool _sortByDistance = false;
  final ScrollController _restaurantScrollController = ScrollController();
  final ScrollController _barScrollController = ScrollController();
  int? _selectedRestaurantIndex;
  int? _selectedBarIndex;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _restaurantScrollController.dispose();
    _barScrollController.dispose();
    super.dispose();
  }

  void _selectRestaurant(int originalIndex, List<Map<String, Object>> lugares) {
    // Determinar si es un restaurante o un bar basándose en el primer elemento
    // Los restaurantes tienen iconos: restaurant, restaurant_menu, dining
    // Los bares tienen iconos: local_bar, local_drink, sports_bar, fastfood
    bool isRestaurant =
        lugares.isNotEmpty &&
        (lugares[0]['icon'].toString().contains('restaurant') ||
            lugares[0]['icon'].toString().contains('dining'));

    // Encontrar el nombre del lugar seleccionado
    final selectedPlace = lugares[originalIndex];
    final selectedName = selectedPlace['nombre'] as String;

    // Crear la lista ordenada igual que en _buildList
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

    // Encontrar el índice en la lista ordenada
    int sortedIndex = sortedLugares.indexWhere(
      (lugar) => lugar['nombre'] as String == selectedName,
    );

    setState(() {
      if (isRestaurant) {
        _selectedRestaurantIndex = sortedIndex;
        _selectedBarIndex = null;
      } else {
        _selectedBarIndex = sortedIndex;
        _selectedRestaurantIndex = null;
      }
    });

    // Calcular la posición del elemento en la lista y hacer scroll
    final itemHeight = 120.0; // Altura aproximada de cada card
    final targetOffset = sortedIndex * itemHeight;

    ScrollController controller = isRestaurant
        ? _restaurantScrollController
        : _barScrollController;

    controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    // Opcional: también mostrar el diálogo después de un breve delay
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _showLugarDialog(context, selectedPlace);
      }
    });
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

  Widget _buildGoogleMap(List<Map<String, Object>> lugares) {
    // Crear marcadores directamente para esta vista específica
    Set<Marker> currentMarkers = {};

    // Determinar si es un restaurante o un bar basándose en el primer elemento
    bool isRestaurant =
        lugares.isNotEmpty &&
        (lugares[0]['icon'].toString().contains('restaurant') ||
            lugares[0]['icon'].toString().contains('dining'));

    // Crear marcadores específicos para esta lista
    for (int i = 0; i < lugares.length; i++) {
      final lugar = lugares[i];
      String markerPrefix = isRestaurant ? 'restaurant_' : 'bar_';

      currentMarkers.add(
        Marker(
          markerId: MarkerId('$markerPrefix${lugar['nombre']}_$i'),
          position: LatLng(lugar['lat'] as double, lugar['lng'] as double),
          infoWindow: InfoWindow(
            title: lugar['nombre'] as String,
            snippet: lugar['direccion'] as String,
          ),
          onTap: () {
            _selectRestaurant(i, lugares);
          },
          // Usar diferentes colores para los marcadores
          icon: isRestaurant
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    // Centro del mapa en Toledo
    const LatLng toledoCenter = LatLng(39.8628, -4.0273);

    return Container(
      height: 250,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {},
          initialCameraPosition: const CameraPosition(
            target: toledoCenter,
            zoom: 14.0,
          ),
          markers: currentMarkers,
          myLocationEnabled: _currentPosition != null,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          zoomControlsEnabled: false,
        ),
      ),
    );
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
                        _selectedRestaurantIndex =
                            null; // Reset restaurant selection when sorting changes
                        _selectedBarIndex =
                            null; // Reset bar selection when sorting changes
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
        body: Column(
          children: [
            // Contenido editorial rico para cumplir políticas de AdSense
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gastronomía de Toledo: Sabores de las Tres Culturas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Una Tradición Culinaria Milenaria',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Toledo ofrece una rica y variada tradición gastronómica que combina magistralmente los sabores '
                    'y técnicas culinarias de las tres culturas que convivieron en la ciudad durante siglos: cristiana, '
                    'musulmana y judía. Esta fusión única ha dado lugar a una cocina excepcional que es, al mismo tiempo, '
                    'un reflejo fiel de la historia multicultural de la Ciudad Imperial.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Platos Emblemáticos y Productos Artesanales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Desde el mundialmente famoso mazapán, elaborado artesanalmente en los conventos toledanos desde '
                    'la Edad Media, hasta platos tan contundentes como el carcamusas (guiso de carne con tomate y guisantes), '
                    'la perdiz estofada a la toledana, o las tradicionales migas manchegas, la cocina toledana es un '
                    'auténtico festín para los sentidos. No hay que olvidar tampoco el queso manchego con Denominación '
                    'de Origen, los vinos de La Mancha, y el aceite de oliva virgen extra de producción local.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Restaurantes y Bares Tradicionales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A continuación encontrarás una selección de los mejores restaurantes y bares donde disfrutar de la '
                    'auténtica gastronomía manchega y toledana, preparada con recetas tradicionales y productos locales de '
                    'primera calidad. Cada establecimiento ha sido cuidadosamente seleccionado por su compromiso con la '
                    'tradición culinaria y la excelencia gastronómica.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            // TabBarView existente
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      // Mapa de Google con restaurantes
                      _buildGoogleMap(restaurantes),
                      // Lista de restaurantes
                      Expanded(child: _buildList(restaurantes, context)),
                    ],
                  ),
                  Column(
                    children: [
                      // Mapa de Google con bares
                      _buildGoogleMap(bares),
                      // Lista de bares
                      Expanded(child: _buildList(bares, context)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // DISABLED: All ads removed for AdSense editorial content policy compliance
      ),
    );
  }

  Widget _buildList(List<Map<String, Object>> lugares, BuildContext context) {
    bool isRestaurantList =
        lugares.isNotEmpty &&
        (lugares[0]['icon'].toString().contains('restaurant') ||
            lugares[0]['icon'].toString().contains('dining'));

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
      controller: isRestaurantList
          ? _restaurantScrollController
          : _barScrollController,
      padding: const EdgeInsets.all(16),
      itemCount: sortedLugares.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final lugar = sortedLugares[index];
        final isSelected = isRestaurantList
            ? _selectedRestaurantIndex == index
            : _selectedBarIndex == index;

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
          elevation: isSelected ? 8 : 3,
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
              : null,
          child: ListTile(
            leading: Icon(
              getIconData(lugar['icon'] as String),
              size: 36,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    lugar['nombre'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
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
            onTap: () {
              setState(() {
                if (isRestaurantList) {
                  _selectedRestaurantIndex = index;
                  _selectedBarIndex = null;
                } else {
                  _selectedBarIndex = index;
                  _selectedRestaurantIndex = null;
                }
              });
              _showLugarDialog(context, lugar);
            },
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
      final destino = Uri.encodeComponent(destinoDireccion);
      String url;

      // Si tenemos la ubicación actual, usarla como origen
      if (_currentPosition != null) {
        final origen =
            "${_currentPosition!.latitude},${_currentPosition!.longitude}";
        url =
            "https://www.google.com/maps/dir/?api=1&origin=$origen&destination=$destino&travelmode=driving";
      } else {
        // Si no tenemos ubicación, abrir Google Maps solo con el destino
        url = "https://www.google.com/maps/search/?api=1&query=$destino";
      }

      // Para web, usar LaunchMode.platformDefault; para móvil, externalApplication
      final launchMode = kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication;

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: launchMode);
      } else {
        // Fallback: intentar con la URL web de Google Maps
        final fallbackUrl = "https://www.google.com/maps/search/$destino";
        if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
          await launchUrl(Uri.parse(fallbackUrl), mode: launchMode);
        } else {
          if (!mounted) return;
          _showErrorDialog(
            tr(context, 'navigation_error'),
            'No se pudo abrir Google Maps',
            context,
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog(
        tr(context, 'navigation_error'),
        'Error al intentar navegar: $e',
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
