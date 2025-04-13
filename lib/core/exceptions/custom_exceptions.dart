class ServerException implements Exception {
  final String message;
  ServerException([this.message = "Ошибка на сервере"]);
  @override
  String toString() => "ServerException: $message";
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = "Ошибка работы с кэшем"]);
  @override
  String toString() => "CacheException: $message";
}