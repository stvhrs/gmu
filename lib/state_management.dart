import 'dart:async';

import 'package:Bupin/models/models.dart';
import 'package:Bupin/pdf/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class BooksProvider with ChangeNotifier {
  Bab bab = Bab();
  PageFooter footer = PageFooter();
  PetaKonsep petaKonsep = PetaKonsep(imagePath: "imagePath");
  Tujuan tujuan = Tujuan();
  bool loading = false;
  Uint8List? pdf;

  set inputJudulBab(String val) {
    bab.judulBab = val;
  }

  set inputBab(String val) {
    bab.bab = int.parse(val);
  }

  set inputJudulFooter(String val) {
    footer.judulFooter = val;
    notifyListeners();
  }

  Future<Uint8List> generatePDF() async {
    pdf = await printAll(footer, bab, tujuan, petaKonsep);

    return pdf!;
  }
}
