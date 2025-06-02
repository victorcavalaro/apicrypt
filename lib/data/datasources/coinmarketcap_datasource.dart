import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

class CoinMarketCapDataSource {
  final http.Client client;

  CoinMarketCapDataSource({http.Client? client})
    : client = client ?? http.Client();

  Future<Map<String, dynamic>> getCryptoQuotes(List<String> symbols) async {
    if (AppConstants.apiKey == "SUA_API_KEY_AQUI" ||
        AppConstants.apiKey.trim().isEmpty) {
      throw Exception(
        "Por favor, configure sua API Key da CoinMarketCap em lib/core/constants/app_constants.dart",
      );
    }

    if (symbols.isEmpty) {
      return {"data": {}};
    }

    final symbolsParam = symbols.join(',');
    final uri = Uri.https(
      AppConstants.baseUrl,
      AppConstants.quotesLatestEndpoint,
      {
        'symbol': symbolsParam,
        'convert': 'USD',
      },
    );

    try {
      final response = await client.get(
        uri,
        headers: {
          'Accepts': 'application/json',
          'X-CMC_PRO_API_KEY': AppConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        String errorMessage =
            'Falha ao carregar dados da API: ${response.statusCode}';
        try {
          final errorBody = json.decode(response.body);
          if (errorBody['status'] != null &&
              errorBody['status']['error_message'] != null) {
            errorMessage += ' - ${errorBody['status']['error_message']}';
          } else {
            errorMessage += ' - Corpo da resposta: ${response.body}';
          }
        } catch (e) {
          print('DataSource: Falha ao fazer parse do corpo do erro da API: $e');
          errorMessage += ' - Corpo da resposta (sem parse): ${response.body}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(
        'Erro de conexão ou ao processar a requisição: ${e.toString()}',
      );
    }
  }
}
