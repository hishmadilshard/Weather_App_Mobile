// ignore_for_file: prefer_const_constructors

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(String city, String weatherData);
  Future<String?> getCachedWeather(String city);
  Future<void> addFavoriteCity(String city);
  Future<void> removeFavoriteCity(String city);
  Future<List<String>> getFavoriteCities();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(String city, String weatherData) async {
    try {
      await sharedPreferences.setString('cached_weather_$city', weatherData);
      await sharedPreferences.setString(
          'cached_weather_time_$city', DateTime.now().toIso8601String());
    } catch (e) {
      throw CacheException(message: 'Failed to cache weather data');
    }
  }

  @override
  Future<String?> getCachedWeather(String city) async {
    try {
      final cachedData = sharedPreferences.getString('cached_weather_$city');
      final cachedTime = sharedPreferences.getString('cached_weather_time_$city');
      
      if (cachedData != null && cachedTime != null) {
        final cacheDateTime = DateTime.parse(cachedTime);
        final now = DateTime.now();
        final difference = now.difference(cacheDateTime);
        
        // Return cached data only if it's less than 30 minutes old
        if (difference.inMinutes < 30) {
          return cachedData;
        }
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to get cached weather data');
    }
  }

  @override
  Future<void> addFavoriteCity(String city) async {
    try {
      final favorites = sharedPreferences.getStringList('favorite_cities') ?? [];
      if (!favorites.contains(city)) {
        favorites.add(city);
        await sharedPreferences.setStringList('favorite_cities', favorites);
      }
    } catch (e) {
      throw CacheException(message: 'Failed to add favorite city');
    }
  }

  @override
  Future<void> removeFavoriteCity(String city) async {
    try {
      final favorites = sharedPreferences.getStringList('favorite_cities') ?? [];
      favorites.remove(city);
      await sharedPreferences.setStringList('favorite_cities', favorites);
    } catch (e) {
      throw CacheException(message: 'Failed to remove favorite city');
    }
  }

  @override
  Future<List<String>> getFavoriteCities() async {
    try {
      return sharedPreferences.getStringList('favorite_cities') ?? [];
    } catch (e) {
      throw CacheException(message: 'Failed to get favorite cities');
    }
  }
}