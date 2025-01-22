import 'dart:convert';

decodejwt(String token) {
  final parts = token.split('.');

  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = parts[1];

  var normalized = base64Url.normalize(payload);

  var resp = utf8.decode(base64Url.decode(normalized));

  return json.decode(resp);
}
