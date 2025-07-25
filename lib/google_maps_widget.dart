import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  final List<Map<String, Object>> lugares;
  final String type; // 'restaurants' o 'bars'

  const GoogleMapsWidget({
    super.key,
    required this.lugares,
    required this.type,
  });

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  // Coordenadas del centro de Toledo
  static const LatLng _toledoCenter = LatLng(39.8628, -4.0273);

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    markers.clear();

    for (int i = 0; i < widget.lugares.length; i++) {
      final lugar = widget.lugares[i];
      final lat = lugar['lat'] as double;
      final lng = lugar['lng'] as double;

      markers.add(
        Marker(
          markerId: MarkerId('lugar_$i'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: lugar['nombre'] as String,
            snippet: lugar['direccion'] as String,
          ),
          icon: widget.type == 'restaurants'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
              : BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Configurar el estilo del mapa si es necesario
    // controller.setMapStyle(/* tu estilo JSON aquí */);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: _toledoCenter,
            zoom: 14.0,
          ),
          markers: markers,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          mapToolbarEnabled: false,
          compassEnabled: false,
          trafficEnabled: false,
          buildingsEnabled: true,
          indoorViewEnabled: false,
          mapType: MapType.normal,
          // Configuraciones adicionales
          minMaxZoomPreference: const MinMaxZoomPreference(10.0, 18.0),
          cameraTargetBounds: CameraTargetBounds(
            LatLngBounds(
              southwest: const LatLng(39.840, -4.060),
              northeast: const LatLng(39.885, -3.990),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
