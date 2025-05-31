import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/coinmarketcap_datasource.dart';
import 'data/repositories/crypto_repository.dart';
import 'viewmodel/crypto_viewmodel.dart';
import 'view/screens/crypto_list_screen.dart';
import 'package:intl/date_symbol_data_local.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  final coinMarketCapDataSource = CoinMarketCapDataSource();
  final cryptoRepository = CryptoRepository(dataSource: coinMarketCapDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CryptoViewModel(repository: cryptoRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinMarketCap App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        brightness: Brightness.light, 
      ),
      home: const CryptoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}