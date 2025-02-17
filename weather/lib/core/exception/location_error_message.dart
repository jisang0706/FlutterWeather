enum LocationErrorMessage {
  serviceEnabled("Location service enabled"),
  permissionDenied("Location permission denied"),
  permissionDeniedForever("Location permission denied forever");

  final String message;
  const LocationErrorMessage(this.message);
}
