import 'dart:async';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_to_pdf/converter/configurator/converter_option/pdf_page_format.dart';
import 'package:flutter_quill_to_pdf/converter/pdf_converter.dart';
import 'package:gmu/models/models.dart';
import 'package:gmu/pdf/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class BooksProvider with ChangeNotifier {
  Bab bab = Bab();
  PageFooter footer = PageFooter();
  PetaKonsep petaKonsep = PetaKonsep();
  Tujuan tujuan = Tujuan();
  bool loading = false;
  Uint8List? pdf;
  Uint8List? selectedImage;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedImage = result.files[0].bytes;
      petaKonsep.imagePath=selectedImage;
      notifyListeners();
    }
  }

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

  set inputTujuan(String val) {
    tujuan.tujuan = val;
    notifyListeners();
  }

  set inputPeta(Uint8List val) {
    petaKonsep.imagePath = val;
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
