import 'dart:convert';

import 'package:gabinandobin_app_toolkit/api.dart';
import 'package:gabinandobin_app_toolkit/auth_api.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';
import 'package:http/http.dart' as http;

class GODefaultAPI implements GOAPI {
  @override
  final String baseUrl;

  GODefaultAPI({
    required this.baseUrl,
  });

  Uri endpoint(String path) => Uri.parse('$baseUrl$path');

  @override
  Future<void> alert(http.Response response) async {
    final body = utf8.decode(response.bodyBytes);

    GO.trace("API Error: ${response.statusCode} $body");

    if (response.statusCode >= 500) {
      return GO.alert(title: "서버 오류", message: "서버에서 오류가 발생했습니다.");
    }

    final message = (() {
      try {
        final json = response.json();

        return json["message"];
      } catch (e) {
        return "알 수 없는 오류가 발생했습니다.";
      }
    })();

    return GO.alert(title: "${response.statusCode}", message: message);
  }

  @override
  GOAPICommand delete(String path) {
    return GODefaultAPICommand(
      method: "DELETE",
      uri: endpoint(path),
    );
  }

  @override
  GOAPICommand get(String path) {
    return GODefaultAPICommand(
      method: "GET",
      uri: endpoint(path),
    );
  }

  @override
  GOAPICommand head(String path) {
    return GODefaultAPICommand(
      method: "HEAD",
      uri: endpoint(path),
    );
  }

  @override
  GOAPICommand patch(String path) {
    return GODefaultAPICommand(
      method: "PATCH",
      uri: endpoint(path),
    );
  }

  @override
  GOAPICommand post(String path) {
    return GODefaultAPICommand(
      method: "POST",
      uri: endpoint(path),
    );
  }

  @override
  GOAPICommand put(String path) {
    return GODefaultAPICommand(
      method: "PUT",
      uri: endpoint(path),
    );
  }
}

class GODefaultAPICommand implements GOAPICommand {
  final String method;

  final Uri uri;

  final Map<String, String> headers;

  final Map<String, String> queryParameters;

  final Object? _body;

  late final GOAPIMiddleware middleware;

  GODefaultAPICommand({
    required this.method,
    required this.uri,
    this.headers = const {},
    this.queryParameters = const {},
    GOAPIMiddleware? middleware,
    Object? body,
  }) : _body = body {
    this.middleware = middleware ?? (res) async => res;
  }

  GODefaultAPICommand copy({
    String? method,
    Uri? uri,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    GOAPIMiddleware? middleware,
    Object? body,
  }) {
    return GODefaultAPICommand(
      method: method ?? this.method,
      uri: uri ?? this.uri,
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
      body: body ?? _body,
      middleware: middleware ?? this.middleware,
    );
  }

  @override
  GODefaultAPICommand body(Object body) {
    return copy(body: body);
  }

  @override
  GODefaultAPICommand header(String key, String value) {
    return copy(headers: {
      ...headers,
      key: value,
    });
  }

  @override
  GODefaultAPICommand json(body) {
    return copy(
      headers: {
        ...headers,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  @override
  GODefaultAPICommand query(String key, String? value) {
    return copy(queryParameters: {
      ...queryParameters,
      key: value ?? "null",
    });
  }

  @override
  GODefaultAPICommand use(GOAPIMiddleware middleware) {
    return copy(middleware: (res) async => middleware(await this.middleware(res)));
  }

  @override
  GOAPICommand useAuth() {
    return header(
      "Authorization",
      "Bearer ${GO.secureStorage.findAccessToken()}",
    ).use((response) async {
      if (response.isUnauthorized) {
        final refreshToken = await GO.secureStorage.findRefreshToken();

        if (refreshToken == null) {
          return response;
        }

        final accessToken = await GO.require<GOAuthAPI>().refresh(refreshToken);

        GO.secureStorage.saveAccessToken(accessToken);

        return useAuth().request();
      }

      return response;
    });
  }

  @override
  Future<http.Response> request() async {
    final response = await middleware(await _request());

    GO.trace("API Response: ${response.statusCode}");

    return response;
  }

  Future<http.Response> _request() async {
    GO.trace("$method ${uri.replace(queryParameters: queryParameters)} $headers");

    switch (method) {
      case "GET":
        return http.get(uri.replace(queryParameters: queryParameters), headers: headers);
      case "POST":
        return http.post(uri.replace(queryParameters: queryParameters), headers: headers, body: _body);
      case "PUT":
        return http.put(uri.replace(queryParameters: queryParameters), headers: headers, body: _body);
      case "DELETE":
        return http.delete(uri.replace(queryParameters: queryParameters), headers: headers);
      case "PATCH":
        return http.patch(uri.replace(queryParameters: queryParameters), headers: headers, body: _body);
      case "HEAD":
        return http.head(uri.replace(queryParameters: queryParameters), headers: headers);
      default:
        throw Exception("Unsupported method: $method");
    }
  }
}
