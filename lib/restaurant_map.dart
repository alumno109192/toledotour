import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'ad_banner_widget.dart';

class RestaurantMapPage extends StatefulWidget {
  const RestaurantMapPage({super.key});

  @override
  State<RestaurantMapPage> createState() => _RestaurantMapPageState();
}

class _RestaurantMapPageState extends State<RestaurantMapPage> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _isLoadingLocation = false;
  Set<Marker> _markers = {};

  // Centro de Toledo
  static const LatLng _toledoCenter = LatLng(39.8628, -4.0273);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _createMarkers();
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

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });

      // Añadir marcador de ubicación actual
      _addCurrentLocationMarker();
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _addCurrentLocationMarker() {
    if (_currentPosition != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: InfoWindow(
              title: tr(context, 'your_location'),
              snippet: tr(context, 'current_position'),
            ),
          ),
        );
      });
    }
  }

  void _createMarkers() {
    final restaurantes = [
      {
        'nombre': 'Restaurante Adolfo',
        'descripcion': 'Restaurante de alta cocina con estrella Michelin',
        'direccion': 'Calle Hombre de Palo, 7, 45001 Toledo',
        'lat': 39.8628,
        'lng': -4.0273,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'La Orza',
        'descripcion': 'Cocina tradicional toledana en ambiente acogedor',
        'direccion': 'Calle Descalzos, 5, 45002 Toledo',
        'lat': 39.8581,
        'lng': -4.0245,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante Alfileritos 24',
        'descripcion':
            'Especialidad en cocina castellana y platos tradicionales',
        'direccion': 'Calle Alfileritos, 24, 45003 Toledo',
        'lat': 39.8597,
        'lng': -4.0238,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante Venta de Aires',
        'descripcion': 'Cocina moderna con productos locales',
        'direccion': 'Calle de Toledo, 31, 45005 Toledo',
        'lat': 39.8642,
        'lng': -4.0298,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante La Ermita',
        'descripcion': 'Restaurante con vistas panorámicas de Toledo',
        'direccion': 'Carretera de la Ermita, s/n, 45004 Toledo',
        'lat': 39.8715,
        'lng': -4.0156,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante La Clandestina de las Tendillas',
        'descripcion': 'Cocina creativa en ambiente íntimo',
        'direccion': 'Calle Tendillas, 3, 45002 Toledo',
        'lat': 39.8574,
        'lng': -4.0251,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante Locum',
        'descripcion': 'Fusión de cocina tradicional y moderna',
        'direccion': 'Calle Locum, 6, 45001 Toledo',
        'lat': 39.8612,
        'lng': -4.0265,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante La Fábrica de Harinas',
        'descripcion': 'Especialidad en arroces y paellas',
        'direccion': 'Calle Real del Arrabal, 1, 45003 Toledo',
        'lat': 39.8591,
        'lng': -4.0315,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante El Albero',
        'descripcion': 'Cocina mediterránea con terraza',
        'direccion': 'Calle Ronda Buenavista, 27, 45005 Toledo',
        'lat': 39.8678,
        'lng': -4.0189,
        'tipo': 'restaurante',
      },
      {
        'nombre': 'Restaurante La Cave',
        'descripcion': 'Bodega restaurante con ambiente único',
        'direccion': 'Callejón de los Gatos, 1, 45001 Toledo',
        'lat': 39.8605,
        'lng': -4.0258,
        'tipo': 'restaurante',
      },
      // Bares
      {
        'nombre': 'La Abadía',
        'descripcion': 'Bar de tapas tradicionales toledanas',
        'direccion': 'Plaza de San Nicolás, 3, 45001 Toledo',
        'lat': 39.8619,
        'lng': -4.0248,
        'tipo': 'bar',
      },
      {
        'nombre': 'Taberna El Botero',
        'descripcion': 'Taberna con ambiente auténtico toledano',
        'direccion': 'Calle de la Ciudad, 5, 45002 Toledo',
        'lat': 39.8599,
        'lng': -4.0268,
        'tipo': 'bar',
      },
      {
        'nombre': 'Cervecería El Trébol',
        'descripcion': 'Cervecería con amplia variedad de cervezas',
        'direccion': 'Calle de Santa Fe, 1, 45001 Toledo',
        'lat': 39.8608,
        'lng': -4.0241,
        'tipo': 'bar',
      },
      {
        'nombre': 'La Malquerida',
        'descripcion': 'Bar con tapas y ambiente nocturno',
        'direccion': 'Calle Santa Leocadia, 6, 45002 Toledo',
        'lat': 39.8588,
        'lng': -4.0256,
        'tipo': 'bar',
      },
      {
        'nombre': 'Bar Ludeña',
        'descripcion': 'Bar histórico con tapas tradicionales',
        'direccion': 'Plaza de la Magdalena, 10, 45001 Toledo',
        'lat': 39.8614,
        'lng': -4.0233,
        'tipo': 'bar',
      },
    ];

    Set<Marker> markers = {};

    for (var i = 0; i < restaurantes.length; i++) {
      final restaurante = restaurantes[i];
      final isRestaurant = restaurante['tipo'] == 'restaurante';

      markers.add(
        Marker(
          markerId: MarkerId('restaurant_$i'),
          position: LatLng(
            restaurante['lat'] as double,
            restaurante['lng'] as double,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            isRestaurant ? BitmapDescriptor.hueRed : BitmapDescriptor.hueOrange,
          ),
          infoWindow: InfoWindow(
            title: restaurante['nombre'] as String,
            snippet:
                '${restaurante['descripcion']}\n${restaurante['direccion']}',
          ),
          onTap: () => _showRestaurantDetails(restaurante),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  void _showRestaurantDetails(Map<String, dynamic> restaurante) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.7,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Indicador de arrastre
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Icono y nombre
                  Row(
                    children: [
                      Icon(
                        restaurante['tipo'] == 'restaurante'
                            ? Icons.restaurant
                            : Icons.local_bar,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          restaurante['nombre'] as String,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Tipo
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: restaurante['tipo'] == 'restaurante'
                          ? Colors.red[100]
                          : Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      restaurante['tipo'] == 'restaurante'
                          ? '🍽️ Restaurante'
                          : '🍺 Bar',
                      style: TextStyle(
                        color: restaurante['tipo'] == 'restaurante'
                            ? Colors.red[800]
                            : Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Descripción
                  Text(
                    restaurante['descripcion'] as String,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 15),

                  // Dirección
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          restaurante['direccion'] as String,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Botones de acción
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _centerOnLocation(
                            restaurante['lat'] as double,
                            restaurante['lng'] as double,
                          ),
                          icon: const Icon(Icons.center_focus_strong),
                          label: Text(tr(context, 'center_on_map')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _getDirections(
                            restaurante['lat'] as double,
                            restaurante['lng'] as double,
                          ),
                          icon: const Icon(Icons.directions),
                          label: Text(tr(context, 'directions')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _centerOnLocation(double lat, double lng) {
    Navigator.pop(context); // Cerrar bottom sheet
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 17.0),
      ),
    );
  }

  void _getDirections(double lat, double lng) async {
    Navigator.pop(context); // Cerrar bottom sheet

    if (_currentPosition != null) {
      final origen =
          "${_currentPosition!.latitude},${_currentPosition!.longitude}";
      final destino = "$lat,$lng";
      final url = "https://www.google.com/maps/dir/$origen/$destino";

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } else {
      // Si no hay ubicación actual, abrir Google Maps con el destino
      final url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            zoom: 15.0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'restaurant_map')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _goToCurrentLocation,
            tooltip: tr(context, 'my_location'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _getCurrentLocation();
              _createMarkers();
            },
            tooltip: tr(context, 'refresh'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Leyenda
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red[700]),
                    const SizedBox(width: 5),
                    Text(tr(context, 'restaurants')),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.orange[700]),
                    const SizedBox(width: 5),
                    Text(tr(context, 'bars')),
                  ],
                ),
                if (_currentPosition != null)
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue[700]),
                      const SizedBox(width: 5),
                      Text(tr(context, 'your_location')),
                    ],
                  ),
              ],
            ),
          ),

          // Mapa
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition != null
                    ? LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      )
                    : _toledoCenter,
                zoom: 14.0,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              mapToolbarEnabled: false,
              compassEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
            ),
          ),

          // Banner de anuncios
          const AdBannerWidget(),
        ],
      ),

      // Botón flotante para ir a ubicación actual
      floatingActionButton: _isLoadingLocation
          ? const FloatingActionButton(
              onPressed: null,
              child: CircularProgressIndicator(color: Colors.white),
            )
          : FloatingActionButton.extended(
              onPressed: _goToCurrentLocation,
              icon: const Icon(Icons.my_location),
              label: Text(tr(context, 'my_location')),
              backgroundColor: Theme.of(context).primaryColor,
            ),
    );
  }
}
