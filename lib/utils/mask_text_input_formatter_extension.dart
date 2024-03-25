import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension MaskTextInputFormatterExtension on MaskTextInputFormatter {
  void setText(TextEditingController controller, String? text) {
    if (text == null) {
      controller.clear();
      return;
    }
    controller.value = formatEditUpdate(
        controller.value, TextEditingValue(text: unmaskText(text)));
  }
}

extension TextEditingControllerExtension on TextEditingController {
  void setText(MaskTextInputFormatter mask, String? text) {
    mask.setText(this, text);
  }
}
