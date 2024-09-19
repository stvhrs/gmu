
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';

// class DottedBorder extends StatelessWidget {
//   final EdgeInsets padding;
//   final Widget child;
//   final PdfColor color;
//   final double strokeWidth;
//   final List<double> dashPattern;
//   final BorderType borderType;
//   final Radius radius;

//   DottedBorder({
//     required this.child,
//     this.padding = const EdgeInsets.all(2),
//     this.color = PdfColors.black,
//     this.strokeWidth = 1.0,
//     this.borderType = BorderType.Rect,
//     this.dashPattern = const [3, 1],
//     this.radius = const Radius.circular(0),
//   });

//   @override
//   Widget build( context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: CustomPaint(
//             painter: (canvas, size) {
//               canvas
//                 ..setLineWidth(strokeWidth)
//                 ..setStrokeColor(color)
//                 ..setLineDashPattern(dashPattern);

//               switch (borderType) {
//                 case BorderType.Circle:
//                   _getCirclePath(canvas, size);
//                 case BorderType.Rect:
//                   _getRectPath(canvas, size);
//                 case BorderType.RRect:
//                   _getRRectPath(canvas, size, radius.x);
//                 case BorderType.Oval:
//                   _getOvalPath(canvas, size);
//               }

//               canvas.strokePath(close: true);
//             },
//           ),
//         ),
//         Padding(
//           padding: padding,
//           child: child,
//         ),
//       ],
//     );
//   }

//   void _getCirclePath(PdfGraphics canvas, PdfPoint size) {
//     double w = size.x;
//     double h = size.y;
//     double s = size.x > size.y ? size.y : size.x;

//     canvas.drawRRect(
//       w > s ? (w - s) / 2 : 0,
//       h > s ? (h - s) / 2 : 0,
//       s,
//       s,
//       s / 2,
//       s / 2,
//     );
//   }

//   void _getRRectPath(PdfGraphics canvas, PdfPoint size, double radius) {
//     canvas.drawRRect(0, 0, size.x, size.y, radius, radius);
//   }

//   void _getRectPath(PdfGraphics canvas, PdfPoint size) {
//     canvas.drawRect(0, 0, size.x, size.y);
//   }

//   void _getOvalPath(PdfGraphics canvas, PdfPoint size) {
//     canvas.drawEllipse(size.x, size.y, 8, 8);
//   }
// }

// /// The different supported BorderTypes
// enum BorderType { Circle, RRect, Rect, Oval }

