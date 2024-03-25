import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final MaskTextInputFormatter placaInputFormatter =
    MaskTextInputFormatter(mask: 'AAA-#X##', filter: {
  "#": RegExp('[0-9]'),
  "A": RegExp('[a-zA-Z]', caseSensitive: false),
  "X": RegExp('[a-zA-Z0-9]'),
});

class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
