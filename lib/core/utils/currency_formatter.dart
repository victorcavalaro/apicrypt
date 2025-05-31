import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatUsd(double amount) {
    final format = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return format.format(amount);
  }

  static String formatBrl(double amount) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return format.format(amount);
  }

  static String formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dateTime);
    } catch (e) {
      return dateString; 
    }
  }
}