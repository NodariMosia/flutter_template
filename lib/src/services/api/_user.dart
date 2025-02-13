part of 'api.dart';

class FlutterTemplateUserApi {
  static FlutterTemplateUserApi? _instance;

  const FlutterTemplateUserApi._();

  factory FlutterTemplateUserApi.init() {
    _instance ??= const FlutterTemplateUserApi._();
    return _instance!;
  }

  Future<http.Response> getSelf({PostRequestHookOptions? options}) async {
    if (!UserProvider.instance.hasSession) {
      return postRequestHook(http.Response('', HttpStatus.unauthorized));
    }

    throw UnimplementedError();
  }

  Future<http.Response> selfUpdate({
    String? locale,
    PostRequestHookOptions? options,
  }) async {
    if (!UserProvider.instance.hasSession) {
      return postRequestHook(http.Response('', HttpStatus.unauthorized));
    }

    throw UnimplementedError();
  }

  Future<http.Response> selfUpdatePassword(
    String oldPassword,
    String newPassword, {
    PostRequestHookOptions? options,
  }) {
    if (!UserProvider.instance.hasSession) {
      return postRequestHook(http.Response('', HttpStatus.unauthorized));
    }

    throw UnimplementedError();
  }

  Future<http.Response> signup(
    User user, {
    PostRequestHookOptions? options,
  }) async {
    throw UnimplementedError();
  }

  Future<http.Response> loginWithEmail(
    String email,
    String password, {
    PostRequestHookOptions? options,
  }) async {
    throw UnimplementedError();
  }

  Future<http.Response> requestPasswordReset(
    String email, {
    PostRequestHookOptions? options,
  }) async {
    throw UnimplementedError();
  }

  Future<http.Response> verifyPasswordReset(
    String email,
    String code, {
    PostRequestHookOptions? options,
  }) async {
    throw UnimplementedError();
  }

  Future<http.Response> resetPassword(
    String email,
    String code,
    String newPassword, {
    PostRequestHookOptions? options,
  }) async {
    throw UnimplementedError();
  }
}
