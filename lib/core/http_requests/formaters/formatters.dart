import 'decoders.dart';

abstract class Formatters implements Decoder, Encoder {
  const Formatters();
  String getContentType();

  Decoder get decoder => this;
  Encoder get encoder => this;
}
