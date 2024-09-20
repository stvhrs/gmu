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
//#22B573
Future<Uint8List> printAll(
    PageFooter footer, Bab bab, Tujuan tujuan, PetaKonsep petaKonsep) async {

  List<Widget> widgets = [];
  final image = await imageFromAssetBundle('asset/Footer.png');
  final image2 = await imageFromAssetBundle('asset/Judul Bab.png');
  final image3 = await imageFromAssetBundle('asset/Tujuan.png');

  //Profile image
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: PdfColor.fromHex("#ffffff"))))
        ]),
      );

  widgets.add(
    Stack(alignment: Alignment.center, children: [
      Image(image2,
          fit: BoxFit.fitWidth, alignment: Alignment.topCenter, height: 130),
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
  widgets.add(Stack(
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
              child: Text(
                  tujuan.tujuan)),
        )),
        Positioned(top: -20, left: 0, child: Image(image3, width: 225))
      ]));
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
