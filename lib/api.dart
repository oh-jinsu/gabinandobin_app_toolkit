import 'dart:convert';

import 'package:http/http.dart' as http;
import "package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart";

abstract class GOAPI {
  String get baseUrl;

  GOAPICommand get(String path);

  GOAPICommand post(String path);

  GOAPICommand put(String path);

  GOAPICommand delete(String path);

  GOAPICommand patch(String path);

  GOAPICommand head(String path);

  Future<void> alert(http.Response response);
}

typedef GOAPIMiddleware = Future<http.Response> Function(http.Response response);

abstract class GOAPICommand {
  GOAPICommand header(String key, String value);

  GOAPICommand query(String key, String? value);

  GOAPICommand body(Object body);

  GOAPICommand json(Object body);

  GOAPICommand useAuth();

  GOAPICommand use(GOAPIMiddleware middleware);

  Future<http.Response> request();
}

extension GOResponseExtension on http.Response {
  bool get isOk => statusCode >= 200 && statusCode < 300;

  bool get isUnauthorized => statusCode == 401;

  bool get hasException => !isOk;

  dynamic json() => jsonDecode(utf8.decode(bodyBytes));

  alert() {
    GO.api.alert(this);
  }
}
