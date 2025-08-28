import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toledotour/gastronomia.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:toledotour/naturaleza.dart';
import 'package:toledotour/nocturno.dart';
import 'package:toledotour/turismo_cultural.dart';
import 'package:toledotour/app_info_page.dart';
import 'package:toledotour/toledo_guide_page.dart';
import 'package:toledotour/free_tour.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'adsense_config.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Solo inicializar Google Mobile Ads en dispositivos móviles (no en web)
  if (!kIsWeb) {
    await MobileAds.instance.initialize();
  } else {
    // Inicializar AdSense para web
    AdSenseConfig.initializeAdSense();
  }

  // Acelerar el inicio de la aplicación
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('es'); // Español por defecto
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      final oldLocale = _locale;
      _locale = locale;
      notifyListeners();
      // Enhanced debug print to verify the change
      if (kDebugMode) {
        print(
          '🌐 Locale changed: ${oldLocale.languageCode} → ${locale.languageCode}',
        );
        print('📱 Current locale is now: ${_locale.languageCode}');
      }
    } else {
      if (kDebugMode) {
        print('🔄 Locale change skipped - same locale: ${locale.languageCode}');
      }
    }
  }

  // Toggle between Spanish and English
  void toggleLocale() {
    final newLocale = _locale.languageCode == 'es'
        ? const Locale('en')
        : const Locale('es');
    setLocale(newLocale);
  }

  // Method to reset to system locale
  void setSystemLocale() {
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final supportedLocale = systemLocale.languageCode == 'es'
        ? const Locale('es')
        : const Locale('en');
    if (kDebugMode) {
      print(
        '🌍 Setting system locale: ${systemLocale.languageCode} → ${supportedLocale.languageCode}',
      );
    }
    setLocale(supportedLocale);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Toledo Tour',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          locale: localeProvider.locale,
          supportedLocales: const [Locale('es'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // Direct navigation to main content - no welcome page
          home: const TourismOptionsPage(),
        );
      },
    );
  }
}

// --- Nueva clase separada para las opciones de turismo ---
class TourismOptionsPage extends StatelessWidget {
  const TourismOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Floating action button para cambio rápido de idioma - Fixed to be reactive
      floatingActionButton: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          final isSpanish = localeProvider.locale.languageCode == 'es';
          return FloatingActionButton.extended(
            onPressed: () {
              // Toggle between Spanish and English using the new method
              localeProvider.toggleLocale();

              // Show confirmation snackbar with better feedback
              ScaffoldMessenger.of(
                context,
              ).clearSnackBars(); // Clear previous snackbars
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        localeProvider.locale.languageCode == 'es'
                            ? tr(context, 'language_changed_spanish')
                            : tr(context, 'language_changed_english'),
                      ),
                    ],
                  ),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            tooltip: isSpanish
                ? tr(context, 'change_to_english')
                : tr(context, 'change_to_spanish'),
            icon: const Icon(Icons.language),
            label: Text(
              isSpanish ? 'ES → EN' : 'EN → ES',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(tr(context, 'title')),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2E5C8A), Color(0xFF4A90B8)],
                  ),
                ),
              ),
            ),
            actions: [
              // Language Selector Popup - Fixed to be reactive
              Consumer<LocaleProvider>(
                builder: (context, localeProvider, child) {
                  return PopupMenuButton<Locale>(
                    icon: Stack(
                      children: [
                        const Icon(Icons.language),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              localeProvider.locale.languageCode.toUpperCase(),
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    tooltip: tr(context, 'change_language'),
                    onSelected: (Locale locale) {
                      localeProvider.setLocale(locale);
                      // Show confirmation with better feedback
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                locale.languageCode == 'es'
                                    ? tr(context, 'language_changed_spanish')
                                    : tr(context, 'language_changed_english'),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<Locale>(
                        value: const Locale('es'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: localeProvider.locale.languageCode == 'es'
                                ? Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.1)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              const Text('🇪🇸'),
                              const SizedBox(width: 8),
                              Text(tr(context, 'spanish')),
                              const Spacer(),
                              if (localeProvider.locale.languageCode == 'es')
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem<Locale>(
                        value: const Locale('en'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: localeProvider.locale.languageCode == 'en'
                                ? Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.1)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              const Text('🇺🇸'),
                              const SizedBox(width: 8),
                              Text(tr(context, 'english')),
                              const Spacer(),
                              if (localeProvider.locale.languageCode == 'en')
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppInfoPage(),
                    ),
                  );
                },
                tooltip: tr(context, 'app_info'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome section with language info
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  tr(context, 'welcome_title'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ),
                              // Quick language toggle - Enhanced
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    Provider.of<LocaleProvider>(
                                      context,
                                      listen: false,
                                    ).toggleLocale();

                                    // Haptic feedback
                                    // HapticFeedback.lightImpact(); // Uncomment if needed
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: Consumer<LocaleProvider>(
                                      builder:
                                          (context, localeProvider, child) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  localeProvider
                                                              .locale
                                                              .languageCode ==
                                                          'es'
                                                      ? '🇪🇸'
                                                      : '🇺🇸',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  localeProvider
                                                              .locale
                                                              .languageCode ==
                                                          'es'
                                                      ? 'ES'
                                                      : 'EN',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(
                                                      context,
                                                    ).primaryColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                Icon(
                                                  Icons.swap_horiz,
                                                  size: 12,
                                                  color: Theme.of(
                                                    context,
                                                  ).primaryColor,
                                                ),
                                              ],
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            tr(context, 'welcome_intro_text'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 20),

                          // Contenido editorial expandido
                          Text(
                            tr(context, 'toledo_history_section_title'),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            tr(context, 'toledo_history_section_text'),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 20),

                          Text(
                            tr(context, 'toledo_culture_section_title'),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            tr(context, 'toledo_culture_section_text'),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),

                          // Add explore section directly here
                          Text(
                            tr(context, 'explore_toledo'),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tr(context, 'choose_experience'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return TourismOptionsCardView();
            }, childCount: 1),
          ),
          // Removed AdBannerWidget from main navigation page
          // Ads will only appear on content-rich pages
        ],
      ),
    );
  }
}

class TourismOptionsCardView extends StatelessWidget {
  const TourismOptionsCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      {
        'titleKey': 'cultural_tourism',
        'descriptionKey': 'cultural_tourism_desc',
        'icon': Icons.museum,
        'route': (BuildContext context) => CulturalTourismPage(),
      },
      {
        'titleKey': 'gastronomy',
        'descriptionKey': 'gastronomy_desc',
        'icon': Icons.restaurant,
        'route': (BuildContext context) => GastronomiaPage(),
      },
      {
        'titleKey': 'nature',
        'descriptionKey': 'nature_desc',
        'icon': Icons.park,
        'route': (BuildContext context) => NaturalezaPage(),
      },
      {
        'titleKey': 'nightlife',
        'descriptionKey': 'nightlife_desc',
        'icon': Icons.nightlife,
        'route': (BuildContext context) => NocturnoPage(),
      },
      {
        'titleKey': 'toledo_guides',
        'descriptionKey': 'guide_one_day_summary',
        'icon': Icons.menu_book,
        'route': (BuildContext context) => ToledoGuidePage(),
      },
      {
        'titleKey': 'free_tour',
        'descriptionKey': 'free_tour_desc',
        'icon': Icons.directions_walk,
        'route': (BuildContext context) => FreeTourPage(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 4,
            child: ListTile(
              leading: Icon(
                option['icon'] as IconData,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                tr(context, option['titleKey'] as String),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(tr(context, option['descriptionKey'] as String)),
              onTap: () {
                if (option.containsKey('route')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          (option['route'] as Widget Function(BuildContext))(
                            context,
                          ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Seleccionaste: ${tr(context, option['titleKey'] as String)}',
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
