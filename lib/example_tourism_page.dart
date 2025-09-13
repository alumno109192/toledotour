import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'safe_ad_widget.dart';
import 'ad_compliance_monitor.dart';

/// Ejemplo de página de contenido turístico que integra anuncios seguros
class TourismContentPage extends StatefulWidget {
  final String title;
  final String content;
  final String pageType;

  const TourismContentPage({
    super.key,
    required this.title,
    required this.content,
    this.pageType = 'tourism_pages',
  });

  @override
  State<TourismContentPage> createState() => _TourismContentPageState();
}

class _TourismContentPageState extends State<TourismContentPage> {
  @override
  void initState() {
    super.initState();

    // Inicializar sistema de monitoreo
    if (kDebugMode) {
      AdComplianceMonitor.logEvent(
        ComplianceEvent(
          type: ComplianceEventType.pageAnalyzed,
          pageName: widget.title,
          description: 'Página de turismo visitada',
          data: {'contentLength': widget.content.length},
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.analytics),
              onPressed: _showComplianceReport,
              tooltip: 'Ver reporte de cumplimiento',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anuncio superior (solo si hay contenido suficiente)
            SafeAdWidget(
              pageName: widget.title.toLowerCase().replaceAll(' ', '_'),
              pageContent: widget.content,
              pageType: widget.pageType,
              position: 'top',
              showMetrics: kDebugMode,
            ),

            // Contenido principal
            _buildMainContent(),

            // Anuncio medio (después del 50% del contenido)
            if (widget.content.length > 1000)
              SafeAdWidget(
                pageName: widget.title.toLowerCase().replaceAll(' ', '_'),
                pageContent: widget.content,
                pageType: widget.pageType,
                position: 'content',
                showMetrics: kDebugMode,
              ),

            // Más contenido
            _buildAdditionalContent(),

            // Anuncio inferior (solo en páginas muy largas)
            if (widget.content.length > 1500)
              SafeAdWidget(
                pageName: widget.title.toLowerCase().replaceAll(' ', '_'),
                pageContent: widget.content,
                pageType: widget.pageType,
                position: 'bottom',
                showMetrics: kDebugMode,
              ),

            // Footer con información de cumplimiento (solo en debug)
            if (kDebugMode) _buildDebugFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(widget.content, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalContent() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🏛️ Información Adicional',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              '''Toledo, conocida como la "Ciudad Imperial" y declarada Patrimonio de la Humanidad por la UNESCO en 1986, representa uno de los conjuntos histórico-artísticos más importantes de España.

La ciudad fue capital del Reino Visigodo y posteriormente un importante centro de convivencia entre las culturas cristiana, musulmana y judía durante la Edad Media. Esta rica herencia multicultural se refleja en su arquitectura única, donde coexisten monumentos de diferentes épocas y estilos.

Entre sus principales atractivos se encuentra la imponente Catedral Primada, obra maestra del gótico español; el Alcázar, fortaleza que domina la ciudad desde lo alto; la Sinagoga del Tránsito, testimonio de la presencia judía; y la Mezquita del Cristo de la Luz, vestigio de la época musulmana.

Las estrechas calles empedradas del casco histórico invitan a perderse y descubrir rincones llenos de historia, talleres de artesanos especializados en el tradicional damasquinado toledano, y miradores con vistas espectaculares del río Tajo.''',
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugFooter() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔧 Información de Cumplimiento (Debug)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text('Página: ${widget.title}'),
          Text('Contenido: ${widget.content.length} caracteres'),
          Text('Tipo: ${widget.pageType}'),
          Text('Plataforma: ${kIsWeb ? "Web" : "Móvil"}'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _showComplianceReport,
            child: const Text('Ver Reporte Completo'),
          ),
        ],
      ),
    );
  }

  void _showComplianceReport() {
    if (!kDebugMode) return;

    final report = AdComplianceMonitor.generateReport();
    final stats = AdComplianceMonitor.getGeneralStats();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('📊 Reporte de Cumplimiento'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Páginas analizadas: ${stats['totalPages']}'),
              Text('Páginas con anuncios: ${stats['pagesWithAds']}'),
              Text('Tasa de cumplimiento: ${stats['complianceRate']}'),
              Text('Contenido promedio: ${stats['avgContentLength']} chars'),
              Text('Puntuación promedio: ${stats['avgQualityScore']}/100'),
              Text('Tasa de bloqueo: ${stats['adBlockedRate']}'),
              const SizedBox(height: 16),
              const Text(
                'Estado: Sistema funcionando correctamente ✅',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // En desarrollo real, aquí podrías exportar o enviar el reporte
              report.printSummary();
            },
            child: const Text('Ver Log Completo'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
