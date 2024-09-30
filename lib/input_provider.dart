import 'dart:async';
import 'dart:convert';
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
import 'package:image/image.dart' as ImageProcess;

class BooksProvider with ChangeNotifier {
  Bab bab = Bab();
  PageFooter footer = PageFooter();
  PetaKonsep petaKonsep = PetaKonsep();
  Tujuan tujuan = Tujuan();
  Materi materi = Materi(listText: [
    IsiMateri(text: "Senyawa Hidrokarbonat", textType: TextType.h1),
    IsiMateri(
        text:
            "Hidrogen merupakan unsur teringan dan dalam keadaan bebas berupa molekul dwiatom yang berwujud gas. Hidrogen umumnya terdapat sebagai air atau zat-zat organik. Gas hidrogen merupakan gas yang tak berwarna, tak berbau dan tak berasa, sedikit larut dalam air. Senyawa hidrogen umumnya merupakan senyawa kovalen. Dalam kehidupan sehari-hari hidrogen digunakan sebagai bahan untuk membuat macam-macam persenyawaan organik, untuk mengeraskan minyak, bahan bakar dan pengisi balon udara. Tentu tidak asing lagi bagi kalian penggunaan gas elpiji untuk keperluan masak di rumah tangga seperti tampak pada gambar 1.1. Pada mulanya senyawa karbon disebut senyawa organik karena senyawa itu berasal dari makhluk hidup. Namun, setelah diketahui bahwa senyawa 8 organik juga dapat dibuat oleh manusia maka senyawa organik berubah menjadi senyawa karbon. Selain senyawa organik dikenal juga senyawa anorganik, yaitu senyawa yang bukan berasal dari makhluk hidup. Senyawa organik dan anorganik mempunyai perbedaan dalam hal kereaktifan, titik cair, dan titik didih serta kelarutan. Perbedaannya yaitu senyawa organik mempunyai kereaktifan, titik cair, dan titik didih yang lebih rendah dibanding senyawa anorganik. Dalam hal kelarutan, senyawa organik lebih mudah larut dalam pelarut nonpolar seperti alkohol daripada dalam pelarut polar seperti air. Senyawa karbon didefinisikan sebagai semua senyawa yang mengandung atom karbon (C), dengan pengecualian senyawa karbon seperti oksida karbon, karbonat, dan sianida. Senyawa karbon yang paling sederhana dikenal dengan hidrokarbon, yang hanya terdiri dari atom karbon (C) dan hidrogen (H). Dalam senyawa karbon, selain unsur karbon dan hidrogen terdapat unsur lain seperti oksigen, nitrogen, sulfur atau posfor. Untuk mengetahui keberadaan unsur karbon, hidrogen dalam senyawa karbon dapat dilakukan dengan percobaan sederhana, misalnya dengan pembakaran. Salah satu contoh dari senyawa karbon adalah gula (C11H22O11). Adanya unsur karbon dan hidrogen pada gula pasir dapat ditunjukkan melalui reaksi pembakaran. Apabila senyawa gula pasir dibakar atau dioksidasi sempurna maka",
        textType: TextType.freeText),
    IsiMateri(text: "1.   Alkana ", textType: TextType.h2),
    IsiMateri(text: "a.   Rumus alkana ", textType: TextType.h3),
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
      final _imageFile = ImageProcess.decodeImage(
        selectedImage!,
      );
      String base64Image = base64Encode(ImageProcess.encodePng(_imageFile!));
      log(base64Image);
      final _byteImage = Base64Decoder().convert(base64Image);
      Widget image = Image.memory(_byteImage);

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
