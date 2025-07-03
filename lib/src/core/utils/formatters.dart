import 'package:flutter/services.dart';

class Formatters {
  Formatters._();

  static List<TextInputFormatter> get cep => [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(8),
    TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll('-', '');
      if (text.length > 5) {
        return TextEditingValue(
          text: '${text.substring(0, 5)}-${text.substring(5)}',
          selection: TextSelection.collapsed(offset: text.length + 1),
        );
      }
      return newValue;
    }),
  ];
}
