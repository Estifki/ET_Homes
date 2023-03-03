class HttpException implements Exception {
  String errorMessage;
  HttpException({required this.errorMessage});

  @override
  String toString() {
    
    return errorMessage;
  }
}
