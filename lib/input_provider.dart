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
  Materi materi = Materi(listText: [
    IsiMateri(text: "A. H1 Sub Materi", textType: TextType.h1),
    IsiMateri(
        text:
            "Hidrokarbon merupakan senyawa karbon yang paling sederhana. Namun demikian, hidrokarbon merupakan sumber utama untuk membentuk senyawa karbon yang lebih besar dan kompleks. Senyawa hidrokarbon terdiri dari atom karbon dan atom hidrogen. Untuk mengetahui adanya unsur karbon dan hidrogen dalam senyawa karbon dapat dilakukan suatu percobaan sederhana. Misalnya, pada pembakaran kayu, kertas, ikan, atau gula diperoleh zat yang berwama hitam. Zat yang berwarna hitam tersebut adalah karbon atau arang. Untuk membuktikan adanya hidrogen dalam senyawa karbon yaitu dengan memanaskan gula dalam tabung reaksi. Bintik air yang terbentuk pada dinding tabung sebelah dalam membuktikan adanya hidrogen. Secara kimiawi, kehadiran karbon dan oksigen dapat dilihat pada rumus atom pembentuk senyawa/molekul itu. Misalnya, metana. Molekul ini memiliki rumus CH4. Molekul ini terdiri atas atom C dan H. Hidrogen merupakan unsur teringan dan dalam keadaan bebas berupa molekul dwiatom yang berwujud gas. Hidrogen umumnya terdapat sebagai air atau zat-zat organik. Gas hidrogen merupakan gas yang tak berwarna, tak berbau dan tak berasa, sedikit larut dalam air. Senyawa hidrogen umumnya merupakan senyawa kovalen. Dalam kehidupan sehari-hari hidrogen digunakan sebagai bahan untuk membuat macam-macam persenyawaan organik, untuk mengeraskan minyak, bahan bakar dan pengisi balon udara. Tentu tidak asing lagi bagi kalian penggunaan gas elpiji untuk keperluan masak di rumah tangga seperti tampak pada gambar 1.1.",
        textType: TextType.freeText),
    IsiMateri(text: "1. H2 ", textType: TextType.h2),
    IsiMateri(text: "a. H3 ", textType: TextType.h3),
    IsiMateri(
        text:
            "Banyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berba",
        textType: TextType.h4),
  ]);
  bool loading = false;
  Uint8List? pdf;
  Uint8List? selectedImage;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedImage = result.files[0].bytes;
      petaKonsep.imagePath = selectedImage;
      notifyListeners();
    }
  }

  set inputJudulBab(String val) {
    bab.judulBab = val;
    notifyListeners();
  }

  addSubMateri(IsiMateri isiMateri) {
    materi.listText.add(isiMateri);
    notifyListeners();
  }

  removeMateri(IsiMateri isiMateri) {
    materi.listText.remove(isiMateri);
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
    pdf = await printAll(footer, bab, tujuan, petaKonsep, materi);
    loading = false;
    log(loading.toString());
    notifyListeners();
    return pdf!;
  }
}
