import 'package:flutter/material.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:toledotour/destino_simple.dart';

class FreeTourPage extends StatelessWidget {
  const FreeTourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'free_tour')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Contenido editorial sobre Free Tours
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr(context, 'free_tour_intro_title'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  tr(context, 'free_tour_intro_text'),
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                Text(
                  tr(context, 'free_tour_benefits_title'),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  tr(context, 'free_tour_benefits_text'),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: freeTours.length,
              itemBuilder: (context, index) {
                final tour = freeTours[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinoPage(
                            title: tour['nombre']!,
                            description: tour['descripcion']!,
                            icon: '🚶‍♂️',
                            address: tour['ubicacion']!,
                            schedule: tour['horario']!,
                            price: 'GRATIS (propinas bienvenidas)',
                            extraInfo: tour['web']!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade400,
                                Colors.purple.shade600,
                              ],
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tour['nombre']!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      tour['horario']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tour['descripcion']!,
                                style: const TextStyle(fontSize: 16),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      'Punto de encuentro: ${tour['ubicacion']!}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.euro,
                                      size: 16,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'GRATIS',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // DISABLED: All ads removed for AdSense editorial content policy compliance
        ],
      ),
    );
  }
}

final List<Map<String, String>> freeTours = [
  {
    'nombre': 'Free Tour Toledo Histórico',
    'descripcion':
        'Descubre la historia de Toledo caminando por sus calles más emblemáticas. Un recorrido gratuito por los monumentos más importantes de la ciudad imperial, incluyendo la Catedral, el Alcázar y el barrio judío.',
    'ubicacion': 'Plaza de Zocodover',
    'horario': 'Lunes a Domingo: 11:00 y 17:00',
    'telefono': '+34 925 123 456',
    'web': 'https://freetoledo.com',
  },
  {
    'nombre': 'Free Tour Toledo de las Tres Culturas',
    'descripcion':
        'Conoce la convivencia de cristianos, musulmanes y judíos en Toledo medieval. Visitaremos las Sinagogas, las mezquitas y las iglesias que muestran el rico patrimonio multicultural de la ciudad.',
    'ubicacion': 'Sinagoga del Tránsito',
    'horario': 'Martes, Jueves y Sábados: 16:00',
    'telefono': '+34 925 234 567',
    'web': 'https://toledo3culturas.com',
  },
  {
    'nombre': 'Free Tour Toledo Subterráneo',
    'descripcion':
        'Explora los misterios ocultos bajo las calles de Toledo. Descubre cuevas, pasadizos y restos arqueológicos que cuentan la historia más secreta de la ciudad. Una experiencia única e inesperada.',
    'ubicacion': 'Cuevas de Hércules',
    'horario': 'Viernes y Sábados: 19:00',
    'telefono': '+34 925 345 678',
    'web': 'https://toledosubterraneo.com',
  },
  {
    'nombre': 'Free Tour Toledo Nocturno',
    'descripcion':
        'Vive la magia de Toledo al anochecer. Un paseo nocturno por las calles iluminadas de la ciudad, descubriendo leyendas, misterios y la belleza de los monumentos bajo las estrellas.',
    'ubicacion': 'Mirador del Valle',
    'horario': 'Viernes y Sábados: 21:30',
    'telefono': '+34 925 456 789',
    'web': 'https://toledonocturno.com',
  },
  {
    'nombre': 'Free Tour Gastronómico Toledo',
    'descripcion':
        'Descubre los sabores auténticos de Toledo mientras conoces su historia. Visitaremos mercados tradicionales, degustación de productos locales y aprenderás sobre la gastronomía castellano-manchega.',
    'ubicacion': 'Mercado de Abastos',
    'horario': 'Sábados y Domingos: 12:00',
    'telefono': '+34 925 567 890',
    'web': 'https://toledogastronomico.com',
  },
  {
    'nombre': 'Free Tour Toledo para Familias',
    'descripcion':
        'Un recorrido especialmente diseñado para familias con niños. Actividades interactivas, juegos y cuentos que harán que los pequeños se diviertan mientras aprenden sobre la historia de Toledo.',
    'ubicacion': 'Parque de la Vega',
    'horario': 'Domingos: 11:30',
    'telefono': '+34 925 678 901',
    'web': 'https://toledofamilias.com',
  },
];
