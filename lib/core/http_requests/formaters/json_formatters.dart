import 'dart:convert';
import 'decoders.dart';

class JsonFormatter implements Formatters {
  const JsonFormatter();

  @override
  dynamic decode(String data) => json.decode(data);

  @override
  String encode(Map<String, dynamic> data) => json.encode(data);

  @override
  String encodeList(List<Map<String, dynamic>> data) => json.encode(data);

  @override
  dynamic decodeList(String data) => json.decode(data ?? '[]');

  @override
  Decoder get decoder => this;

  @override
  Encoder get encoder => this;

  @override
  String getContentType() => 'application/json; charset=utf-8';
}
