

import 'dart:typed_data';

class Bab {
   String judulBab;
   int bab;

  Bab({ this.judulBab="Kosong",  this.bab=0});
}

class PageFooter {
   String judulFooter;

  PageFooter({
     this.judulFooter="Kosong",
  });
}


class Tujuan {
   String tujuan;

  Tujuan({
     this.tujuan="Kosong",
  });
}
class PetaKonsep {
   Uint8List? imagePath;

  PetaKonsep({
     this.imagePath,
  });
}
