enum ServerErrorMessage {
  connectionTimeout("Connection timeout"),
  sendTimeout("Send timeout"),
  receiveTimeout("Receive timeout"),
  badResponse("Bad response"),
  requestCancelled("Request to server was cancelled"),
  noInternet("No internet connection"),
  unexpected("Unexpected error occurred");

  final String message;
  const ServerErrorMessage(this.message);
}
