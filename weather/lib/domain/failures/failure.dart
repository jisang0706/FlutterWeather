// 에러핸들링을 위한 클래스
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message);
}

class LocationFailure extends Failure {
  LocationFailure({required String message}) : super(message);
}

class NormalFailure extends Failure {
  NormalFailure({required String message}) : super(message);
}

class NoDataFailure extends Failure {
  NoDataFailure({required String message}) : super(message);
}
