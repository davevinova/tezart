import 'dart:typed_data';
import 'dart:io';
import 'package:test/test.dart';
import 'package:tezart/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:tezart/env/env.dart';

void main() {
  final decodedAddress = Uint8List.fromList(<int>[
    133,
    150,
    69,
    73,
    131,
    91,
    131,
    238,
    27,
    209,
    60,
    160,
    78,
    103,
    17,
    231,
    140,
    79,
    21,
    176
  ]);

  final encodedAddress = 'tz1XpNacx7vQ9y8ugdAc8p99LVfjudKjagVq';

  // Encode
  group('.encodeTz', () {
    test('encodes addresses correctly', () {
      expect(crypto.encodeTz(prefix: 'tz1', bytes: decodedAddress),
          encodedAddress);
    });
  });

  // Decode
  group('.decodeTz', () {
    test('decodes an address correctly', () {
      expect(crypto.decodeTz(encodedAddress), decodedAddress);
    });
  });

  // TODO: remove this test when a test calling the node is implemented
  test("ci", () async {
    final host = Env.tezosNodeHost;
    final port = Env.tezosNodePort;
    final scheme = Env.tezosNodeScheme;
    final baseUrl = '$scheme://$host:$port';
    var response = await http.get('$baseUrl/chains/main/mempool/pending_operations');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    expect(response.statusCode, 200);
  });
}