import 'dart:developer';
import 'dart:typed_data';

import 'package:gmu/input_provider.dart';

import 'package:flutter/material.dart';
import 'package:gmu/pdf_provider.dart';
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

  bool loading = true;
  init() async {
    loading = true;
    asu =
        await Provider.of<BooksProvider>(context, listen: false).generatePDF();
    Provider.of<PdfProvider>(context, listen: false).setPdf = asu!;

    loading = false;
    setState(() {});
  }

  initState() {
    init();
    super.initState();
  }

  Uint8List? asu;
  @override
  Widget build(BuildContext context) {
    log("pdf");
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Consumer<PdfProvider>(builder: (context, book, child) {
            asu = book.pdf;
            return Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () async {
                    await Printing.sharePdf(bytes: asu!, filename: "");
                  },
                  child: Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
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
                    return asu!;
                  },
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  onShared: _showSharedToast,
                ));
          });
  }
}
