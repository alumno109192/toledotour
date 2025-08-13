import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBannerWidget extends StatefulWidget {
  final bool showOnlyAfterContent;

  const AdBannerWidget({super.key, this.showOnlyAfterContent = true});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    // Solo cargar anuncios reales en dispositivos móviles (no en web)
    if (!kIsWeb) {
      _bannerAd = BannerAd(
        adUnitId: kDebugMode
            ? 'ca-app-pub-3940256099942544/6300978111' // ID de prueba
            : 'ca-app-pub-3765163856747312/1558214931', // Reemplaza con tu ID real de AdMob
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) => setState(() {}),
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
      )..load();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si showOnlyAfterContent es true, no mostrar durante carga o pantallas vacías
    if (widget.showOnlyAfterContent) {
      // Verificar que estamos en una página con contenido establecido
      final route = ModalRoute.of(context);
      if (route == null || route.settings.name == null) {
        return const SizedBox.shrink();
      }
    }

    // En web y modo debug, mostrar un banner simulado con contenido valioso
    if (kIsWeb && kDebugMode) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.blue[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue[200]!, width: 1),
        ),
        child: Column(
          children: [
            const Text(
              '🏛️ Descubre más sobre Toledo 🏛️',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Encuentra los mejores tours, restaurantes y actividades',
              style: TextStyle(fontSize: 14, color: Colors.blue[800]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // En web y modo release, no mostrar nada
    if (kIsWeb) return const SizedBox.shrink();

    // En móvil, mostrar el banner real si está cargado
    if (_bannerAd == null) return const SizedBox.shrink();
    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
