part of 'api.dart';

class PostRequestHookOptions {
  final BuildContext? context;
  final bool navigateToLogin;
  final bool useRootNavigator;
  final bool canShowDefaultSnackbars;

  const PostRequestHookOptions({
    this.context,
    this.navigateToLogin = false,
    this.useRootNavigator = false,
    this.canShowDefaultSnackbars = false,
  });

  static const PostRequestHookOptions _default = PostRequestHookOptions();
}

Future<http.Response> postRequestHook(
  http.Response response, {
  PostRequestHookOptions? options,
}) async {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return response;
  }

  options ??= PostRequestHookOptions._default;

  bool canShowSnackbar = options.canShowDefaultSnackbars;
  void showSnackbar(String message) {
    if (canShowSnackbar) AppFlushbar.bottomError(message).showSnackbar();
  }

  final String? customMessage = ApiClientUtils.extractMessageFromResponse(response);
  log('HTTP/1.1 ${response.statusCode}: ("${response.reasonPhrase ?? ''}" - "$customMessage")');

  if (customMessage != null) {
    showSnackbar(customMessage);
    canShowSnackbar = false;
  }

  switch (response.statusCode) {
    case HttpStatus.badRequest:
      throw BadRequestException(response.reasonPhrase ?? 'BAD_REQUEST');

    case HttpStatus.unauthorized:
      if (options.context != null && options.navigateToLogin) {
        options.context!.push(
          const LoginPage(),
          isCupertino: true,
          rootNavigator: options.useRootNavigator,
        );

        break;
      } else {
        throw const UnauthorizedAccessException();
      }

    case HttpStatus.conflict:
      throw const ConflictException();

    case HttpStatus.notFound:
      showSnackbar(LocaleProvider.instance.l10n.notFound);
      throw NotFoundException(response.request?.url.toString() ?? FlutterTemplateApi.host);

    case HttpStatus.connectionClosedWithoutResponse:
      showSnackbar(LocaleProvider.instance.l10n.checkInternetConnection);
      throw FailedHostLookupException(response.request?.url.toString() ?? FlutterTemplateApi.host);

    case HttpStatus.internalServerError:
      showSnackbar(LocaleProvider.instance.l10n.somethingWentWrong);
      throw const InternalServerError();

    case HttpStatus.badGateway:
      showSnackbar(LocaleProvider.instance.l10n.serverIsUnderMaintenanceTryAgainLater);
      throw const BadGetawayException();

    default:
      final String message = 'Request failed with ${response.statusCode}, ${response.body}';
      throw Exception(message);
  }

  return response;
}
