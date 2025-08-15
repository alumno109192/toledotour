import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toledotour/gastronomia.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:toledotour/naturaleza.dart';
import 'package:toledotour/nocturno.dart';
import 'package:toledotour/turismo_cultural.dart';
import 'package:toledotour/app_info_page.dart';
import 'package:toledotour/welcome_page.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_banner_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Solo inicializar Google Mobile Ads en dispositivos móviles (no en web)
  if (!kIsWeb) {
    await MobileAds.instance.initialize();
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
  Locale? _locale;
  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    // Auto-detect locale if not set
    if (localeProvider.locale == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
        final supportedLocale = systemLocale.languageCode == 'es'
            ? const Locale('es')
            : const Locale('en');

        Provider.of<LocaleProvider>(
          context,
          listen: false,
        ).setLocale(supportedLocale);
      });
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Toledo Tour - Web Debug', // No uses tr(context, ...) aquí
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
      // Skip language selector if locale is auto-detected
      home: localeProvider.locale != null
          ? const WelcomePage()
          : const LanguageSelectorPage(),
    );
  }
}

// --- Nueva clase separada para las opciones de turismo ---
class TourismOptionsPage extends StatelessWidget {
  const TourismOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // Intro text
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context, 'explore_toledo'),
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tr(context, 'choose_experience'),
                            style: Theme.of(context).textTheme.bodyLarge,
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
          SliverToBoxAdapter(child: AdBannerWidget()),
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
      /*       {
        'titleKey': 'free_tour',
        'descriptionKey': 'free_tour_desc',
        'icon': Icons.directions_walk,
        'route': (BuildContext context) => FreeTourPage(),
      }, */
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

class LanguageSelectorPage extends StatelessWidget {
  const LanguageSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona idioma / Select language')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<LocaleProvider>(
                  context,
                  listen: false,
                ).setLocale(const Locale('es'));
                // Navegación instantánea sin animación
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const WelcomePage(),
                    transitionDuration: Duration.zero, // Instant transition
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return child; // No animation
                        },
                  ),
                );
              },
              child: const Text('Español'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<LocaleProvider>(
                  context,
                  listen: false,
                ).setLocale(const Locale('en'));
                // Navegación instantánea sin animación
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const WelcomePage(),
                    transitionDuration: Duration.zero, // Instant transition
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return child; // No animation
                        },
                  ),
                );
              },
              child: const Text('English'),
            ),
          ],
        ),
      ),
    );
  }
}
