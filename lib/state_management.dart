import 'dart:async';
import 'dart:developer';

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
  PetaKonsep petaKonsep = PetaKonsep(imagePath: "imagePath");
  Tujuan tujuan = Tujuan();
  bool loading = false;
  Uint8List? pdf;
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  Future<void> pickImage( ) async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, );
    if (image != null) {
      selectedImage = image;
      log(selectedImage!.path);
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
final PDFPageFormat pageFormat = PDFPageFormat(
   width: 90 * 3,  //max width of the page
   height: 270 * 3 ,//max height of the page,
   marginTop: 0,
   marginBottom: 0,
   marginLeft: 0,
   marginRight: 0,
);
PDFConverter pdfConverter = PDFConverter(pageFormat:PDFPageFormat(
   width: 90 * 3,  //max width of the page
   height: 270 * 3 ,//max height of the page,
   marginTop: 0,
   marginBottom: 0,
   marginLeft: 0,
   marginRight: 0,
),
    backMatterDelta: null,
    frontMatterDelta: null,
    document: QuillController.basic().document.toDelta(),
    fallbacks: [],
 
);
  Future<Uint8List> generatePDF() async {
    loading = true;
    log(loading.toString());
    pdf = await printAll(footer, bab, tujuan, petaKonsep);
    loading = false;
    log(loading.toString());
    return pdf!;
  }
}
