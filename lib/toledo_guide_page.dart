import 'package:flutter/material.dart';
import 'package:toledotour/l10n/translation_helper.dart';

class ToledoGuidePage extends StatelessWidget {
  const ToledoGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final guides = [
      {
        'title': '¿Qué ver en Toledo en un día?',
        'titleKey': 'guide_one_day_title',
        'summary':
            'Itinerario optimizado para conocer lo esencial de Toledo en una jornada',
        'summaryKey': 'guide_one_day_summary',
        'content': _getOneDayGuideContent(),
        'image': '🏛️',
      },
      {
        'title': 'Historia de la Gastronomía Toledana',
        'titleKey': 'guide_gastronomy_title',
        'summary':
            'Descubre los orígenes y evolución de la cocina tradicional toledana',
        'summaryKey': 'guide_gastronomy_summary',
        'content': _getGastronomyGuideContent(),
        'image': '🍽️',
      },
      {
        'title': 'Las Tres Culturas en Toledo',
        'titleKey': 'guide_cultures_title',
        'summary':
            'Un recorrido por la convivencia histórica de cristianos, musulmanes y judíos',
        'summaryKey': 'guide_cultures_summary',
        'content': _getCulturesGuideContent(),
        'image': '⛪',
      },
      {
        'title': 'Rutas por Temporadas',
        'titleKey': 'guide_seasons_title',
        'summary':
            'Las mejores épocas y actividades para visitar Toledo según la estación',
        'summaryKey': 'guide_seasons_summary',
        'content': _getSeasonsGuideContent(),
        'image': '🌸',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'toledo_guides')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Contenido editorial sobre las guías de Toledo
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
                  'Guías Completas de Toledo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Toledo, declarada Patrimonio de la Humanidad por la UNESCO en 1986, '
                  'es una ciudad única que requiere conocimiento especializado para '
                  'apreciar toda su riqueza histórica y cultural. Nuestras guías completas '
                  'han sido elaboradas por historiadores y guías turísticos oficiales, '
                  'ofreciendo información detallada y contextualizada sobre los aspectos '
                  'más relevantes de la Ciudad Imperial.',
                  style: TextStyle(fontSize: 16, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Cada guía profundiza en temas específicos, desde itinerarios optimizados '
                  'hasta análisis históricos de la convivencia de las Tres Culturas, '
                  'pasando por la evolución de la gastronomía toledana y recomendaciones '
                  'estacionales para sacar el máximo provecho a tu visita.',
                  style: TextStyle(fontSize: 16, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),

          // Contenido principal
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuideDetailPage(
                            title: guide['title'] as String,
                            content: guide['content'] as String,
                            image: guide['image'] as String,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Icono/Emoji
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                guide['image'] as String,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Contenido
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  guide['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  guide['summary'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Flecha
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static String _getOneDayGuideContent() {
    return '''
# ¿Qué ver en Toledo en un día?

Toledo, conocida como la "Ciudad Imperial" y "Ciudad de las Tres Culturas", puede visitarse en un día siguiendo este itinerario optimizado que te permitirá conocer sus monumentos más emblemáticos.

## Mañana (9:00 - 13:00)

### 1. Plaza de Zocodover (9:00 - 9:30)
Comienza tu visita en el corazón de Toledo. Esta plaza ha sido el centro neurálgico de la ciudad desde época árabe. Aquí podrás:
- Admirar la arquitectura de los edificios circundantes
- Visitar la Oficina de Turismo para mapas y folletos
- Tomar un café en una de las terrazas tradicionales

### 2. Mezquita del Cristo de la Luz (9:45 - 10:30)
A solo 5 minutos caminando, esta joya del siglo X es una de las mezquitas mejor conservadas de España. Su visita incluye:
- Arquitectura califal original
- Frescos cristianos posteriores
- Historia de la convivencia de culturas

### 3. Catedral Primada (10:45 - 12:30)
La obra cumbre del gótico español te sorprenderá con:
- El retablo mayor, considerado una obra maestra
- El coro con sus sillerías talladas
- La sacristía con cuadros de El Greco, Velázquez y Goya
- El tesoro catedralicio

### 4. Mirador del Valle (12:45 - 13:00)
Para las mejores vistas panorámicas de Toledo, perfectas para fotografías.

## Almuerzo (13:00 - 15:00)
Disfruta de la gastronomía toledana en uno de los restaurantes tradicionales del casco histórico. Prueba:
- Perdiz estofada con chocolate
- Carcamusas (guiso típico toledano)
- Mazapán de postre

## Tarde (15:00 - 18:00)

### 5. Sinagoga de Santa María la Blanca (15:00 - 15:45)
Este excepcional ejemplo de arquitectura mudéjar te mostrará:
- Arcos de herradura sobre columnas octogonales
- Decoración geométrica islámica
- Historia de la comunidad judía toledana

### 6. Sinagoga del Tránsito y Museo Sefardí (16:00 - 17:00)
Complementa tu conocimiento de la cultura sefardí:
- Yeserías polícromas únicas
- Colección de objetos rituales judíos
- Manuscritos hebreos medievales

### 7. Casa y Museo del Greco (17:15 - 18:00)
Finaliza conociendo al pintor que inmortalizó Toledo:
- "Vista y plano de Toledo"
- Recreación de su casa-taller
- Evolución de su estilo pictórico

## Consejos Prácticos

### Mejor época para visitar:
- **Primavera y otoño**: Temperaturas agradables
- **Invierno**: Menos turistas, pero más frío
- **Verano**: Mucho calor, mejor madrugar

### Transporte:
- **A pie**: El casco histórico es peatonal
- **Escaleras mecánicas**: Facilitan el acceso desde el parking
- **Tren turístico**: Para personas con movilidad reducida

### Entradas:
- **Pulsera turística**: Acceso a varios monumentos con descuento
- **Compra online**: Evita colas en temporada alta

### Qué llevar:
- Calzado cómodo (calles empedradas)
- Protección solar en verano
- Cámara de fotos
- Botella de agua

## Alternativas si tienes más tiempo

Si dispones de dos días, añade:
- **Día 2 mañana**: Monasterio de San Juan de los Reyes y Hospital de Tavera
- **Día 2 tarde**: Iglesia de Santo Tomé y las Termas Romanas

Toledo es una ciudad que se disfruta paseando sin prisa, pero este itinerario te asegura conocer lo esencial de su rico patrimonio histórico y cultural en una jornada inolvidable.
''';
  }

  static String _getGastronomyGuideContent() {
    return '''
# Historia de la Gastronomía Toledana

La cocina toledana es un reflejo viviente de la rica historia de la ciudad, donde la confluencia de tres culturas ha creado una tradición gastronómica única que perdura hasta nuestros días.

## Orígenes Históricos

### Época Romana y Visigoda
Los primeros asentamientos en Toledo ya mostraban una preferencia por:
- **Cultivo de cereales** en las vegas del Tajo
- **Ganadería ovina** en los montes circundantes
- **Pesca fluvial** en el río Tajo
- **Apicultura** que dio origen a la tradición del mazapán

### Influencia Árabe (711-1085)
La llegada de los musulmanes transformó la gastronomía toledana:
- **Nuevas especias**: azafrán, canela, comino
- **Técnicas de conservación**: escabeches y salazones
- **Dulcería**: origen del mazapán con almendras
- **Cultivos**: introducción de nuevas verduras y frutas

### Aporte Judío
La comunidad sefardí enriqueció la cocina con:
- **Técnicas de sacrificio** que influyeron en el tratado de carnes
- **Repostería sin manteca** por las leyes kosher
- **Conservas** y métodos de almacenamiento
- **Vinos y vinagres** de gran calidad

### Síntesis Cristiana
Tras la Reconquista, se fusionaron todas las tradiciones:
- **Cocina conventual**: dulces y conservas
- **Gastronomía aristocrática**: caza y carnes nobles
- **Tradición popular**: potajes y guisos

## Platos Tradicionales

### Carcamusas
**Origen**: Siglo XIX, plato obrero de las fábricas de armas
**Ingredientes**: Cerdo, tomate, guisantes, especias
**Preparación**: Guiso lento que permite que los sabores se concentren
**Curiosidad**: Su nombre deriva de "cara y musas" por los trozos de carne

### Perdiz Estofada con Chocolate
**Origen**: Época de Carlos I, influencia borgoñona
**Ingredientes**: Perdiz, chocolate, vino, especias
**Técnica**: Estofado lento que tierniza la carne de caza
**Tradición**: Plato navideño en las familias toledanas

### Cochifrito Toledano
**Origen**: Romano, perfeccionado en época árabe
**Ingredientes**: Cordero lechal, ajo, pimentón, vinagre
**Preparación**: Fritura lenta que dora sin secar
**Estacionalidad**: Primavera, época de cordero lechal

### Galianos
**Origen**: Dulce árabe adaptado por conventos
**Ingredientes**: Miel, harina, aceite, anís
**Forma**: Lazos fritos bañados en miel
**Ocasión**: Cuaresma y fiestas religiosas

## El Mazapán Toledano

### Historia
La tradición del mazapán en Toledo se remonta al siglo XI:
- **Leyenda**: Creado durante la hambruna tras la batalla de Navas de Tolosa
- **Realidad**: Evolución de dulces árabes con almendra
- **Perfeccionamiento**: En conventos durante los siglos XVI-XVII

### Elaboración Tradicional
1. **Selección**: Almendras marcona de la mejor calidad
2. **Molido**: Tradicionalmente en piedra
3. **Amasado**: Con azúcar en proporciones exactas
4. **Moldeado**: Formas tradicionales (anguila, rosa, hueso santo)
5. **Cocción**: Horno de leña para el dorado perfecto

### Variedades Toledanas
- **Anguila**: Forma alargada, la más tradicional
- **Rosa**: Con forma de flor, decorada
- **Hueso de santo**: Relleno de dulce de yema
- **Figuritas**: Formas navideñas y religiosas

## Vinos de Toledo

### Denominación de Origen
Reconocida en 1990, incluye:
- **Variedades tintas**: Tempranillo, Cabernet Sauvignon, Merlot
- **Variedades blancas**: Airén, Macabeo, Chardonnay
- **Características**: Vinos con cuerpo, adaptados al clima continental

### Bodegas Históricas
- **Cigarrales**: Fincas tradicionales con bodegas centenarias
- **Cooperativas**: Unión de pequeños productores
- **Bodegas modernas**: Tecnología aplicada a tradición

## Restaurantes Emblemáticos

### Casas Centenarias
- **Venta de Aires** (400+ años): El más antiguo de Castilla-La Mancha
- **Posada de la Hermandad**: Donde comieron Cervantes y Lope de Vega
- **Casas históricas**: Convertidas en restaurantes de alta cocina

### Evolución Gastronómica
- **Siglo XX**: Cocina familiar y casera
- **Siglo XXI**: Fusión de tradición e innovación
- **Actualidad**: Chefs que reinterpretan recetas ancestrales

## Productos Locales

### De la Tierra
- **Azafrán**: De los campos manchegos cercanos
- **Queso manchego**: De las ganaderías locales
- **Aceite de oliva**: De las almazaras tradicionales
- **Miel**: De colmenas en los montes toledanos

### Conservas Tradicionales
- **Membrillo**: Dulce de las quintas toledanas
- **Conservas de tomate**: Técnica árabe perfeccionada
- **Escabeches**: Perdices y otras carnes de caza
- **Embutidos**: Chorizo y morcilla caseros

## La Gastronomía Actual

### Restauración Moderna
Los chef toledanos actuales mantienen viva la tradición:
- **Técnicas ancestrales** aplicadas con precisión moderna
- **Productos locales** de calidad certificada
- **Innovación** respetuosa con la tradición
- **Presentación** que honra tanto al producto como al comensal

### Turismo Gastronómico
Toledo se ha consolidado como destino culinario:
- **Rutas gastronómicas** temáticas
- **Jornadas culinarias** estacionales
- **Mercados tradicionales** que mantienen la autenticidad
- **Formación culinaria** que preserva las técnicas tradicionales

La gastronomía toledana no es solo alimentación, sino cultura viva que cuenta la historia de una ciudad donde cada plato es testimonio de siglos de convivencia y tradición.
''';
  }

  static String _getCulturesGuideContent() {
    return '''
# Las Tres Culturas en Toledo

Toledo ha sido conocida históricamente como la "Ciudad de las Tres Culturas" por la extraordinaria convivencia que durante siglos mantuvieron cristianos, musulmanes y judíos en sus calles, creando un legado cultural único en el mundo.

## El Contexto Histórico

### La Toledo Visigoda (siglo VI-VIII)
Antes de la conquista musulmana, Toledo ya era una ciudad importante:
- **Capital del Reino Visigodo** desde el siglo VI
- **Centro religioso**: Concilios de Toledo (589-702)
- **Primer cristianismo hispano**: Bases de la tradición cristiana posterior
- **Arquitectura**: Iglesias visigodas que influirían en el estilo posterior

### La Llegada del Islam (711)
La conquista musulmana transformó la ciudad:
- **Tolaitola**: Nombre árabe de Toledo
- **Capital de la Cora**: Provincia administrativa musulmana
- **Centro de saber**: Traductores y bibliotecas
- **Arquitectura islámica**: Mezquitas y alcázares

## La Convivencia Medieval

### El Sistema de las Tres Religiones
Entre los siglos X-XV se desarrolló un modelo único:

#### **Cristianos (Mozárabes)**
- **Definición**: Cristianos bajo dominio musulmán
- **Privilegios**: Libertad de culto y auto-gobierno
- **Contribución**: Mantenimiento de tradiciones visigodas
- **Lugares**: Iglesias como San Sebastián y Santa Eulalia

#### **Musulmanes**
- **Población mayoritaria** hasta el siglo XI
- **Organización**: Barrios con mezquitas propias
- **Actividades**: Artesanía, comercio, agricultura
- **Legado**: Mezquitas convertidas posteriormente

#### **Judíos (Sefardíes)**
- **Comunidad próspera** desde el siglo X
- **Actividades**: Medicina, filosofía, comercio, finanzas
- **Organización**: Juderías con sinagogas y escuelas
- **Época dorada**: Siglos XI-XIII

### Los Barrios Históricos

#### **Judería Vieja (Norte)**
- **Ubicación**: Zona alta de la ciudad
- **Monumentos**: Sinagoga de Santa María la Blanca
- **Características**: Calles estrechas, casas señoriales
- **Actividad**: Comercio y artesanía de lujo

#### **Judería Nueva (Sur)**
- **Ubicación**: Cerca del Tajo
- **Monumentos**: Sinagoga del Tránsito
- **Características**: Barrio más humilde
- **Actividad**: Oficios artesanales

#### **Barrio Mudéjar**
- **Ubicación**: Zonas dispersas por la ciudad
- **Características**: Población musulmana bajo dominio cristiano
- **Arquitectura**: Estilo mudéjar en iglesias
- **Actividades**: Construcción y decoración

## Personajes Emblemáticos

### Periodo de Esplendor (siglos XI-XIII)

#### **Alfonso VI el Bravo (1040-1109)**
- **Reconquista**: Toma Toledo en 1085
- **Política**: Respeto a las tres religiones
- **Legado**: Modelo de tolerancia medieval

#### **Alfonso X el Sabio (1221-1284)**
- **Escuela de Traductores**: Apogeo cultural
- **Convivencia**: Colaboración entre las tres culturas
- **Obras**: Síntesis del saber universal

#### **Petrus Alfonsi (1062-1140)**
- **Origen**: Judío converso al cristianismo
- **Obra**: "Disciplina Clericalis"
- **Importancia**: Puente entre culturas

#### **Averroes (1126-1198)**
- **Paso por Toledo**: Traductor y filósofo
- **Obra**: Comentarios a Aristóteles
- **Influencia**: En la filosofía cristiana posterior

### La Escuela de Traductores

#### **Primera Época (siglo XII)**
- **Director**: Raimundo de Sauvetât
- **Método**: Del árabe al latín vía romance
- **Traductores**: Gerard de Cremona, Domingo Gundisalvo
- **Obras**: Aristóteles, Ptolomeo, Al-Juarismi

#### **Segunda Época (siglo XIII)**
- **Impulsor**: Alfonso X el Sabio
- **Innovación**: Traducción directa al castellano
- **Colaboradores**: Judíos, musulmanes, cristianos
- **Resultado**: Nacimiento de la prosa castellana

## Monumentos de las Tres Culturas

### Legado Islámico

#### **Mezquita del Cristo de la Luz**
- **Construcción**: 999-1000
- **Estilo**: Califal tardío
- **Conversión**: Iglesia en 1187
- **Singularidad**: Única mezquita intacta de Toledo

#### **Mezquita de las Tornerías**
- **Época**: Siglo XI
- **Características**: Pequeña mezquita de barrio
- **Estado**: Restos arqueológicos visitables
- **Importancia**: Testimonio de la vida cotidiana musulmana

### Legado Judío

#### **Sinagoga de Santa María la Blanca**
- **Construcción**: Siglo XII (reconstruida en XIV)
- **Estilo**: Mudéjar
- **Características**: Cinco naves, arcos de herradura
- **Conversión**: Iglesia en 1405

#### **Sinagoga del Tránsito**
- **Construcción**: 1357
- **Promotor**: Samuel ha-Leví
- **Decoración**: Yeserías con inscripciones hebráicas
- **Actual**: Museo Sefardí

### Legado Cristiano

#### **Catedral Primada**
- **Construcción**: 1226-1493
- **Estilo**: Gótico francés
- **Singularidad**: Sobre antigua mezquita mayor
- **Tesoros**: Obras de las tres tradiciones artísticas

#### **Iglesias Mudéjares**
- **Santiago del Arrabal**: Ejemplo perfecto de mudéjar toledano
- **Santo Tomé**: Alberga "El Entierro del Conde Orgaz"
- **San Román**: Museo de los Concilios y Cultura Visigoda

## El Arte Mudéjar

### Definición y Características
El arte mudéjar es la síntesis perfecta de las tres culturas:
- **Artistas**: Musulmanes trabajando para señores cristianos
- **Técnicas**: Islámicas aplicadas a necesidades cristianas
- **Materiales**: Ladrillo, yeso, madera, cerámica
- **Decoración**: Geométrica y vegetal, sin figuras

### Elementos Distintivos
- **Arcos**: Herradura, lobulados, mixtilíneos
- **Torres**: Campanarios con estructura de minarete
- **Decoración**: Sebka, lacería, inscripciones
- **Techumbres**: Artesonados con decoración geométrica

## La Vida Cotidiana

### Organización Social

#### **Barrios Diferenciados**
- **Cristiano**: Zona de la catedral y alcázar
- **Judío**: Juderías con autonomía administrativa
- **Musulmán**: Barrios mudéjares integrados

#### **Actividades Económicas**
- **Cristianos**: Nobleza, clero, agricultura
- **Judíos**: Medicina, finanzas, traducción, artesanía de lujo
- **Musulmanes**: Construcción, cerámica, textiles, agricultura

### Intercambio Cultural

#### **Lenguas**
- **Árabe**: Lengua de cultura y ciencia
- **Hebreo**: Lengua religiosa y literaria judía
- **Latín**: Lengua del cristianismo y documentos
- **Romance**: Lengua popular que evolucionó al castellano

#### **Festividades Compartidas**
- **Mercados**: Puntos de encuentro de las tres comunidades
- **Fiestas**: Respeto mutuo en celebraciones religiosas
- **Convites**: Banquetes inter-religiosos en ocasiones especiales

## El Declive y la Transformación

### Los Decretos de Expulsión

#### **1492: Expulsión de los Judíos**
- **Causa**: Política de unificación religiosa de los Reyes Católicos
- **Consecuencias**: Pérdida de conocimiento y riqueza
- **Opciones**: Conversión, exilio o muerte
- **Legado**: Judeoconversos y cripto-judaísmo

#### **1502-1526: Conversión Forzosa de Mudéjares**
- **Proceso**: Gradual pérdida de derechos
- **Resultado**: Moriscos (musulmanes conversos)
- **Final**: Expulsión definitiva en 1609
- **Impacto**: Fin de la Toledo multicultural

### La Nueva Toledo

#### **Siglo XVI: Ciudad Imperial**
- **Capital**: Del Imperio de Carlos I
- **Transformación**: De multicultural a exclusivamente cristiana
- **Arte**: Renacimiento y Manierismo
- **Personajes**: El Greco y su visión mística de Toledo

## Legado Actual

### Patrimonio Material
- **Monumentos**: Testimonio físico de la convivencia
- **Urbanismo**: Trazado medieval preservado
- **Artesanía**: Técnicas transmitidas por generaciones
- **Gastronomía**: Fusión de tradiciones culinarias

### Patrimonio Inmaterial
- **Tolerancia**: Modelo histórico de convivencia
- **Multiculturalismo**: Precedente de sociedades plurales
- **Diálogo interreligioso**: Experiencia histórica única
- **Síntesis cultural**: Creación de identidad común

### Toledo Contemporánea
La ciudad actual honra su legado multicultural:
- **Turismo cultural**: Valoración de la diversidad histórica
- **Investigación**: Centro de estudios sobre convivencia
- **Educación**: Modelo pedagógico de tolerancia
- **Eventos**: Recreación de la época de las tres culturas

Toledo sigue siendo, en el siglo XXI, un ejemplo vivo de cómo la diversidad cultural puede crear una síntesis única y enriquecedora, haciendo de la diferencia una fuente de riqueza compartida.
''';
  }

  static String _getSeasonsGuideContent() {
    return '''
# Rutas por Temporadas en Toledo

Toledo ofrece experiencias únicas durante todo el año. Cada estación aporta su propio encanto a la ciudad imperial, desde los colores primaverales hasta los cielos despejados del invierno. Descubre cuándo y cómo disfrutar al máximo de cada temporada.

## Primavera en Toledo (Marzo - Mayo)

### ¿Por qué visitar en primavera?
- **Temperaturas ideales**: 15-22°C, perfectas para caminar
- **Menor afluencia**: Antes del pico turístico veraniego
- **Naturaleza florecida**: Jardines y cigarrales en su máximo esplendor
- **Días largos**: Más tiempo para disfrutar de las visitas

### Actividades recomendadas

#### **Ruta de los Jardines Primaverales**
**Duración**: Día completo
**Recorrido**:
1. **Cigarrales**: Fincas históricas con jardines centenarios
2. **Paseo del Miradero**: Vistas panorámicas con almendros en flor
3. **Jardín del Hospital de Tavera**: Jardín renacentista restaurado
4. **Huerta del Rey**: Espacio verde junto al Tajo

#### **Ruta de Senderismo: Valle del Tajo**
**Distancia**: 8 km
**Dificultad**: Fácil
**Highlights**:
- Senda ecológica del Tajo
- Observación de aves migratorias
- Picnic en áreas habilitadas
- Fotografía de paisaje

### Eventos primaverales
- **Semana Santa**: Procesiones declaradas de Interés Turístico
- **Festival de Cine Social**: Cine al aire libre
- **Feria de Artesanía**: Productos locales en Plaza de Zocodover

### Consejos prácticos
- **Ropa**: Capas, puede hacer fresco por las mañanas
- **Reservas**: Hotels más baratos que en verano
- **Horarios**: Monumentos amplían horarios

## Verano en Toledo (Junio - Agosto)

### Características estivales
- **Temperaturas**: 25-35°C (máximas hasta 40°C)
- **Afluencia**: Temporada alta turística
- **Horarios especiales**: Apertura nocturna de monumentos
- **Eventos culturales**: Festival de música y teatro

### Estrategias para el calor

#### **Ruta Matutina (6:00 - 11:00)**
**Por qué temprano**: Evitar las horas de máximo calor
**Recorrido sugerido**:
1. **6:00 - 7:00**: Mirador del Valle (amanecer)
2. **7:30 - 9:00**: Catedral (primera visita)
3. **9:00 - 10:00**: Mezquita del Cristo de la Luz
4. **10:00 - 11:00**: Descanso en cafetería con aire acondicionado

#### **Ruta Vespertina (18:00 - 22:00)**
**Ventajas**: Luz dorada, temperaturas más suaves
**Actividades**:
- **18:00 - 19:30**: Sinagogas del barrio judío
- **19:30 - 20:30**: Paseo por calles estrechas (sombra natural)
- **20:30 - 22:00**: Cena en terraza con vistas

### Experiencias exclusivas de verano
- **Toledo Nights**: Visitas nocturnas a monumentos iluminados
- **Conciertos en el Alcázar**: Música clásica al atardecer
- **Mercado Cervantino**: Recreación histórica con ambiente medieval

### Refugios del calor
- **Museos climatizados**: Santa Cruz, Sefardí, El Greco
- **Iglesias frescas**: Santo Tomé, San Román, Santiago del Arrabal
- **Zonas de sombra**: Calles estrechas del casco histórico
- **Terrazas cubiertas**: Restaurantes con aire acondicionado

## Otoño en Toledo (Septiembre - Noviembre)

### El otoño dorado
- **Temperaturas**: 18-25°C en septiembre, 8-18°C en noviembre
- **Paisajes**: Colores ocres en cigarrales y alrededores
- **Luz especial**: Atardeceres espectaculares
- **Gastronomía**: Temporada de caza y setas

### Rutas otoñales especiales

#### **Ruta de los Colores Otoñales**
**Mejor época**: Octubre-noviembre
**Recorrido fotográfico**:
1. **Cigarrales**: Viñedos en colores dorados
2. **Ribera del Tajo**: Álamos y chopos amarillos
3. **Mirador de la Cornisa**: Atardecer sobre la ciudad
4. **Puente de San Martín**: Reflejos en el río

#### **Ruta Gastronómica Estacional**
**Especialidades otoñales**:
- **Perdiz con chocolate**: Plato tradicional de caza
- **Setas de los Montes de Toledo**: Níscalos y boletus
- **Migas manchegas**: Plato reconfortante
- **Vino nuevo**: De las bodegas locales

### Eventos culturales
- **Semana Cervantina**: Homenaje al autor del Quijote
- **Festival de Órgano**: Música sacra en la Catedral
- **Jornadas Gastronómicas**: Menús especiales en restaurantes

### Actividades recomendadas
- **Senderismo en los Montes**: Menos calor, paisajes coloridos
- **Visitas tranquilas**: Menos turistas, más intimidad
- **Fotografía**: Luz ideal para capturar la ciudad
- **Catas de vino**: Temporada de vendimia

## Invierno en Toledo (Diciembre - Febrero)

### El encanto invernal
- **Temperaturas**: 2-12°C
- **Ventajas**: Cielos despejados, menos multitudes
- **Ambiente**: Tranquilidad, Toledo más auténtico
- **Precios**: Ofertas en hoteles y restaurantes

### Experiencias invernales únicas

#### **Ruta de los Interiores Cálidos**
**Perfecta para días fríos**:
1. **Catedral**: 2-3 horas explorando cada rincón
2. **Museo de Santa Cruz**: Arte en ambiente climatizado
3. **Iglesia de Santo Tomé**: "El Entierro del Conde Orgaz"
4. **Posadas tradicionales**: Comida caliente junto al fuego

#### **Toledo Navideño**
**Diciembre - Enero**:
- **Belén Monumental**: Uno de los más grandes de España
- **Mercado Navideño**: Artesanía y productos típicos
- **Dulces tradicionales**: Mazapán recién hecho
- **Conciertos navideños**: En iglesias históricas

### Actividades de interior
- **Talleres artesanales**: Aprender técnicas tradicionales
- **Catas gastronómicas**: Productos de temporada
- **Conferencias culturales**: Centros culturales activos
- **Termas romanas**: Restos arqueológicos bajo techo

### Ventajas del invierno
- **Fotografía**: Luces y sombras dramáticas
- **Autenticidad**: Toledo sin masificación turística
- **Contemplación**: Tiempo para detalles y reflexión
- **Economía**: Mejores precios en alojamiento

## Eventos Anuales por Temporadas

### Calendario Cultural Completo

#### **Primavera**
- **Marzo**: Semana Santa (fechas variables)
- **Abril**: Feria del Libro
- **Mayo**: Noche de los Museos

#### **Verano**
- **Junio**: Corpus Christi (tradición centenaria)
- **Julio**: Festival de Música de Toledo
- **Agosto**: Noche Toledana (eventos nocturnos)

#### **Otoño**
- **Septiembre**: Jornadas Europeas del Patrimonio
- **Octubre**: Semana Cervantina
- **Noviembre**: Festival de Cine Social

#### **Invierno**
- **Diciembre**: Belén Monumental
- **Enero**: Cabalgata de Reyes
- **Febrero**: Carnaval Toledano

## Consejos Generales por Temporada

### Reservas y planificación
- **Primavera/Otoño**: Reservar con 2-3 semanas de antelación
- **Verano**: Reservar con 1-2 meses de antelación
- **Invierno**: Reservas de última hora posibles

### Equipaje recomendado

#### **Primavera/Otoño**
- Ropa de capas
- Calzado cómodo impermeable
- Chaqueta ligera
- Paraguas compacto

#### **Verano**
- Ropa ligera de colores claros
- Protección solar (crema, gorra, gafas)
- Botella de agua reutilizable
- Calzado transpirable

#### **Invierno**
- Abrigo cálido
- Guantes y bufanda
- Calzado antideslizante
- Ropa térmica para exteriores

### Horarios estacionales

#### **Primavera/Verano**
- Monumentos: 10:00-18:00/19:00
- Restaurantes: Terrazas hasta tarde
- Comercios: Horario ampliado

#### **Otoño/Invierno**
- Monumentos: 10:00-17:00/18:00
- Restaurantes: Horarios reducidos
- Comercios: Cierre más temprano

Toledo es una ciudad para todas las estaciones. Cada época del año revela aspectos diferentes de su personalidad, desde la exuberancia primaveral hasta la serena belleza invernal. La clave está en adaptar tu visita a las características de cada temporada para disfrutar al máximo de esta joya del patrimonio mundial.
''';
  }
}

class GuideDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String image;

  const GuideDetailPage({
    super.key,
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // DISABLED: All ads removed for AdSense editorial content policy compliance

          // Contenido del artículo
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen/Icono del artículo
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          image,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Título
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Contenido del artículo
                  Text(
                    content,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
