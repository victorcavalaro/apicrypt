import 'package:flutter/material.dart';
import '../../data/models/crypto_model.dart';

void showCryptoDetailDialog(BuildContext context, CryptoModel crypto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${crypto.name} (${crypto.symbol})'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              _buildDetailRow('Nome:', crypto.name),
              _buildDetailRow('Símbolo:', crypto.symbol),
              _buildDetailRow('Adicionada em:', crypto.formattedDateAdded),
              _buildDetailRow('Preço (USD):', crypto.formattedPriceUsd),
              _buildDetailRow('Preço (BRL):', crypto.formattedPriceBrl),
              _buildDetailRow('Rank CMC:', crypto.cmcRank.toString()),
              _buildDetailRow('Volume (24h USD):', crypto.volume24h.toStringAsFixed(2)),
              Text(
                'Variação (24h): ${crypto.percentChange24h.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: crypto.percentChange24h >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Flexible(child: Text(value, textAlign: TextAlign.end)),
      ],
    ),
  );
}