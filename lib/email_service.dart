import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class EmailService {
  // Método alternativo usando el cliente de email predeterminado del dispositivo
  static Future<bool> sendEmailWithDefaultClient({
    required String recipientEmail,
    required String subject,
    required String body,
    required String senderName,
    required String senderEmail,
    List<File>? attachments,
  }) async {
    try {
      // Crear el mailto URL
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: recipientEmail,
        query: _encodeQueryParameters({
          'subject': subject,
          'body':
              '''
Nombre: $senderName
Email: $senderEmail

$body

---
Enviado desde Toledo Tour App
          ''',
        }),
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
        return true;
      }
    } catch (e) {
      debugPrint('Error al enviar email: $e');
    }
    return false;
  }

  static String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  // Método para mostrar información sobre adjuntos
  static String getAttachmentsInfo(List<File> attachments) {
    if (attachments.isEmpty) return '';

    String info = '\n\nArchivos adjuntos:\n';
    for (int i = 0; i < attachments.length; i++) {
      final file = attachments[i];
      final fileName = file.path.split('/').last;
      final fileSize = _getFileSize(file);
      info += '${i + 1}. $fileName ($fileSize)\n';
    }

    info += '\nNota: Los archivos adjuntos deben enviarse por separado.';
    return info;
  }

  static String _getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
