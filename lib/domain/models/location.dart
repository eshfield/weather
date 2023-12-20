import 'package:flutter/material.dart';

class Location {
  final double latitude;
  final double longitude;
  final String originalName;
  final Map<String, String> localNames;
  final String country;

  Location({
    required this.latitude,
    required this.longitude,
    required this.originalName,
    required this.localNames,
    required this.country,
  });

  String getLocationName(Locale locale) {
    final city = localNames[locale.languageCode] ?? originalName;
    return '$city, $country' ;
  }
}
