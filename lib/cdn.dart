import 'package:gabinandobin_app_toolkit/provider.dart';

String cdn(
  String key, {
  int? width,
  int? height,
  String? fit,
  double? ratio,
  int? quality,
}) {
  final uri = Uri.parse("${GO.config.cdnOrigin}/$key");

  final result = uri.replace(
      queryParameters: {
    "w": width?.toString(),
    "h": height?.toString(),
    "fit": fit,
    "q": quality?.toString(),
    "ar": ratio?.toString(),
  }..removeWhere((key, value) => value == null));

  return result.toString();
}
