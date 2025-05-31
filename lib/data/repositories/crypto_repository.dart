import '../datasources/coinmarketcap_datasource.dart';
import '../models/crypto_model.dart';

class CryptoRepository {
  final CoinMarketCapDataSource dataSource;

  CryptoRepository({required this.dataSource});

  Future<List<CryptoModel>> getCryptoList(List<String> symbols) async {
    if (symbols.isEmpty) {
      return [];
    }
    try {
      final rawData = await dataSource.getCryptoQuotes(symbols);
      final List<CryptoModel> cryptoList = [];

      if (rawData['data'] is Map<String, dynamic>) {
        final Map<String, dynamic> dataMap =
            rawData['data'] as Map<String, dynamic>;

        for (var symbolKey in dataMap.keys) {
          try {
            cryptoList.add(CryptoModel.fromJson(rawData, symbolKey));
          // ignore: empty_catches
          } catch (e) {}
        }
      } else {}

      if (cryptoList.isNotEmpty) {
        cryptoList.sort((a, b) {
          int indexA = symbols.indexOf(a.symbol.toUpperCase());
          int indexB = symbols.indexOf(b.symbol.toUpperCase());
          if (indexA != -1 && indexB != -1) {
            return indexA.compareTo(indexB);
          }
          return a.cmcRank.compareTo(b.cmcRank);
        });
      }

      return cryptoList;
    } catch (e) {
      rethrow;
    }
  }
}
