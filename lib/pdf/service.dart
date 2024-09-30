/*
 * Copyright (C) 3017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';

import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:gmu/models/models.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math; // import this
import 'dart:developer' as dev;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

//#22B573
class User {
  final String name;
  final int age;
  const User({required this.name, required this.age});
}

const listAlphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];
const listAlphabetH2 = ["a", "b", "c", "d", "e", "f", "g"];

            class FreeText extends StatelessWidget {
  final IsiMateri isi;
  PdfColor green = PdfColor.fromHex("#22B573");

  PdfColor white = PdfColor.fromHex("#ffffff");

  FreeText({required this.isi, });

  Widget build(context) {
    return SizedBox(
        child: Text("      " + isi.text,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.span,
            style: TextStyle(
              fontSize: 11,
            )));
}}
class Heading4 extends StatelessWidget {
  final IsiMateri isi;
  PdfColor green = PdfColor.fromHex("#22B573");

  PdfColor white = PdfColor.fromHex("#ffffff");

  Heading4({required this.isi, });

  Widget build(context) {
    return Padding(
        padding: EdgeInsets.only(left: 17),
        child: Text(
            textAlign: TextAlign.justify,
            "      " + isi.text,
            style: TextStyle(fontSize: 11)));
}}
class Heading3 extends StatelessWidget {
  final IsiMateri isi;
  PdfColor green = PdfColor.fromHex("#22B573");

  PdfColor white = PdfColor.fromHex("#ffffff");

  Heading3({required this.isi, });

  Widget build(context) {
    return Padding(
        padding: EdgeInsets.only(left: 17, top: 5),
        child: Text(isi.text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)));
  }
}
class Heading2 extends StatelessWidget {
  final IsiMateri isi;
  PdfColor green = PdfColor.fromHex("#22B573");

  PdfColor white = PdfColor.fromHex("#ffffff");

  Heading2({required this.isi, });

  Widget build(context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 5,
        ),
        child: Text(isi.text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: green, fontSize: 11)));
  }
}
class Heading1 extends StatelessWidget {
  final IsiMateri isi;
  final ImageProvider imagePointer;
  PdfColor green = PdfColor.fromHex("#22B573");

  PdfColor white = PdfColor.fromHex("#ffffff");

  Heading1({required this.isi, required this.imagePointer});

  Widget build(context) {
    return Container(
        margin: EdgeInsets.only(left: 18, bottom: 20, top: 20),
        child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Container(
                  height: 25,
                  padding: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  child: Text(isi.text,
                      style: TextStyle(
                          fontSize: 14,
                          color: green,
                          fontWeight: FontWeight.bold)),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: white,
                      borderRadius: BorderRadius.circular(12))),
              Positioned(
                  left: -21,
                  child: Stack(alignment: Alignment.center, children: [
                    Image(imagePointer, width: 40),
                    Positioned(
                        left: 10.5,
                        child: Text("A",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: white)))
                  ])),
            ]));
  }
}

class Footer extends StatelessWidget {
  final int index;
  final PageFooter footer;
  final ImageProvider image;
  PdfColor white = PdfColor.fromHex("#ffffff");

  Footer(this.index, this.footer, this.image);
  @override
  Widget build(context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(
          // top: 10,
          ),
      child: Stack(alignment: Alignment.center, children: [
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(index.isOdd ? math.pi : 0),
            child: Image(
              image,
              fit: BoxFit.fitWidth,
            )),
        Positioned(
            bottom: 25,
            child: Text(
                textAlign: TextAlign.center,
                footer.judulFooter,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
        Positioned(
            bottom: 23,
            left: index.isEven
                ? index.toDouble() > 9
                    ? 12.5
                    : 16
                : null,
            right: index.isOdd
                ? index.toDouble() > 9
                    ? 12.5
                    : 16
                : null,
            child: Text(
                textAlign: TextAlign.center,
                index.toString(),
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: white)))
      ]),
    );
  }
}

Future<Uint8List> printAll(PageFooter footer, Bab bab, Tujuan tujuan,
    PetaKonsep petaKonsep, Materi materi) async {
  PdfColor green = PdfColor.fromHex("#22B573");
  PdfColor white = PdfColor.fromHex("#ffffff");
  List<Widget> widgets = [];
  final image = await imageFromAssetBundle('asset/Footer.png');
  final imageHeading1 = await imageFromAssetBundle('asset/Judul Bab.png');
  final imageTujuan = await imageFromAssetBundle('asset/Tujuan.png');
  final imagePetaKonsep = await imageFromAssetBundle('asset/Peta Konsep.png');
  final iamgeMateri = await imageFromAssetBundle('asset/Materi.png');
  final imagePointer = await imageFromAssetBundle('asset/Pointer.png');

  //Profile image
  // buildFooter(int index) =>

  widgets.add(
    Stack(alignment: Alignment.center, children: [
      Image(imageHeading1,
          fit: BoxFit.fitWidth, alignment: Alignment.topCenter, height: 130),
      Positioned(
          top: 36,
          child: Text(
              textAlign: TextAlign.center,
              bab.judulBab,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      Positioned(
          top: 28,
          left: 30,
          child: Column(children: [
            Text(
                textAlign: TextAlign.center,
                "Subbab",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: white)),
            Text(
                textAlign: TextAlign.center,
                bab.bab.toString(),
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: white))
          ]))
    ]),
  );
  final headers = ["No", 'Name', 'Age\nasdasd'];
  final List users = [
    const User(name: 'James', age: 19),
    const User(name: 'ssss2', age: 21),
    const User(name: 'Emma', age: 2)
  ];
  final data = users
      .map((x) => [
            "1",
            x.name,
            x.age,
          ])
      .toList();
  var coba = TableHelper.fromTextArray(
    data: data,
    headers: headers,
    cellAlignment: Alignment.center,
    tableWidth: TableWidth.min,
  );

 





  widgets.add(Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topLeft,
          children: [
            DottedBorder(
                child: Container(
              decoration: BoxDecoration(
                color: PdfColor.fromHex("#DFE3D4"),
              ),
              width: double.infinity,
              child: Padding(
                  padding:
                      EdgeInsets.only(top: 18, left: 15, right: 15, bottom: 15),
                  child: Text(tujuan.tujuan, style: TextStyle(fontSize: 13))),
            )),
            Positioned(top: -20, left: 0, child: Image(imageTujuan, width: 200))
          ])));

  widgets.add(Container(
      child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: [
        DottedBorder(
            child: Container(
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: PdfColor.fromHex("#DFE3D4"),
          ),
          width: double.infinity,
          child: Padding(
              padding:
                  EdgeInsets.only(top: 18, left: 15, right: 15, bottom: 15),
              child: petaKonsep.imagePath != null
                  ? Image(
                      alignment: Alignment.center,
                      MemoryImage(
                        petaKonsep.imagePath!,
                      ),
                    )
                  : SizedBox()),
        )),
        Positioned(
            top: -25,
            left: 0,
            child:
                Image(imagePetaKonsep, width: 200, alignment: Alignment.center))
      ])));
  widgets.add(Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Image(iamgeMateri, width: 200)));

  for (var i = 0; i < materi.listText.length; i++) {
    dev.log("message");
    TextType textType = materi.listText[i].textType;
    switch (textType) {
      case TextType.h1:
        // listH1.add(materi.listText[i]);
        widgets
            .add(Heading1(isi: materi.listText[i], imagePointer: imagePointer));
        break;

      case TextType.h2:
        widgets.add(Heading2(isi: materi.listText[i], ));
        break;
      case TextType.h3:
         widgets.add(Heading3(isi: materi.listText[i], ));
        break;
      case TextType.h4:
       widgets.add(Heading4(isi: materi.listText[i], ));   break;
      case TextType.freeText:
         widgets.add(FreeText(isi: materi.listText[i], ));
        break;
      case TextType.imageSmall:
      // TODO: Handle this case.
      case TextType.imageBig:
      // TODO: Handle this case.
      case TextType.dropCap:
      // TODO: Handle this case.
      case TextType.tabel:
      // TODO: Handle this case.
    }
  }
  widgets.add(coba);

  final pdf = Document();
  pdf.addPage(
    MultiPage(
      pageTheme: const PageTheme(
        margin: EdgeInsets.only(bottom: 40, top: 60, left: 60, right: 60),
        pageFormat: PdfPageFormat.a4,
      ),
      footer: (context) {
        return Footer(context.pageNumber, footer, image);
      },

      build: (context) => widgets, //here goes the widgets list
    ),
  );
  return await pdf.save();
}

class DottedBorder extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final PdfColor color;
  final double strokeWidth;
  final List<double> dashPattern;
  final BorderType borderType;
  final Radius radius;

  DottedBorder({
    required this.child,
    this.padding = const EdgeInsets.all(2),
    this.color = PdfColors.black,
    this.strokeWidth = 2.0,
    this.borderType = BorderType.Rect,
    this.dashPattern = const [20, 20],
    this.radius = const Radius.circular(0),
  });

  @override
  Widget build(context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: (canvas, size) {
              canvas
                ..setLineWidth(strokeWidth)
                ..setStrokeColor(color)
                ..setLineDashPattern(
                  dashPattern,
                );

              switch (borderType) {
                case BorderType.Circle:
                  _getCirclePath(canvas, size);
                case BorderType.Rect:
                  _getRectPath(canvas, size);
                case BorderType.RRect:
                  _getRRectPath(canvas, size, radius.x);
                case BorderType.Oval:
                  _getOvalPath(canvas, size);
              }

              canvas.strokePath(close: true);
            },
          ),
        ),
        Padding(
          padding: padding,
          child: child,
        ),
      ],
    );
  }

  void _getCirclePath(PdfGraphics canvas, PdfPoint size) {
    double w = size.x;
    double h = size.y;
    double s = size.x > size.y ? size.y : size.x;

    canvas.drawRRect(
      w > s ? (w - s) / 1 : 0,
      h > s ? (h - s) / 1 : 0,
      s,
      s,
      s / 1,
      s / 1,
    );
  }

  void _getRRectPath(PdfGraphics canvas, PdfPoint size, double radius) {
    canvas.drawRRect(0, 0, size.x, size.y, radius, radius);
  }

  void _getRectPath(PdfGraphics canvas, PdfPoint size) {
    canvas.drawRect(0, 0, size.x, size.y);
  }

  void _getOvalPath(PdfGraphics canvas, PdfPoint size) {
    canvas.drawEllipse(size.x, size.y, 8, 8);
  }
}

/// The different supported BorderTypes
enum BorderType { Circle, RRect, Rect, Oval }
