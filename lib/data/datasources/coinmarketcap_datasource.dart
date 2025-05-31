import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

class CoinMarketCapDataSource {
  final http.Client client;

  CoinMarketCapDataSource({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> getCryptoQuotes(List<String> symbols) async {
    if (AppConstants.apiKey == "SUA_API_KEY_AQUI") {
       throw Exception(
          "Por favor, configure sua API Key da CoinMarketCap em lib/core/constants/app_constants.dart");
    }

    final symbolsParam = symbols.join(',');
    final uri = Uri.https(
        AppConstants.baseUrl, AppConstants.quotesLatestEndpoint, {
      'symbol': symbolsParam,
      'convert': 'USD,BRL', 
    });

    try {
      final response = await client.get(
        uri,
        headers: {
          'Accepts': 'application/json',
          'X-CMC_PRO_API_KEY': AppConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        String errorMessage = 'Falha ao carregar dados: ${response.statusCode}';
        try {
          final errorBody = json.decode(response.body);
          if (errorBody['status'] != null && errorBody['status']['error_message'] != null) {
            errorMessage += ' - ${errorBody['status']['error_message']}';
          }
        // ignore: empty_catches
        } catch (e) {
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Erro de conexão ou ao processar a requisição: ${e.toString()}');
    }
  }
}