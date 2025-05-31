import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../data/models/crypto_model.dart';
import '../data/repositories/crypto_repository.dart';

enum ViewState { idle, loading, success, error }

class CryptoViewModel extends ChangeNotifier {
  final CryptoRepository _repository;

  CryptoViewModel({required CryptoRepository repository}) : _repository = repository;

  List<CryptoModel> _cryptos = [];
  List<CryptoModel> get cryptos => _cryptos;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchCryptos({String? symbols}) async {
    _setState(ViewState.loading);
    try {
      List<String> symbolsToFetch;
      if (symbols != null && symbols.trim().isNotEmpty) {
        symbolsToFetch = symbols.split(',').map((s) => s.trim().toUpperCase()).toList();
        symbolsToFetch.removeWhere((s) => s.isEmpty); 
        if (symbolsToFetch.isEmpty) { 
          symbolsToFetch = AppConstants.defaultSymbols;
        }
      } else {
        symbolsToFetch = AppConstants.defaultSymbols;
      }

      if (symbolsToFetch.isEmpty) {
        _cryptos = [];
        _setState(ViewState.success); 
        return;
      }

      _cryptos = await _repository.getCryptoList(symbolsToFetch);
      _setState(ViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }
}