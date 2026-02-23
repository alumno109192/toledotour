import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Toledo Tour'**
  String get appTitle;

  /// Main description of Toledo
  ///
  /// In en, this message translates to:
  /// **'Discover Toledo, the city of three cultures, with more than 2000 years of history. Explore its medieval alleys, unique monuments declared a World Heritage Site, and immerse yourself in the artistic, gastronomic and cultural richness of one of the most beautiful cities in Spain. Enjoy guided tours, authentic gastronomic experiences, impressive natural routes and vibrant nightlife in the historic heart of Castilla-La Mancha.'**
  String get explore_toledo;

  /// Extended description of cultural tourism
  ///
  /// In en, this message translates to:
  /// **'Immerse yourself in an exceptional cultural journey through Toledo, the city that treasures the greatest monumental heritage in Spain. Visit the Primate Cathedral, a masterpiece of Spanish Gothic that houses the famous Baroque Transparente and one of the richest sacristies in Europe with works by El Greco, Goya and Caravaggio. Explore the Imperial Alcázar, witness to historic battles and current headquarters of the Army Museum with unique collections of medieval armor and the most important military history library in Spain. Discover the Mudejar synagogues of Santa María la Blanca and El Tránsito, unique in Europe for their architecture and decoration, which house the Sephardic Museum with original Hebrew manuscripts. Walk through the mosques of Cristo de la Luz (10th century) and Las Tornerías, exceptional testimonies of Hispano-Muslim art with original Kufic inscriptions. Visit the El Greco Museum to contemplate the masterpieces of the Cretan painter in the historic environment where he developed his art. Stroll through the Monastery of San Juan de los Reyes, a jewel of Elizabethan Gothic commissioned by the Catholic Monarchs to commemorate the Battle of Toro. Admire the Bisagra Gate, the most monumental in Europe, and the Alcántara Bridge of Roman origin that crosses the Tagus River. Discover the Renaissance palaces, Mudejar churches and convents that make Toledo an open-air museum where every corner tells a thousand years of history of coexistence between Christians, Muslims and Jews.'**
  String get cultural_tourism_desc;

  /// Extended description of gastronomy
  ///
  /// In en, this message translates to:
  /// **'Enjoy the authentic Manchego gastronomy in Toledo, cradle of traditional flavors with Denomination of Origin. Savor the famous wood-fired roasted lamb, prepared according to centuries-old recipes passed down from generation to generation in the oldest inns in the city. Taste the Toledo-style stewed partridges, an emblematic dish that combines local game with spices from the Manchego orchard. Try the carcamusas, the most typical dish of Toledo made with Iberian pork, peas, tomato and a secret touch that each house guards jealously. Discover Manchego cheese in its maximum expression, from young to aged, paired with wines with D.O. La Mancha from century-old wineries. Sweeten your palate with Toledo marzipan, Protected Geographical Indication, handcrafted since medieval times by cloistered convents with marcona almonds and sugar. Don\'t miss the Toledan canes, traditional sweets filled with cream or truffle that are the perfect gift. Visit the traditional cellars carved into rock to taste wines from the Méntrida and La Mancha Denominations of Origin. Walk through the food market to discover fresh products from the Tagus orchard. Participate in traditional cooking workshops where you will learn to prepare ancestral recipes. Discover Michelin-starred restaurants and century-old inns where culinary tradition merges with the most avant-garde gastronomic innovation.'**
  String get gastronomy_desc;

  /// Extended description of nature
  ///
  /// In en, this message translates to:
  /// **'Explore the privileged nature surrounding Toledo, with unique landscapes declared a Biosphere Reserve. Walk through the Burujón and Castrejón Ravines Natural Park, with spectacular geological formations known as \'the gullies\', red clay canyons that seem taken from the American Grand Canyon and offer impressive panoramic views at sunset. Walk along the Tagus Routes, river trails that wind along the longest river in the peninsula, crossing riparian forests with poplars, willows and ash trees where otters, herons and kingfishers live. Discover the Toledo Mountains, paradise for hikers and nature lovers, with routes of different levels that cross meadows of centenary oaks, Mediterranean cork oaks and oak forests where livestock graze freely. Observe native fauna in their natural habitat: imperial eagles, black vultures, deer, wild boars, genets and Iberian lynxes in special protection areas. Practice cycle tourism on the Greenways that connect medieval villages through old royal roads. Enjoy horseback routes through historic farmhouses among millenary olive groves. Live the experience of astrotourism in the cleanest skies of Castilla-La Mancha, declared a Starlight Tourist Destination. Visit the Castrejón and Azután reservoirs for water sports, sport fishing and observation of migratory birds. Walk the Livestock Routes, old transhumance paths that keep the livestock tradition alive.'**
  String get nature_desc;

  /// Extended description of nightlife
  ///
  /// In en, this message translates to:
  /// **'Discover the vibrant nocturnal cultural life of Toledo, where millenary history meets contemporary entertainment in a unique and family-friendly atmosphere. Start your evening on panoramic terraces with spectacular views of the illuminated city and the Tagus River under the stars. Explore the Caves Zone, venues set in medieval vaults from the 13th century where you can enjoy live music from authentic flamenco to contemporary jazz. Experience the magic of guided night tours with Toledan legends and mysteries, walking through torch-lit alleys where you will hear stories of Templars, ghosts and alchemists who inhabited the city. Enjoy light and sound shows at the Cathedral and the Alcázar, monumental projections that narrate the history of Toledo with state-of-the-art laser technology. Visit cultural spaces in historic houses of the Jewish quarter, with original decoration from the 16th and 17th centuries, offering gourmet tapas and local gastronomy. Participate in cultural events in unique spaces such as Renaissance cloisters converted into performance halls. Attend gastronomic tastings paired with Iberian cheeses and sausages in century-old cellars. Enjoy theatrical performances at the Teatro de Rojas, a 19th-century historic building with cultural programming throughout the year. Experience traditional festivals such as Corpus Christi or the Toledan summer nights with popular events in historic squares.'**
  String get nightlife_desc;

  /// Description of the free tour
  ///
  /// In en, this message translates to:
  /// **'Join our daily free tours of Toledo, professional guided experiences where local expert historians will reveal the best-kept secrets of the Imperial City. Walk for two hours through the cobbled streets of the historic center declared a World Heritage Site, discovering hidden corners, secret panoramic viewpoints and fascinating legends that you will not find in conventional tourist guides. Learn about the coexistence of the three cultures that made Toledo a beacon of knowledge during the Middle Ages, visiting the exact places where Christians, Muslims and Jews shared wisdom, art and commerce, creating a unique society in medieval Europe. Discover the real stories of kings, saints, artists and historical figures who walked these same streets centuries ago. The tour includes stops at the main exterior monuments, explanations about Mudejar architecture unique in the world, and anecdotes about El Greco, Alfonso X the Wise, Saint Teresa of Jesus and other illustrious figures. Our bilingual official guides will answer all your questions and give you personalized recommendations about authentic restaurants, traditional craft shops and activities to make the most of your stay in Toledo.'**
  String get free_tour_desc;

  /// No description provided for @cultural_tourism.
  ///
  /// In en, this message translates to:
  /// **'Cultural Tourism'**
  String get cultural_tourism;

  /// No description provided for @gastronomy.
  ///
  /// In en, this message translates to:
  /// **'Gastronomy'**
  String get gastronomy;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @nightlife.
  ///
  /// In en, this message translates to:
  /// **'Nightlife'**
  String get nightlife;

  /// No description provided for @free_tour.
  ///
  /// In en, this message translates to:
  /// **'Free Tour'**
  String get free_tour;

  /// No description provided for @nightlife_intro_title.
  ///
  /// In en, this message translates to:
  /// **'Culture and Nighttime Entertainment in Toledo'**
  String get nightlife_intro_title;

  /// No description provided for @nightlife_intro_text.
  ///
  /// In en, this message translates to:
  /// **'Toledo offers a unique nighttime experience that combines history, culture and entertainment in a family atmosphere. Discover light and sound shows, guided night tours, live music in historic spaces and cultural events that make Toledo nights unforgettable.'**
  String get nightlife_intro_text;

  /// No description provided for @night_activities_title.
  ///
  /// In en, this message translates to:
  /// **'Recommended Nighttime Activities'**
  String get night_activities_title;

  /// No description provided for @night_activities_text.
  ///
  /// In en, this message translates to:
  /// **'From legend routes through medieval alleys to theatrical and musical performances in historic buildings, Toledo offers multiple options to enjoy the night in a cultural and entertaining way.'**
  String get night_activities_text;

  /// No description provided for @nature_intro_title.
  ///
  /// In en, this message translates to:
  /// **'Nature and Landscapes in Toledo'**
  String get nature_intro_title;

  /// No description provided for @nature_intro_text.
  ///
  /// In en, this message translates to:
  /// **'The surroundings of Toledo offer impressive natural landscapes, hiking routes for all levels and protected natural spaces where you can enjoy native flora and fauna in a unique environment.'**
  String get nature_intro_text;

  /// No description provided for @natural_routes_title.
  ///
  /// In en, this message translates to:
  /// **'Recommended Natural Routes'**
  String get natural_routes_title;

  /// No description provided for @natural_routes_text.
  ///
  /// In en, this message translates to:
  /// **'Discover the best trails and natural routes surrounding Toledo, from the Burujón Ravines to the Toledo Mountains, passing through the banks of the Tagus River.'**
  String get natural_routes_text;

  /// No description provided for @free_tour_intro_title.
  ///
  /// In en, this message translates to:
  /// **'Free Tours of Toledo'**
  String get free_tour_intro_title;

  /// No description provided for @free_tour_intro_text.
  ///
  /// In en, this message translates to:
  /// **'Discover Toledo with professional guides on daily free tours. A perfect experience to learn about the history, culture and secrets of the Imperial City from the hand of local experts.'**
  String get free_tour_intro_text;

  /// No description provided for @free_tour_benefits_title.
  ///
  /// In en, this message translates to:
  /// **'Benefits of Free Tours'**
  String get free_tour_benefits_title;

  /// No description provided for @free_tour_benefits_text.
  ///
  /// In en, this message translates to:
  /// **'Our free tours allow you to discover Toledo at your own pace, with passionate guides who share their knowledge without a fixed cost. You decide how much to value the experience at the end of the tour.'**
  String get free_tour_benefits_text;

  /// No description provided for @reserva.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get reserva;

  /// No description provided for @como_llegar.
  ///
  /// In en, this message translates to:
  /// **'How to get there'**
  String get como_llegar;

  /// No description provided for @error_opening_maps.
  ///
  /// In en, this message translates to:
  /// **'Error opening map'**
  String get error_opening_maps;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select your language'**
  String get select_language;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Toledo'**
  String get welcome_title;

  /// No description provided for @welcome_intro_text.
  ///
  /// In en, this message translates to:
  /// **'Discover the Imperial City, declared a World Heritage Site by UNESCO. Toledo is a historical treasure where three cultures coexisted and every corner tells a millenary story.'**
  String get welcome_intro_text;

  /// No description provided for @history_title.
  ///
  /// In en, this message translates to:
  /// **'Millennial History'**
  String get history_title;

  /// No description provided for @history_text.
  ///
  /// In en, this message translates to:
  /// **'Toledo, founded in Roman times, was the capital of the Visigothic Kingdom and later an important Muslim and Christian enclave. Its rich history makes it one of the most fascinating cities in Europe.'**
  String get history_text;

  /// No description provided for @heritage_title.
  ///
  /// In en, this message translates to:
  /// **'Cultural Heritage'**
  String get heritage_title;

  /// No description provided for @heritage_text.
  ///
  /// In en, this message translates to:
  /// **'The City of Three Cultures houses synagogues, mosques, churches and cathedrals that testify to the historical coexistence of Christians, Muslims and Jews. A living museum of Spanish history.'**
  String get heritage_text;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Toledo Tour'**
  String get title;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Toledo'**
  String get welcome;

  /// No description provided for @start_tour.
  ///
  /// In en, this message translates to:
  /// **'Start Tour'**
  String get start_tour;

  /// No description provided for @app_info.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get app_info;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_of_service;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @your_location.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get your_location;

  /// No description provided for @current_position.
  ///
  /// In en, this message translates to:
  /// **'Current Position'**
  String get current_position;

  /// No description provided for @center_on_map.
  ///
  /// In en, this message translates to:
  /// **'Center on Map'**
  String get center_on_map;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @restaurant_map.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Map'**
  String get restaurant_map;

  /// No description provided for @my_location.
  ///
  /// In en, this message translates to:
  /// **'My Location'**
  String get my_location;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @choose_experience.
  ///
  /// In en, this message translates to:
  /// **'Choose your experience'**
  String get choose_experience;

  /// No description provided for @app_information.
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get app_information;

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get app_name;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @toledo_guides.
  ///
  /// In en, this message translates to:
  /// **'Toledo Guides'**
  String get toledo_guides;

  /// No description provided for @contact_form_description.
  ///
  /// In en, this message translates to:
  /// **'Send us your questions, suggestions or comments about Toledo'**
  String get contact_form_description;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get name_required;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_required;

  /// No description provided for @email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get email_invalid;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @subject_required.
  ///
  /// In en, this message translates to:
  /// **'Subject is required'**
  String get subject_required;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @message_required.
  ///
  /// In en, this message translates to:
  /// **'Message is required'**
  String get message_required;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @add_photo.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get add_photo;

  /// No description provided for @add_file.
  ///
  /// In en, this message translates to:
  /// **'Add File'**
  String get add_file;

  /// No description provided for @attached_files.
  ///
  /// In en, this message translates to:
  /// **'Attached files'**
  String get attached_files;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @email_sent_success.
  ///
  /// In en, this message translates to:
  /// **'Email sent successfully'**
  String get email_sent_success;

  /// No description provided for @email_send_error.
  ///
  /// In en, this message translates to:
  /// **'Error sending email'**
  String get email_send_error;

  /// No description provided for @sort_alphabetically.
  ///
  /// In en, this message translates to:
  /// **'Sort alphabetically'**
  String get sort_alphabetically;

  /// No description provided for @sort_by_distance.
  ///
  /// In en, this message translates to:
  /// **'Sort by distance'**
  String get sort_by_distance;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @bars.
  ///
  /// In en, this message translates to:
  /// **'Bars & Tapas'**
  String get bars;

  /// No description provided for @how_to_get.
  ///
  /// In en, this message translates to:
  /// **'How to get there'**
  String get how_to_get;

  /// No description provided for @navigation_error.
  ///
  /// In en, this message translates to:
  /// **'Error opening navigation'**
  String get navigation_error;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @toledo_guides_desc.
  ///
  /// In en, this message translates to:
  /// **'Explore Toledo with our specialized guides that will help you make the most of your visit to the Imperial City.'**
  String get toledo_guides_desc;

  /// No description provided for @guide_one_day_title.
  ///
  /// In en, this message translates to:
  /// **'What to see in Toledo in one day?'**
  String get guide_one_day_title;

  /// No description provided for @guide_one_day_summary.
  ///
  /// In en, this message translates to:
  /// **'Optimized itinerary to discover the essentials of Toledo in one day'**
  String get guide_one_day_summary;

  /// No description provided for @guide_gastronomy_title.
  ///
  /// In en, this message translates to:
  /// **'History of Toledo Gastronomy'**
  String get guide_gastronomy_title;

  /// No description provided for @guide_gastronomy_summary.
  ///
  /// In en, this message translates to:
  /// **'Discover the origins and evolution of traditional Toledo cuisine'**
  String get guide_gastronomy_summary;

  /// No description provided for @guide_cultures_title.
  ///
  /// In en, this message translates to:
  /// **'The Three Cultures in Toledo'**
  String get guide_cultures_title;

  /// No description provided for @guide_cultures_summary.
  ///
  /// In en, this message translates to:
  /// **'A journey through the historical coexistence of Christians, Muslims and Jews'**
  String get guide_cultures_summary;

  /// No description provided for @guide_seasons_title.
  ///
  /// In en, this message translates to:
  /// **'Routes by Seasons'**
  String get guide_seasons_title;

  /// No description provided for @guide_seasons_summary.
  ///
  /// In en, this message translates to:
  /// **'The best times and activities to visit Toledo according to the season'**
  String get guide_seasons_summary;

  /// No description provided for @cultural_cristo_desc.
  ///
  /// In en, this message translates to:
  /// **'Former 10th century mosque, one of Toledo\'s oldest buildings preserving its original Islamic structure'**
  String get cultural_cristo_desc;

  /// No description provided for @cultural_santacruz_desc.
  ///
  /// In en, this message translates to:
  /// **'Medieval and Renaissance art museum located in a 16th century palace'**
  String get cultural_santacruz_desc;

  /// No description provided for @cultural_sinagoga_desc.
  ///
  /// In en, this message translates to:
  /// **'13th century Mudejar synagogue, one of the best preserved in Spain'**
  String get cultural_sinagoga_desc;

  /// No description provided for @cultural_greco_desc.
  ///
  /// In en, this message translates to:
  /// **'Museum dedicated to painter El Greco featuring his most complete collection'**
  String get cultural_greco_desc;

  /// No description provided for @cultural_tornerias_desc.
  ///
  /// In en, this message translates to:
  /// **'11th century former mosque with impressive horseshoe arches'**
  String get cultural_tornerias_desc;

  /// No description provided for @cultural_sefardi_desc.
  ///
  /// In en, this message translates to:
  /// **'Sephardic Museum located in the El Tránsito Synagogue, jewel of Mudejar art'**
  String get cultural_sefardi_desc;

  /// No description provided for @rest_adolfo_desc.
  ///
  /// In en, this message translates to:
  /// **'Michelin-starred haute cuisine restaurant with Manchego specialties'**
  String get rest_adolfo_desc;

  /// No description provided for @rest_laorza_desc.
  ///
  /// In en, this message translates to:
  /// **'Traditional Toledo cuisine in a historic setting'**
  String get rest_laorza_desc;

  /// No description provided for @rest_alfileritos_desc.
  ///
  /// In en, this message translates to:
  /// **'Specializing in game and typical Manchego dishes'**
  String get rest_alfileritos_desc;

  /// No description provided for @rest_ventaaires_desc.
  ///
  /// In en, this message translates to:
  /// **'Panoramic views of Toledo with signature cuisine'**
  String get rest_ventaaires_desc;

  /// No description provided for @rest_ermita_desc.
  ///
  /// In en, this message translates to:
  /// **'Mediterranean cuisine in a 16th century building'**
  String get rest_ermita_desc;

  /// No description provided for @rest_clandestina_desc.
  ///
  /// In en, this message translates to:
  /// **'Creative tapas and fusion cuisine'**
  String get rest_clandestina_desc;

  /// No description provided for @rest_locum_desc.
  ///
  /// In en, this message translates to:
  /// **'Modern restaurant with traditional cuisine touches'**
  String get rest_locum_desc;

  /// No description provided for @rest_fabrica_desc.
  ///
  /// In en, this message translates to:
  /// **'Former weapons factory converted into restaurant'**
  String get rest_fabrica_desc;

  /// No description provided for @rest_albero_desc.
  ///
  /// In en, this message translates to:
  /// **'Castilian cuisine with local products'**
  String get rest_albero_desc;

  /// No description provided for @rest_cave_desc.
  ///
  /// In en, this message translates to:
  /// **'Wine bar and gourmet tapas in medieval cave'**
  String get rest_cave_desc;

  /// No description provided for @bar_abadia_desc.
  ///
  /// In en, this message translates to:
  /// **'Traditional Toledo tapas in historic atmosphere'**
  String get bar_abadia_desc;

  /// No description provided for @bar_botero_desc.
  ///
  /// In en, this message translates to:
  /// **'Famous for its carcamusas, typical Toledo dish'**
  String get bar_botero_desc;

  /// No description provided for @bar_trebol_desc.
  ///
  /// In en, this message translates to:
  /// **'Tapas bar with terrace in the historic center'**
  String get bar_trebol_desc;

  /// No description provided for @bar_malquerida_desc.
  ///
  /// In en, this message translates to:
  /// **'Creative tapas and regional wines'**
  String get bar_malquerida_desc;

  /// No description provided for @bar_ludena_desc.
  ///
  /// In en, this message translates to:
  /// **'One of the oldest bars in Toledo'**
  String get bar_ludena_desc;

  /// No description provided for @bar_skala_desc.
  ///
  /// In en, this message translates to:
  /// **'Modern tapas with cathedral views'**
  String get bar_skala_desc;

  /// No description provided for @bar_elpez_desc.
  ///
  /// In en, this message translates to:
  /// **'Specializing in fresh fish and seafood'**
  String get bar_elpez_desc;

  /// No description provided for @bar_elforo_desc.
  ///
  /// In en, this message translates to:
  /// **'Varied tapas in the caves area'**
  String get bar_elforo_desc;

  /// No description provided for @bar_rinconjuan_desc.
  ///
  /// In en, this message translates to:
  /// **'Home cooking and generous portions'**
  String get bar_rinconjuan_desc;

  /// No description provided for @bar_tabernita_desc.
  ///
  /// In en, this message translates to:
  /// **'Small charming bar in the Jewish quarter'**
  String get bar_tabernita_desc;

  /// No description provided for @noche_magico_desc.
  ///
  /// In en, this message translates to:
  /// **'Night tour through Toledo\'s most mystical corners'**
  String get noche_magico_desc;

  /// No description provided for @noche_fantasmas_desc.
  ///
  /// In en, this message translates to:
  /// **'Route of legends and mysteries through nighttime Toledo'**
  String get noche_fantasmas_desc;

  /// No description provided for @noche_circulo_desc.
  ///
  /// In en, this message translates to:
  /// **'Art Circle: cultural shows in historic building'**
  String get noche_circulo_desc;

  /// No description provided for @noche_picaro_desc.
  ///
  /// In en, this message translates to:
  /// **'Tapas theater in medieval atmosphere'**
  String get noche_picaro_desc;

  /// No description provided for @noche_nuit_desc.
  ///
  /// In en, this message translates to:
  /// **'Music bar with panoramic night views'**
  String get noche_nuit_desc;

  /// No description provided for @noche_candil_desc.
  ///
  /// In en, this message translates to:
  /// **'Live flamenco in traditional tablao'**
  String get noche_candil_desc;

  /// No description provided for @noche_ultimo_desc.
  ///
  /// In en, this message translates to:
  /// **'Pub with live music in old cave'**
  String get noche_ultimo_desc;

  /// No description provided for @noche_leyenda_desc.
  ///
  /// In en, this message translates to:
  /// **'Guided tour of Toledo legends under the stars'**
  String get noche_leyenda_desc;

  /// No description provided for @ruta_valle_desc.
  ///
  /// In en, this message translates to:
  /// **'Valley Route: 8 km family trail along the Tagus River'**
  String get ruta_valle_desc;

  /// No description provided for @ruta_barrancas_desc.
  ///
  /// In en, this message translates to:
  /// **'Burujón Ravines: spectacular Grand Canyon-like geological formations'**
  String get ruta_barrancas_desc;

  /// No description provided for @ruta_senda_ecologica_desc.
  ///
  /// In en, this message translates to:
  /// **'Tagus Ecological Path: 10 km of nature and birdwatching'**
  String get ruta_senda_ecologica_desc;

  /// No description provided for @ruta_cigarrales_desc.
  ///
  /// In en, this message translates to:
  /// **'Cigarrales Route: historic estates with panoramic views'**
  String get ruta_cigarrales_desc;

  /// No description provided for @ruta_piedra_rey_moro_desc.
  ///
  /// In en, this message translates to:
  /// **'Moorish King\'s Stone: natural viewpoint with historical legend'**
  String get ruta_piedra_rey_moro_desc;

  /// No description provided for @ruta_montes_toledo_desc.
  ///
  /// In en, this message translates to:
  /// **'Toledo Mountains: hiking trails through natural park'**
  String get ruta_montes_toledo_desc;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
