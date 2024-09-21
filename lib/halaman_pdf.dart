import 'dart:developer';
import 'dart:typed_data';

import 'package:gmu/state_management.dart';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class HalamanPDFSoalState extends StatefulWidget {
  const HalamanPDFSoalState({super.key});

  @override
  State<HalamanPDFSoalState> createState() => _HalamanPDFSoalStateState();
}

class _HalamanPDFSoalStateState extends State<HalamanPDFSoalState> {
  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Uint8List? asu;
  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(builder: (context, book, child) {
          return  Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () async {
            await Printing.sharePdf(bytes: asu!, filename: "");
          },
          child: IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              )),
        ),
        backgroundColor: Colors.white,
        body: PdfPreview(
            loadingWidget: const Text('Loading...'),
            onError: (context, error) => const Text('Error...'),
            pdfFileName: 'Buku.pdf',
            canDebug: false,
            allowPrinting: false,
            actions: const [],
            allowSharing: false,
            build: (format) async {
              log("Build PDF");
              asu = await book.generatePDF();
              return asu!;
            },
            canChangeOrientation: false,
            canChangePageFormat: false,
            onShared: _showSharedToast,
          ));});
        
  }
}
