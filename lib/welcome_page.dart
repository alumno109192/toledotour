import 'package:flutter/material.dart';
import 'package:toledotour/l10n/app_localizations.dart';
import 'package:toledotour/main.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Floating Action Button para acceso rápido
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navegación directa e inmediata al contenido principal
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TourismOptionsPage(),
              transitionDuration: Duration.zero, // Instant transition
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return child; // No animation for instant access
                  },
            ),
          );
        },
        label: Text(tr(context, 'skip_to_content')),
        icon: const Icon(Icons.skip_next),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                tr(context, 'welcome_title'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(128, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2E5C8A), Color(0xFF4A90B8)],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_city,
                    size: 100,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Introducción principal
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr(context, 'welcome_intro_title'),
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr(context, 'welcome_intro_text'),
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Historia de Toledo
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.history_edu,
                              color: Theme.of(context).primaryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              tr(context, 'history_title'),
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr(context, 'history_text'),
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Patrimonio
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.architecture,
                              color: Theme.of(context).primaryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              tr(context, 'heritage_title'),
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr(context, 'heritage_text'),
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Gastronomía local
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.restaurant,
                              color: Theme.of(context).primaryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              tr(context, 'local_gastronomy_title'),
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr(context, 'local_gastronomy_text'),
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Botón para continuar con navegación más rápida
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navegación más rápida sin animación
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const TourismOptionsPage(),
                          transitionDuration: const Duration(
                            milliseconds: 150,
                          ), // Reduced from default 300ms
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                // Fade transition más rápido
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                    icon: const Icon(Icons.explore),
                    label: Text(tr(context, 'start_exploring')),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
