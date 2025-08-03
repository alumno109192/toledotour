import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:toledotour/contact_form_page.dart';
import 'ad_banner_widget.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'app_info')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Introducción de la app
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Sobre Toledo Tour',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Toledo Tour es la aplicación turística más completa para descubrir '
                            'todos los secretos de la Ciudad Imperial. Desarrollada por expertos '
                            'locales y guías turísticos oficiales, ofrece información actualizada '
                            'y verificada sobre monumentos, restaurantes, rutas naturales y '
                            'actividades nocturnas de Toledo.',
                            style: TextStyle(fontSize: 16, height: 1.6),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Características principales
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Características Principales',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildFeatureItem(
                            '🏛️',
                            'Guía Cultural Completa',
                            'Más de 50 monumentos catalogados con información histórica detallada',
                          ),
                          _buildFeatureItem(
                            '🍽️',
                            'Gastronomía Local',
                            'Restaurantes y bares recomendados con especialidades toledanas',
                          ),
                          _buildFeatureItem(
                            '🌿',
                            'Rutas Naturales',
                            'Senderos y espacios naturales para disfrutar del entorno',
                          ),
                          _buildFeatureItem(
                            '🌙',
                            'Vida Nocturna',
                            'Tours nocturnos, pubs y actividades para todas las edades',
                          ),
                          _buildFeatureItem(
                            '📍',
                            'Navegación GPS',
                            'Direcciones precisas e integración con Google Maps',
                          ),
                          _buildFeatureItem(
                            '🌍',
                            'Multiidioma',
                            'Disponible en español e inglés para turistas internacionales',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Por qué elegir Toledo Tour
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.verified,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '¿Por Qué Elegir Toledo Tour?',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '• Información verificada por guías oficiales de Toledo\n'
                            '• Contenido actualizado regularmente\n'
                            '• Diseño intuitivo y fácil de usar\n'
                            '• Funciona sin conexión a internet (próximamente)\n'
                            '• Recomendaciones personalizadas según tus intereses\n'
                            '• Soporte técnico en español e inglés\n'
                            '• Aplicación gratuita sin límites de uso',
                            style: TextStyle(fontSize: 16, height: 1.8),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Información de la app
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.info, size: 24),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  tr(context, 'app_information'),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            tr(context, 'app_name'),
                            packageInfo?.appName ?? 'Toledo Tour',
                          ),
                          _buildInfoRow(
                            tr(context, 'version'),
                            '${packageInfo?.version ?? '1.0.0'}+${packageInfo?.buildNumber ?? '1'}',
                          ),
                          _buildInfoRow(
                            tr(context, 'email'),
                            'yesod3d@gmail.com',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botón de contacto
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactFormPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.mail),
                      label: Text(tr(context, 'contact_us')),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AdBannerWidget(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String emoji, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
