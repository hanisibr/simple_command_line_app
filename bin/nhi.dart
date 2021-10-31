import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message);
    final name = decodedMessage['tick']['symbol'];
    final price = decodedMessage['tick']['quote'];
    final time = decodedMessage['tick']['epoch'];
    final serverTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);

    print('Name: $name, Price: $price, Date: $serverTime');
  });

  channel.sink.add('{"ticks": "cryBTCUSD", "subscribe": 1}');
}
