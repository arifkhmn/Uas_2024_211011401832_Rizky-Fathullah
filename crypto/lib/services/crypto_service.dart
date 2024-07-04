import 'dart:convert';
import 'package:crypto/model/crypto.dart';
import 'package:http/http.dart' as http;

class CryptoService {
  Future<List<Crypto>> fetchCryptos() async {
    final response = await http.get(Uri.parse('https://api.coinlore.net/api/tickers/'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      return data.map((json) => Crypto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cryptos');
    }
  }
}
