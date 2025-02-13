part of 'api.dart';

const Map<String, String> _contentTypeJsonHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

class ApiClientPrintOptions {
  final String funcName;
  final bool printBody;
  const ApiClientPrintOptions(this.funcName, [this.printBody = true]);
}

abstract final class _ApiClient {
  /// API call threshold.
  /// Create a new instance of http client after a minimum given number of calls
  /// have been made ([_minCallsBeforeNewInstance]).
  /// Needed, because otherwise SocketException occurs after some time of
  /// reusing same http client.
  static int _totalCalls = 0;
  // Record ongoing calls - needed, because otherwise a forced close and
  // new instance of http client may cause problems with pending calls.
  static int _ongoingCalls = 0;
  static const int _minCallsBeforeNewInstance = 200;

  static http.Client _client = http.Client();

  static void refreshClient() {
    _client.close();
    _client = http.Client();
  }

  // NOTE: Currently not used.
  // ignore: unused_element
  static Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    ApiClientPrintOptions? printOptions,
    PostRequestHookOptions? postRequestHookOptions,
  }) {
    return send(
      _buildDefaultRequest('GET', path, headers, body),
      printOptions: printOptions,
      postRequestHookOptions: postRequestHookOptions,
    );
  }

  // NOTE: Currently not used.
  // ignore: unused_element
  static Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    ApiClientPrintOptions? printOptions,
    PostRequestHookOptions? postRequestHookOptions,
  }) {
    return send(
      _buildDefaultRequest('POST', path, headers, body),
      printOptions: printOptions,
      postRequestHookOptions: postRequestHookOptions,
    );
  }

  // NOTE: Currently not used.
  // ignore: unused_element
  static Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    ApiClientPrintOptions? printOptions,
    PostRequestHookOptions? postRequestHookOptions,
  }) {
    return send(
      _buildDefaultRequest('PUT', path, headers, body),
      printOptions: printOptions,
      postRequestHookOptions: postRequestHookOptions,
    );
  }

  // NOTE: Currently not used.
  // ignore: unused_element
  static Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    ApiClientPrintOptions? printOptions,
    PostRequestHookOptions? postRequestHookOptions,
  }) {
    return send(
      _buildDefaultRequest('DELETE', path, headers, body),
      printOptions: printOptions,
      postRequestHookOptions: postRequestHookOptions,
    );
  }

  static Future<http.Response> send(
    http.BaseRequest request, {
    ApiClientPrintOptions? printOptions,
    PostRequestHookOptions? postRequestHookOptions,
  }) async {
    _handleCallStart();

    final http.Response response = await _socketExceptionHandler(() async {
      return http.Response.fromStream(await _client.send(request));
    });

    _handleCallComplete(response, options: printOptions);

    return postRequestHook(response, options: postRequestHookOptions);
  }

  static http.Request _buildDefaultRequest(
    String method,
    String path,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  ) {
    return http.Request(method, Uri.parse('${FlutterTemplateApi.host}$path'))
      ..headers.clear()
      ..headers.addAll({
        ...?headers,
        ..._contentTypeJsonHeader,
      })
      ..body = body == null ? '' : jsonEncode(body);
  }

  static void _handleCallStart() {
    _totalCalls++;
    _ongoingCalls++;
  }

  static void _handleCallComplete(
    http.Response response, {
    ApiClientPrintOptions? options,
  }) {
    if (options != null) {
      final sb = StringBuffer('${options.funcName}: ${response.statusCode}');
      if (response.request != null) sb.write(' (${response.request})');
      if (options.printBody) sb.write(';body: \n(${response.body})');
      log(sb.toString());
    }

    if (_ongoingCalls > 0) _ongoingCalls--;
    if (_ongoingCalls < 0) _ongoingCalls = 0;
    if (_ongoingCalls == 0 && _totalCalls >= _minCallsBeforeNewInstance) {
      log('Closing existing http client and creating new one');
      refreshClient();
      _totalCalls = 0;
    }
  }

  static Future<http.Response> _socketExceptionHandler(
    Future<http.Response> Function() func,
  ) async {
    try {
      return await func();
    } on SocketException {
      return http.Response('', 444, persistentConnection: true);
    }
  }
}
