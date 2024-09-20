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

import 'package:gmu/models/models.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math; // import this

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> printAll(
    PageFooter footer, Bab bab, Tujuan tujuan, PetaKonsep petaKonsep) async {
  //List of pdf widgets
  List<Widget> widgets = [];
  final image = await imageFromAssetBundle('asset/Footer.png');
  final image2 = await imageFromAssetBundle('asset/Judul Bab.png');

  buildFooter(int index) => Container(
        margin: const EdgeInsets.only(
          top: 10,
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
              bottom: 70,
              child: Text(
                  textAlign: TextAlign.center,
                  footer.judulFooter,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
          Positioned(
              bottom: 70,
              left: index.isEven
                  ? index.toDouble() > 9
                      ? 14
                      : 17
                  : null,
              right: index.isOdd
                  ? index.toDouble() > 9
                      ? 14
                      : 17
                  : null,
              child: Text(
                  textAlign: TextAlign.center,
                  index.toString(),
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: PdfColor.fromHex("#ffffff"))))
        ]),
      );

  widgets.add(
    Stack(alignment: Alignment.center, children: [
      Image(image2, fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
      Positioned(
          top: 36,
          child: Text(
              textAlign: TextAlign.center,
              bab.judulBab,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      Positioned(
          top: 28,
          left: 32,
          child: Column(children: [
            Text(
                textAlign: TextAlign.center,
                "Subbab",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PdfColor.fromHex("#ffffff"))),
            Text(
                textAlign: TextAlign.center,
                bab.bab.toString(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: PdfColor.fromHex("#ffffff")))
          ]))
    ]),
  );
  for (int i = 0; i < 6; i++) {
    widgets.add(
      Text(
        'Heading',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    widgets.add(SizedBox(height: 5));
    widgets.add(
      Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed accumsan augue, ut tincidunt lectus. Vestibulum venenatis euismod eros suscipit rhoncus. Sed vulputate congue turpis ut cursus. Proin sollicitudin nulla vel nisi vulputate sagittis. Morbi neque mauris, auctor id posuere eu, egestas porttitor justo. Donec tempus egestas lorem in convallis. Quisque fermentum, augue ut facilisis pretium, risus dolor viverra est, ac consequat tellus risus vitae sapien. ',
        style: const TextStyle(color: PdfColors.grey),
      ),
    );
  }

  final pdf = Document();

  pdf.addPage(
    MultiPage(
      pageTheme: const PageTheme(
        margin: EdgeInsets.only(bottom: 0, top: 40, left: 40, right: 40),
        pageFormat: PdfPageFormat(190 * 3, 270 * 3),
      ),
      footer: (context) {
        return buildFooter(context.pageNumber);
      },

      build: (context) => widgets, //here goes the widgets list
    ),
  );
  return await pdf.save();
}
