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

          // Añadir contenido adicional de valor para mejorar calidad de la página
          const SizedBox(height: 16),
          _buildAdditionalContent(context),
        ],
      ),
    );
  }

  Widget _buildAdditionalContent(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📖 Contexto Histórico',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getHistoricalContext(),
              style: const TextStyle(fontSize: 15, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              '🎯 Consejos para la Visita',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getVisitTips(),
              style: const TextStyle(fontSize: 15, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              '🏛️ Sitios Cercanos de Interés',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getNearbyAttractions(),
              style: const TextStyle(fontSize: 15, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  String _getHistoricalContext() {
    switch (title) {
      case 'Mezquita del Cristo de la Luz':
        return 'Construida en el año 999 d.C. durante el califato de Córdoba, esta mezquita es uno de los mejores ejemplos del arte islámico en Toledo. Su nombre original era "Bab-al-Mardum" y tras la reconquista cristiana en 1085, se añadió un ábside mudéjar. La leyenda cuenta que durante la entrada triunfal de Alfonso VI en Toledo, su caballo se arrodilló frente al muro donde se halló una imagen del Cristo iluminada por una lámpara que había ardido durante los 376 años de dominación musulmana.';

      case 'Museo de Santa Cruz':
        return 'Este edificio renacentista fue construido entre 1504 y 1514 como Hospital de Santa Cruz por orden del cardenal Mendoza. Diseñado por Enrique Egas y Alonso de Covarrubias, representa uno de los mejores ejemplos del plateresco español. Durante siglos sirvió como hospital y orfanato, y actualmente alberga importantes colecciones de arte que incluyen obras de El Greco, cerámica de Talavera y arqueología provincial.';

      case 'Sinagoga de Santa María la Blanca':
        return 'Construida a finales del siglo XII, esta sinagoga fue la mayor de las diez que llegó a tener la comunidad judía toledana. Su arquitectura mudéjar, con arcos de herradura sobre columnas octogonales y capiteles decorados con motivos vegetales, representa la síntesis artística de las tres culturas. En 1405 fue convertida en iglesia cristiana por San Vicente Ferrer, conservando sin embargo su estructura original.';

      case 'Museo del Greco':
        return 'Aunque no fue la casa real del pintor, este museo recrea el ambiente de una casa toledana del siglo XVI donde pudo haber vivido Doménikos Theotokópoulos "El Greco". El pintor cretense llegó a Toledo hacia 1577 y aquí desarrolló su estilo más personal. El museo, inaugurado en 1911, alberga obras fundamentales como "Vista y plano de Toledo" y la serie del Apostolado, que muestran la evolución artística del maestro.';

      case 'Mezquita de las Tornerías':
        return 'Esta pequeña mezquita del siglo XI formaba parte del barrio de artesanos especializados en torneado (tornerías). Su sobriedad arquitectónica contrasta con la riqueza decorativa de otras mezquitas toledanas, pero mantiene elementos característicos del arte califal como los arcos de herradura y la orientación hacia La Meca. Tras la reconquista fue convertida en la iglesia de San Sebastián.';

      case 'Museo Sefardí':
        return 'Ubicado en la Sinagoga del Tránsito, construida hacia 1357 por Samuel ha-Leví, tesorero de Pedro I el Cruel. Esta sinagoga representa el esplendor de la comunidad sefardí toledana antes de la expulsión de 1492. Sus muros conservan inscripciones en hebreo y árabe, y su rica decoración mudéjar incluye motivos geométricos y vegetales. El museo documenta la historia, cultura y tradiciones de los judíos españoles.';

      default:
        return 'Toledo, declarada Patrimonio de la Humanidad por la UNESCO en 1986, es conocida como la "Ciudad de las Tres Culturas" por haber sido durante siglos lugar de convivencia entre cristianos, musulmanes y judíos. Esta coexistencia dejó un legado arquitectónico y cultural único en el mundo.';
    }
  }

  String _getVisitTips() {
    switch (title) {
      case 'Mezquita del Cristo de la Luz':
        return 'Recomendamos visitarla en horario de mañana cuando la luz natural realza los detalles arquitectónicos. La entrada incluye una explicación audiovisual que contextualiza la historia del edificio. No olvides observar los restos arqueológicos visigodos en el interior y los detalles de la decoración islámica original.';

      case 'Museo de Santa Cruz':
        return 'Dedica al menos 2 horas para recorrer sus colecciones. La entrada es gratuita los domingos por la mañana para ciudadanos de la UE. No te pierdas la escalera plateresca de Covarrubias y las obras de El Greco en la planta superior. Consulta la programación de exposiciones temporales que suelen ser de gran calidad.';

      case 'Sinagoga de Santa María la Blanca':
        return 'La mejor hora para la visita es al mediodía cuando los rayos de sol atraviesan las ventanas superiores creando efectos de luz únicos. Observa detenidamente los capiteles de las columnas, cada uno es diferente. La acústica del espacio es excepcional, ideal si coincides con algún concierto o evento cultural.';

      case 'Museo del Greco':
        return 'Combina la visita con un paseo por el barrio judío. El museo ofrece audioguías en varios idiomas que enriquecen la experiencia. Presta especial atención a "Vista y plano de Toledo", una obra única que muestra la ciudad en el siglo XVII. Los jardines del museo ofrecen hermosas vistas del valle del Tajo.';

      case 'Mezquita de las Tornerías':
        return 'Al ser un espacio reducido, la visita es breve pero intensa. Solicita información sobre horarios especiales ya que a veces cierra por mantenimiento. Su proximidad a la Catedral permite combinar ambas visitas fácilmente. Fíjate en los detalles constructivos que muestran la influencia del arte califal.';

      case 'Museo Sefardí':
        return 'La visita se complementa perfectamente con la de Santa María la Blanca para entender la historia judía de Toledo. Los paneles explicativos son muy didácticos y hay material interactivo para niños. No pierdas la oportunidad de ver los objetos rituales sefardíes y los documentos históricos sobre la expulsión de 1492.';

      default:
        return 'Se recomienda llevar calzado cómodo ya que las calles de Toledo son empedradas y empinadas. Los horarios pueden variar según la temporada, consulta siempre antes de la visita. Muchos monumentos ofrecen descuentos para estudiantes, mayores y grupos.';
    }
  }

  String _getNearbyAttractions() {
    switch (title) {
      case 'Mezquita del Cristo de la Luz':
        return 'A 5 minutos caminando encuentras la Puerta de Bisagra y las murallas medievales. La Puerta del Sol está a solo 100 metros. Desde aquí puedes acceder fácilmente al Mirador del Valle para contemplar las mejores vistas panorámicas de Toledo. También está cerca el Convento de Santo Domingo, con restos visigodos y romanos.';

      case 'Museo de Santa Cruz':
        return 'Se encuentra en el corazón del casco histórico, a 2 minutos del Alcázar y a 5 minutos de la Catedral. La Plaza de Zocodover, centro neurálgico de la ciudad, está a un paso. Muy cerca también está la Calle Comercio con sus típicas tiendas de artesanía toledana y espadas damasquinadas.';

      case 'Sinagoga de Santa María la Blanca':
        return 'Forma parte del triángulo judío junto con el Museo Sefardí (Sinagoga del Tránsito) a 5 minutos y el Museo del Greco a 3 minutos. La Casa del Judío y los típicos miradores con vistas al Tajo están en la misma zona. Es el punto de partida perfecto para explorar el barrio judío medieval.';

      case 'Museo del Greco':
        return 'Está en el corazón del barrio judío, junto a la Sinagoga del Tránsito y muy cerca de Santa María la Blanca. Los Jardines del Museo ofrecen acceso directo al Paseo del Tránsito con espectaculares vistas del valle. La Casa del Greco (que no fue su casa real) está a pocos metros.';

      case 'Mezquita de las Tornerías':
        return 'Por su ubicación central, está a 3 minutos de la Catedral y del Ayuntamiento. La Plaza del Ayuntamiento con sus terrazas está muy cerca. Desde aquí se accede fácilmente a la Calle Ancha y sus comercios tradicionales. El Arco de la Sangre y la Calle Alfileritos están a un paso.';

      case 'Museo Sefardí':
        return 'Comparte zona con el Museo del Greco y Santa María la Blanca, formando el corazón del barrio judío. El Mirador de Samuel Leví ofrece vistas panorámicas del Tajo. Los restos de baños árabes están muy cerca, así como el conjunto de casas-cueva excavadas en la roca del acantilado.';

      default:
        return 'Toledo es una ciudad compacta donde todos los monumentos principales están a poca distancia. Se recomienda combinar varias visitas en la misma zona para optimizar el tiempo. El centro histórico está completamente peatonalizado, facilitando los desplazamientos.';
    }
  }
}
