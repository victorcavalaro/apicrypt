import '../datasources/coinmarketcap_datasource.dart';
import '../models/crypto_model.dart';

class CryptoRepository {
  final CoinMarketCapDataSource dataSource;

  CryptoRepository({required this.dataSource});

  Future<List<CryptoModel>> getCryptoList(List<String> symbols) async {
    try {
      final rawData = await dataSource.getCryptoQuotes(symbols);
      final List<CryptoModel> cryptoList = [];

      if (rawData['data'] is Map<String, dynamic>) {
        (rawData['data'] as Map<String, dynamic>).forEach((symbolKey, value) {
          try {
            if (value is List && value.isNotEmpty) {
               final Map<String, dynamic> singleCryptoJson = {
                 "data": {
                   symbolKey: value
                 }
               };
              cryptoList.add(CryptoModel.fromJson(singleCryptoJson, symbolKey));
            } else if (value is Map<String, dynamic>) { 
               final Map<String, dynamic> singleCryptoJson = {
                 "data": {
                   symbolKey: [value] 
                 }
               };
              cryptoList.add(CryptoModel.fromJson(singleCryptoJson, symbolKey));
            }
          } catch (e) {
            print("Erro ao fazer parse do símbolo $symbolKey: $e");
          }
        });
      }
      return cryptoList;
    } catch (e) {
      print("Erro no CryptoRepository: $e");
      rethrow;
    }
  }
}