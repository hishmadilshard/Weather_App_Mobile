// Server Exceptions
class ServerException implements Exception {
  final String message;
  
  const ServerException({required this.message});
  
  @override
  String toString() => 'ServerException: $message';
}

// Cache Exceptions
class CacheException implements Exception {
  final String message;
  
  const CacheException({required this.message});
  
  @override
  String toString() => 'CacheException: $message';
}

// Network Exceptions
class NetworkException implements Exception {
  final String message;
  
  const NetworkException({required this.message});
  
  @override
  String toString() => 'NetworkException: $message';
}

// Location Exceptions
class LocationException implements Exception {
  final String message;
  
  const LocationException({required this.message});
  
  @override
  String toString() => 'LocationException: $message';
}