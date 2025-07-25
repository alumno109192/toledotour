import 'package:flutter/material.dart';

const Map<String, Map<String, String>> translations = {
  'es': {
    'title': 'Toledo Tour',
    'restaurants': 'Restaurantes',
    'bars': 'Bares',
    'restaurant_map': 'Mapa de Restaurantes',
    'your_location': 'Tu ubicación',
    'current_position': 'Posición actual',
    'center_on_map': 'Centrar en mapa',
    'directions': 'Indicaciones',
    'my_location': 'Mi ubicación',
    'refresh': 'Actualizar',
    'free_tour': 'Free Tour',
    'how_to_get': 'Cómo llegar',
    'navigation_error': 'Error de localización',
    'error_opening_maps': 'Error al abrir Google Maps',
    'permission_denied': 'Permiso de ubicación denegado',
    'permission_denied_permanently':
        'Debes habilitar el permiso de ubicación desde los ajustes del dispositivo para usar esta función.',
    'location_needed':
        'Para usar la navegación necesitas conceder el permiso de ubicación en los ajustes del dispositivo.',
    'close': 'Cerrar',
    'cultural_tourism': 'Turismo cultural',
    'nature': 'Naturaleza',
    'nightlife': 'Ocio nocturno',
    'gastronomy': 'Gastronomía',
    'error': 'Error',
    'ok': 'OK',
    'rest_adolfo_desc': 'Cocina tradicional toledana con toques modernos.',
    'rest_laorza_desc':
        'Restaurante acogedor con cocina castellana y carta de vinos.',
    'rest_alfileritos_desc': 'Cocina de autor en un edificio histórico.',
    'rest_ventaaires_desc': 'El restaurante más antiguo de Castilla-La Mancha.',
    'rest_ermita_desc': 'Cocina tradicional con vistas panorámicas.',
    'rest_clandestina_desc': 'Cocina creativa y ambiente moderno.',
    'rest_locum_desc': 'Cocina de autor en casa histórica.',
    'rest_fabrica_desc': 'Cocina mediterránea en hotel boutique.',
    'rest_albero_desc': 'Cocina manchega y carnes a la brasa.',
    'rest_cave_desc': 'Cocina internacional y tapas.',
    'bar_abadia_desc':
        'Taberna típica con platos manchegos y cervezas artesanas.',
    'bar_botero_desc': 'Tapas creativas y cócteles en un ambiente moderno.',
    'bar_trebol_desc': 'Famosa por sus carcamusas y cervezas propias.',
    'bar_malquerida_desc': 'Bar de tapas y raciones en el casco histórico.',
    'bar_ludena_desc': 'Tradicional, famoso por sus carcamusas.',
    'bar_skala_desc': 'Tapas y ambiente local.',
    'bar_elpez_desc': 'Tapas y copas en ambiente alternativo.',
    'bar_elforo_desc': 'Tapas variadas y terraza.',
    'bar_rinconjuan_desc': 'Tapas y vinos.',
    'bar_tabernita_desc': 'Tapas y ambiente acogedor.',
    'ruta_valle_desc':
        'Recorrido panorámico por el Valle de Toledo con vistas al casco histórico.',
    'ruta_barrancas_desc':
        'Impresionantes cortados arcillosos junto al embalse de Castrejón.',
    'ruta_senda_tajo_desc':
        'Sendero a orillas del río Tajo, ideal para paseos familiares.',
    'ruta_cigarrales_desc':
        'Ruta entre fincas antiguas y jardines típicos toledanos.',
    'ruta_piedra_rey_desc': 'Ruta circular con leyendas y vistas al río Tajo.',
    'ruta_montes_desc': 'Excursión por la sierra con flora y fauna autóctona.',
    'noche_magico_desc':
        'Recorrido guiado por las leyendas y misterios de la ciudad iluminada.',
    'noche_fantasmas_desc':
        'Tour nocturno por los rincones más enigmáticos de Toledo.',
    'noche_circulo_desc':
        'Discoteca situada en una antigua iglesia, ambiente único y música variada.',
    'noche_picaro_desc':
        'Sala de conciertos y discoteca con programación cultural.',
    'noche_nuit_desc': 'Discoteca moderna con DJs y fiestas temáticas.',
    'noche_candil_desc': 'Salón de baile con clases y música en vivo.',
    'noche_ultimo_desc': 'Pub con ambiente alternativo y música indie.',
    'noche_leyenda_desc':
        'Paseo nocturno por los lugares más legendarios de la ciudad.',
    'cultural_cristo_desc':
        'Una de las mezquitas mejor conservadas de la ciudad.',
    'cultural_santacruz_desc': 'Museo con arte y arqueología de Toledo.',
    'cultural_sinagoga_desc': 'Antigua sinagoga convertida en iglesia.',
    'cultural_greco_desc': 'Museo dedicado al pintor El Greco.',
    'cultural_tornerias_desc': 'Pequeña mezquita del siglo XI.',
    'cultural_sefardi_desc': 'Museo sobre la historia judía en Toledo.',
    'ruta_senda_ecologica_desc':
        'Sendero a orillas del río Tajo, ideal para paseos familiares.',
    'ruta_piedra_rey_moro_desc':
        'Ruta circular con leyendas y vistas al río Tajo.',
    'ruta_montes_toledo_desc':
        'Excursión por la sierra con flora y fauna autóctona.',
    'cultural_tourism_desc':
        'Descubre la riqueza histórica y monumental de Toledo a través de sus museos, iglesias y sinagogas.',
    'gastronomy_desc':
        'Disfruta de la mejor cocina toledana en restaurantes y bares típicos de la ciudad.',
    'nature_desc':
        'Explora rutas únicas y paisajes naturales en los alrededores de Toledo.',
    'nightlife_desc':
        'Vive la noche toledana con tours, pubs, discotecas y actividades culturales.',
    'free_tour_desc':
        'Tours gratuitos guiados por Toledo. Descubre la historia con guías expertos.',
    'reserva': 'Reservar',
    'como_llegar': 'Cómo llegar',
    'app_info': 'Información de la App',
    'app_information': 'Información de la Aplicación',
    'app_name': 'Nombre de la App',
    'version': 'Versión',
    'package_name': 'Nombre del Paquete',
    'developer_info': 'Información del Desarrollador',
    'developer': 'Desarrollador',
    'email': 'Email',
    'company': 'Empresa',
    'collaborators': 'Colaboradores',
    'ui_designer': 'Diseñador UI',
    'content_creator': 'Creador de Contenido',
    'tester': 'Tester',
    'translator': 'Traductor',
    'technologies': 'Tecnologías Utilizadas',
    'contact_us': 'Contáctanos',
    'contact_form_description':
        'Envíanos tus comentarios, sugerencias o reporta problemas. Puedes adjuntar fotos, audios u otros archivos.',
    'name': 'Nombre',
    'subject': 'Asunto',
    'message': 'Mensaje',
    'attachments': 'Adjuntos',
    'add_photo': 'Añadir Foto',
    'add_file': 'Añadir Archivo',
    'attached_files': 'Archivos Adjuntos',
    'send': 'Enviar',
    'sending': 'Enviando...',
    'name_required': 'El nombre es obligatorio',
    'email_required': 'El email es obligatorio',
    'email_invalid': 'Email no válido',
    'subject_required': 'El asunto es obligatorio',
    'message_required': 'El mensaje es obligatorio',
    'email_sent_success': 'Email enviado correctamente',
    'email_send_error': 'Error al enviar el email',
    'sort_by_distance': 'Ordenar por distancia',
    'sort_alphabetically': 'Ordenar alfabéticamente',
  },
  'en': {
    'title': 'Toledo Tour',
    'restaurants': 'Restaurants',
    'bars': 'Bars',
    'restaurant_map': 'Restaurant Map',
    'your_location': 'Your location',
    'current_position': 'Current position',
    'center_on_map': 'Center on map',
    'directions': 'Directions',
    'my_location': 'My location',
    'refresh': 'Refresh',
    'free_tour': 'Free Tour',
    'how_to_get': 'How to get there',
    'navigation_error': 'Location error',
    'error_opening_maps': 'Error opening Google Maps',
    'permission_denied': 'Location permission denied',
    'permission_denied_permanently':
        'You must enable location permission from device settings to use this function.',
    'location_needed':
        'To use navigation you need to grant location permission in device settings.',
    'close': 'Close',
    'cultural_tourism': 'Cultural tourism',
    'nature': 'Nature',
    'nightlife': 'Nightlife',
    'gastronomy': 'Gastronomy',
    'error': 'Error',
    'ok': 'OK',
    'rest_adolfo_desc': 'Traditional Toledo cuisine with modern touches.',
    'rest_laorza_desc': 'Cozy restaurant with Castilian cuisine and wine list.',
    'rest_alfileritos_desc': 'Signature cuisine in a historic building.',
    'rest_ventaaires_desc': 'The oldest restaurant in Castilla-La Mancha.',
    'rest_ermita_desc': 'Traditional cuisine with panoramic views.',
    'rest_clandestina_desc': 'Creative cuisine and modern atmosphere.',
    'rest_locum_desc': 'Signature cuisine in historic house.',
    'rest_fabrica_desc': 'Mediterranean cuisine in boutique hotel.',
    'rest_albero_desc': 'Manchego cuisine and grilled meats.',
    'rest_cave_desc': 'International cuisine and tapas.',
    'bar_abadia_desc': 'Typical tavern with Manchego dishes and craft beers.',
    'bar_botero_desc': 'Creative tapas and cocktails in a modern atmosphere.',
    'bar_trebol_desc': 'Famous for its carcamusas and own beers.',
    'bar_malquerida_desc': 'Tapas and portions bar in the historic center.',
    'bar_ludena_desc': 'Traditional, famous for its carcamusas.',
    'bar_skala_desc': 'Tapas and local atmosphere.',
    'bar_elpez_desc': 'Tapas and drinks in alternative atmosphere.',
    'bar_elforo_desc': 'Varied tapas and terrace.',
    'bar_rinconjuan_desc': 'Tapas and wines.',
    'bar_tabernita_desc': 'Tapas and cozy atmosphere.',
    'ruta_valle_desc':
        'Panoramic route through the Toledo Valley with views of the old town.',
    'ruta_barrancas_desc':
        'Impressive clay cliffs next to the Castrejón reservoir.',
    'ruta_senda_tajo_desc':
        'Trail along the Tagus River, ideal for family walks.',
    'ruta_cigarrales_desc':
        'Route among old estates and typical Toledo gardens.',
    'ruta_piedra_rey_desc':
        'Circular route with legends and views of the Tagus River.',
    'ruta_montes_desc':
        'Excursion through the mountains with native flora and fauna.',
    'noche_magico_desc':
        'Guided tour through the legends and mysteries of the illuminated city.',
    'noche_fantasmas_desc':
        'Night tour through the most enigmatic corners of Toledo.',
    'noche_circulo_desc':
        'Nightclub located in a former church, unique atmosphere and varied music.',
    'noche_picaro_desc':
        'Concert hall and nightclub with cultural programming.',
    'noche_nuit_desc': 'Modern nightclub with DJs and themed parties.',
    'noche_candil_desc': 'Ballroom with classes and live music.',
    'noche_ultimo_desc': 'Pub with alternative atmosphere and indie music.',
    'noche_leyenda_desc':
        'Night walk through the most legendary places in the city.',
    'cultural_cristo_desc': 'One of the best-preserved mosques in the city.',
    'cultural_santacruz_desc': 'Museum with art and archaeology of Toledo.',
    'cultural_sinagoga_desc': 'Old synagogue converted into a church.',
    'cultural_greco_desc': 'Museum dedicated to the painter El Greco.',
    'cultural_tornerias_desc': 'Small mosque from the 11th century.',
    'cultural_sefardi_desc': 'Museum about Jewish history in Toledo.',
    'ruta_senda_ecologica_desc':
        'Trail along the Tagus River, ideal for family walks.',
    'ruta_piedra_rey_moro_desc':
        'Circular route with legends and views of the Tagus River.',
    'ruta_montes_toledo_desc':
        'Excursion through the mountains with native flora and fauna.',
    'cultural_tourism_desc':
        'Discover the historical and monumental richness of Toledo through its museums, churches, and synagogues.',
    'gastronomy_desc':
        'Enjoy the best Toledo cuisine in typical restaurants and bars of the city.',
    'nature_desc':
        'Explore unique routes and natural landscapes around Toledo.',
    'nightlife_desc':
        'Experience Toledo\'s nightlife with tours, pubs, nightclubs, and cultural activities.',
    'free_tour_desc':
        'Free guided tours of Toledo. Discover the history with expert guides.',
    'reserva': 'Book',
    'como_llegar': 'How to get there',
    'app_info': 'App Info',
    'app_information': 'Application Information',
    'app_name': 'App Name',
    'version': 'Version',
    'package_name': 'Package Name',
    'developer_info': 'Developer Information',
    'developer': 'Developer',
    'email': 'Email',
    'company': 'Company',
    'collaborators': 'Collaborators',
    'ui_designer': 'UI Designer',
    'content_creator': 'Content Creator',
    'tester': 'Tester',
    'translator': 'Translator',
    'technologies': 'Technologies Used',
    'contact_us': 'Contact Us',
    'contact_form_description':
        'Send us your comments, suggestions or report problems. You can attach photos, audios or other files.',
    'name': 'Name',
    'subject': 'Subject',
    'message': 'Message',
    'attachments': 'Attachments',
    'add_photo': 'Add Photo',
    'add_file': 'Add File',
    'attached_files': 'Attached Files',
    'send': 'Send',
    'sending': 'Sending...',
    'name_required': 'Name is required',
    'email_required': 'Email is required',
    'email_invalid': 'Invalid email',
    'subject_required': 'Subject is required',
    'message_required': 'Message is required',
    'email_sent_success': 'Email sent successfully',
    'email_send_error': 'Error sending email',
    'sort_by_distance': 'Sort by distance',
    'sort_alphabetically': 'Sort alphabetically',
  },
};

extension LocalizationExtension on BuildContext {
  String tr(String key) {
    final locale = Localizations.localeOf(this).languageCode;
    return translations[locale]?[key] ?? translations['es']![key] ?? key;
  }
}

// Función global para compatibilidad hacia atrás
String tr(BuildContext context, String key) {
  final locale = Localizations.localeOf(context).languageCode;
  return translations[locale]?[key] ?? translations['es']![key] ?? key;
}
