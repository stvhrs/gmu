import 'package:flutter/material.dart';

class Helper {
 static dynamic hyphenate(TextEditingController con) {
    String previousText = "", currentText = "";
 final value = con.value;
    final cursorPosition = con.selection.base.offset;
    final text = value.text;
    final selection = value.selection;
    final textList = text.substring(0, selection.extentOffset).split('\n');
    currentText =
        textList.length <= 1 ? textList[0] : textList[textList.length - 2];
    if (text.substring(0, selection.extentOffset).endsWith("\n")) {
      if (currentText.length > 0 &&
          currentText[0] == "-" &&
          text.length > previousText.length) {
        final newCursorPosition = cursorPosition + 1;
        con.value = TextEditingValue(
          text: text.substring(0, selection.extentOffset) +
              "-" +
              text.substring(selection.extentOffset, text.length),
          selection: TextSelection.collapsed(offset: newCursorPosition),
        );
      }
    }
    previousText = text;
    return con.value;
  }
}
