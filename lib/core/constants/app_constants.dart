class AppConstants {
  static const String apiKey = "c6cf32df-4b9c-40ad-9c79-058c36dcd1cc"; 
  static const String baseUrl = "pro-api.coinmarketcap.com";
  static const String quotesLatestEndpoint = "/v2/cryptocurrency/quotes/latest";

  static const List<String> defaultSymbols = [
    'BTC', 'ETH', 'SOL', 'BNB', 'BCH', 'MKR', 'AAVE', 'DOT', 'SUI', 'ADA',
    'XRP', 'TIA', 'NEO', 'NEAR', 'PENDLE', 'RENDER', 'LINK', 'TON', 'XAI',
    'SEI', 'IMX', 'ETHFI', 'UMA', 'SUPER', 'FET', 'USUAL', 'GALA', 'PAAL', 'AERO'
  ];

  static const String defaultSymbolsString =
      'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO';
}