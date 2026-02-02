class LocationException implements Exception {
  const LocationException(this.message);
  final String message;

  @override
  String toString() => 'LocationException: $message';
}

class LocationServiceException extends LocationException {
  LocationServiceException(super.message);
}

class LocationPermissionException extends LocationException {
  LocationPermissionException(super.message);
}
