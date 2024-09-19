import 'dart:async';
import 'dart:developer';

import 'package:gmu/models/models.dart';
import 'package:gmu/pdf/service.dart';
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
    notifyListeners();
  }

  set inputBab(String val) {
    bab.bab = int.parse(val);
    notifyListeners();
  }

  set inputJudulFooter(String val) {
    footer.judulFooter = val;
    notifyListeners();
  }

  Future<Uint8List> generatePDF() async {
    loading = true;
    log(loading.toString());
    pdf = await printAll(footer, bab, tujuan, petaKonsep);
    loading = false;
    log(loading.toString());
    return pdf!;
  }
}
