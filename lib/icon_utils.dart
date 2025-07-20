import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Utilidad global para mapear strings a IconData en toda la app.
IconData getIconData(String iconName) {
  // Log para depuración
  // ignore: avoid_print
  print('[icon_utils] iconName recibido: $iconName');
  switch (iconName) {
    case 'account_balance':
      return Icons.account_balance;
    case 'museum':
      return Icons.museum;
    case 'account_balance_wallet':
      return Icons.account_balance_wallet;
    case 'brush':
      return Icons.brush;
    case 'history_edu':
      return Icons.history_edu;
    case 'restaurant':
      return Icons.restaurant;
    case 'restaurant_menu':
      return Icons.restaurant_menu;
    case 'dining':
      return Icons.dining;
    case 'local_bar':
      return Icons.local_bar;
    case 'local_drink':
      return Icons.local_drink;
    case 'sports_bar':
      return Icons.sports_bar;
    case 'fastfood':
      return Icons.fastfood;
    case 'landscape':
      return Icons.landscape;
    case 'terrain':
      return Icons.terrain;
    case 'nature':
      return Icons.nature;
    case 'forest':
      return Icons.forest;
    case 'hiking':
      return Icons.hiking;
    case 'directions_walk':
      return Icons.directions_walk;
    case 'nightlight_round':
      return Icons.nightlight_round;
    case 'emoji_objects':
      return Icons.emoji_objects;
    case 'music_note':
      return Icons.music_note;
    case 'theater_comedy':
      return Icons.theater_comedy;
    case 'nightlife':
      return Icons.nightlife;
    case 'tour':
      return Icons.tour;
    default:
      // Log para iconos no reconocidos
      if (kDebugMode) {
        print('[icon_utils] iconName no reconocido, usando Icons.location_on');
      }
      return Icons.location_on;
  }
}
