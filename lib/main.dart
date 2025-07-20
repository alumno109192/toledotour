import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toledotour/gastronomia.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:toledotour/naturaleza.dart';
import 'package:toledotour/nocturno.dart';
import 'package:toledotour/turismo_cultural.dart';
import 'package:toledotour/app_info_page.dart';
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
      home: const LanguageSelectorPage(),
    );
  }
}

// --- Nueva clase separada para las opciones de turismo ---
class TourismOptionsPage extends StatelessWidget {
  const TourismOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TourismOptionsCardView()),
        AdBannerWidget(),
      ],
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
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'title')),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppInfoPage()),
              );
            },
            tooltip: tr(context, 'app_info'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const TourismOptionsPage()),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const TourismOptionsPage()),
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
