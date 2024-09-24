import 'dart:typed_data';

import 'package:pdf/widgets.dart';

class Buku {
  List<Bab> listBab;
  Buku(this.listBab);
}

class Bab {
  String judulBab;
  int bab;

  Bab({this.judulBab = "Hidrokarbon", this.bab = 1});
}

class PageFooter {
  String judulFooter;

  PageFooter({
    this.judulFooter = "Fisika SMA X SMA/SMK Semester Genap (Kurikulum Merdeka)",
  });
}

class Tujuan {
  String tujuan;

  Tujuan({
    this.tujuan =
        "1. ...............\n3. ...............\n4. ...............\n5. ...............\n6. ...............\n7. ...............\n8. ...............\n9. ...............",
  });
}

class PetaKonsep {
  Uint8List? imagePath;

  PetaKonsep({
    this.imagePath,
  });
}

class Materi {

  List<IsiMateri> listText;
  Materi({
    this.listText = const [],
  });
}

class IsiMateri {
  String text;
  TextType textType;
  Uint8List? image;
  String? imageCaption;
  Alignment? alignment;
  List<String>? headerTabel;
  List<DataTabel>? dataTabel;
  String? tabelCaption;
  IsiMateri(
      {this.text = "Text Materi",
     required this.textType,
      this.imageCaption,
      this.alignment,
      this.image,
      this.headerTabel,
      this.dataTabel,
      this.tabelCaption});
}

enum TextType { h1, h2, h3, h4,freeText, imageSmall, imageBig, dropCap, tabel }

enum DataType {
  teks,
  image,
}

class DataTabel {
  List<Data>? dataTabel;
  DataTabel({this.dataTabel});
}

class Data {
  String? data;
  DataType type;
  Uint8List? image;
  Data({required this.data, this.type = DataType.teks, this.image});
}
