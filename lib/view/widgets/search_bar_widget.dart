import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onRefresh;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    required this.onRefresh, 
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'BTC,ETH,SOL (separados por vírgula)',
                labelText: 'Pesquisar Criptos',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    widget.onSearch(''); 
                  },
                ),
              ),
              onSubmitted: (value) => widget.onSearch(value),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blue),
            onPressed: () => widget.onSearch(_searchController.text),
            tooltip: 'Buscar',
          ),
          IconButton( 
            icon: const Icon(Icons.refresh, color: Colors.green),
            onPressed: widget.onRefresh,
            tooltip: 'Atualizar Dados',
          ),
        ],
      ),
    );
  }
}