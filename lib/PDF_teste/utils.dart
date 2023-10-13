import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) {
    final NumberFormat numberFormat = new NumberFormat("R\$ #,##0.00", "pt_BR");
    return numberFormat.format(price);
  }

  // static formatPrice(double price) => 'R\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);
  // static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
