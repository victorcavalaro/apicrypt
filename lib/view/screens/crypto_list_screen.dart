import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/crypto_viewmodel.dart';
import '../widgets/crypto_detail_dialog.dart';
import '../widgets/search_bar_widget.dart'; 

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CryptoViewModel>(context, listen: false).fetchCryptos();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh(CryptoViewModel viewModel) async {
    await viewModel.fetchCryptos(symbols: _searchController.text);
  }

  void _onSearch(CryptoViewModel viewModel, String query) {
     _searchController.text = query; 
    viewModel.fetchCryptos(symbols: query);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criptomoedas - CoinMarketCap'),
      ),
      body: Consumer<CryptoViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              SearchBarWidget(
                onSearch: (query) => _onSearch(viewModel, query),
                onRefresh: () => _onRefresh(viewModel), 
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _onRefresh(viewModel),
                  child: _buildBody(viewModel),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(CryptoViewModel viewModel) {
    switch (viewModel.state) {
      case ViewState.loading:
        return const Center(child: CircularProgressIndicator());
      case ViewState.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Erro ao carregar dados:\n${viewModel.errorMessage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar Novamente'),
                  onPressed: () => _onRefresh(viewModel),
                )
              ],
            ),
          ),
        );
      case ViewState.success:
        if (viewModel.cryptos.isEmpty) {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Nenhuma criptomoeda encontrada.'),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Carregar Padrão'),
                    onPressed: () {
                       _searchController.clear(); 
                      _onRefresh(viewModel); 
                    }
                  )
                ],
              )
          );
        }
        return ListView.builder(
          itemCount: viewModel.cryptos.length,
          itemBuilder: (context, index) {
            final crypto = viewModel.cryptos[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text(
                    crypto.symbol.length > 2 ? crypto.symbol.substring(0,2) : crypto.symbol,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                title: Text('${crypto.name} (${crypto.symbol})'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('USD: ${crypto.formattedPriceUsd}'),
                    Text('BRL: ${crypto.formattedPriceBrl}'),
                  ],
                ),
                trailing: Text(
                  '${crypto.percentChange24h.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: crypto.percentChange24h >= 0 ? Colors.green : Colors.red,
                  ),
                ),
                onTap: () {
                  showCryptoDetailDialog(context, crypto);
                },
              ),
            );
          },
        );
      case ViewState.idle:
      default:
        return const Center(child: Text('Use a busca ou o botão de atualizar para carregar os dados.'));
    }
  }
}