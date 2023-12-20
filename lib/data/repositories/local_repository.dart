import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/models.dart';
import '../dtos/location_dto.dart';
import '../mappers/location_mapper.dart';

const prefsAppKey = 'weather';
const localeKey = '$prefsAppKey:locale';
const locationKey = '$prefsAppKey:location';

class LocalRepository {
  Future<Locale?> getLocale(Locale defaultLocale) async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(localeKey);
    if (languageCode == null) return null;
    return Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(localeKey, locale.languageCode);
  }

  Future<Location?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(locationKey);
    if (json == null) return null;
    final locationDto = LocationDto.fromJson(jsonDecode(json));
    return locationDto.toDomain();
  }

  Future<void> setLocation(Location location) async {
    final prefs = await SharedPreferences.getInstance();
    final locationDto = location.toDto();
    await prefs.setString(locationKey, jsonEncode(locationDto));
  }
}
