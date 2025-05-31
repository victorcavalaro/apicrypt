import '../../core/utils/currency_formatter.dart';

class CryptoModel {
  final int id;
  final String name;
  final String symbol;
  final String dateAdded;
  final double priceUsd;
  final double priceBrl;
  final double percentChange24h;
  final double volume24h;
  final int cmcRank;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.dateAdded,
    required this.priceUsd,
    required this.priceBrl,
    required this.percentChange24h,
    required this.volume24h,
    required this.cmcRank,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json, String symbolKey) {
    final cryptoData = json['data'][symbolKey];
    if (cryptoData == null) {
      throw FormatException("Dados não encontrados para o símbolo: $symbolKey");
    }
    final data = cryptoData[0];
    final quote = data['quote'];

    return CryptoModel(
      id: data['id'] ?? 0,
      name: data['name'] ?? 'N/A',
      symbol: data['symbol'] ?? 'N/A',
      dateAdded: data['date_added'] ?? DateTime.now().toIso8601String(),
      priceUsd: (quote['USD']?['price'] ?? 0.0).toDouble(),
      priceBrl: (quote['BRL']?['price'] ?? 0.0).toDouble(),
      percentChange24h: (quote['USD']?['percent_change_24h'] ?? 0.0).toDouble(),
      volume24h: (quote['USD']?['volume_24h'] ?? 0.0).toDouble(),
      cmcRank: data['cmc_rank'] ?? 0,
    );
  }

  String get formattedPriceUsd => CurrencyFormatter.formatUsd(priceUsd);
  String get formattedPriceBrl => CurrencyFormatter.formatBrl(priceBrl);
  String get formattedDateAdded => CurrencyFormatter.formatDate(dateAdded);
}