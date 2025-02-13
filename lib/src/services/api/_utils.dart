part of 'api.dart';

abstract final class ApiClientUtils {
  static String? extractMessageFromResponse(http.Response response) {
    try {
      final Map<String, dynamic> body = json.decode(response.body) as Map<String, dynamic>;
      final String? customMessage = body['message'];

      return customMessage.isTruthy ? customMessage : null;
    } catch (e) {
      return null;
    }
  }
}
