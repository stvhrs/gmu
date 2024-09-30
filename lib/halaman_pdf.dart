import 'dart:developer';
import 'dart:typed_data';

import 'package:gmu/input_provider.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
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
    var document = parse(
        "<p>Cermati data berikut ini!</p>\r\n<p><img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA6wAAAD6CAMAAACS2joBAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAMAUExURf///3NzaykpKc7Ozt7e1jExMWNjWvf39yEhId7m3u/v78W9vYSEhM7O1pyUnBAZGQAAAEI6OjE6OggQCGNra6WtpUpSSoyMlISMhLW1rXNze1paWqWlpc4QhEpCSrW9vRneexneMRmcexmcMRAQSq3m5nNjEFpjlM5ChHM6GZxrhHMQGdZaSkIQQtaUa9YZSq2Ua1ree1reMVqce1qcMffWxc5rhHM6SnNjQhBrGWOcpXMQShBCGdbmrZxa5pwZ5pxatZwZtXta5nsZ5ntatXsZtToQEM6UpdaczmPO5lIQe2OczhBje2POrRkQe85r5s4p5q3mvc5rtc4ptZwQhKVrGaUpGc5K5s4I5q3mnM5Ktc4ItXsQhKVKGaUIGSneWineECmcWimcEAjeWgjeEAicWgicEK2UziljSoSUY6VrSqUpShA6SghjSqVKSqUISs7ve1Jr7zrv5s7vOkJrGVIp7zqt5s6tOpxChJTvexlr7zrvrZTvOhkp7zqtrZStOtZrGdYpGdac787Fe1JrxRDv5s7vEFIpxRCt5s6tEJTFexlrxRDvrZTvEBkpxRCtrZStEGPv5lIQnGOc7xBjnGPvrRkQnFrvWlrvEFqtWlqtEITO5lIxe4SczjFje4TOrRkxe87vWlJK7zrO5s7OOkJKGVII7zqM5s6MOntChJTvWhlK7zrOrZTOOhkI7zqMrZSMOtZKGdYIGc7FWlJKxRDO5s7OEFIIxRCM5s6MEJTFWhlKxRDOrZTOEBkIxRCMrZSMEFrOWlrOEFqMWlqMEPdajPdaOvcZjPcZOvecjPecOq2U7/daY/daEPcZY/cZEPecY/ecEITv5lIxnISc7zFjnITvrRkxnPdC5vcQ5vdCtfcQtfdz5vdztffejPfeOq295vfeY/feENa1pfel5veltda95ntjWs7v5oylpUIxEPfO9/f/Ovf/vVpSaxAQKd7v99bmzt7W7yEIEM7O79a9vXNja0IxMd7O1iEhCGNzWikQKWNSWt7Ozu///wAAAPqKBQcAAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAABcRAAAXEQHKJvM/AAAmn0lEQVR4Xu2dD3fbqNKHZQERxhgkG+wIcuD7f7m2sc9x4sTpeWeQ7Ha3u3vv2chpfN952nWQxB91T36aGcCaiiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiAIgiCIX1F8x+kv/aW/H/FXqVF2/woeBUEQH4QfdfevyFY6d0d/6A/9ufofl9ow6u5fsZB6LBEEcV147cbSvyLL7VgiCOK6cPkuy8rIshLEB8HEYSz9KzKJlSA+CEaWlSBuA17PxtK/giwrQXwU77Ssv84GZ5Phc+fZcIioXiNBaz6e+QPZPI+l66B6/49ryUx7uC/lzbtWnAni2nD5Lsv6Z7HyB2FR/fwQFpff/ecgbGv39bENu/HUD5QX8l1Lvf8JvhXdXz4kzjykw7Lixsq38QRBfEpYPWXMqsJr2+KMleIuPVzUylnXnjLzext/kU1Orf1ny/c+lBGtWI4Hf4liXGGtrz85AwTx+Vi+d531j2L1brCscCUm9IdHnDVV1YRfddm8BXlVy6rySaZ/tKyIyne2/o+1COJ3MvVssArHWVNKeRN++JWnFuNV1tnDL4pQm9eHocWVyCn9o2UdyEKSZSU+NW9i2tlgHs7qb0z341q0GkzqPLYOxKqQ4TwUeJK+gZ8g2OFzuF4qwMe5OFAO1PADG43nhnaVwlNjmx+N+lV6HM7BwY9LY12gfPZ1TWIlPjVTzwbzmTzvsuB1+jYWq9NaQ3me0LKymLrOFR/5zaW03UjDdEoehJ4iusn3KYmE4mbOqNClH5PI3HVfFiwvXIL2LKVDVthK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\" width=\"534\" height=\"142\" /></p>\r\n<p>Dari data diatas yang berdasarkan suara terdapat di dalam paduan suara adalah...</p>");

    for (var i = 0; i < document.querySelectorAll("p").length; i++) {
      var data = document.querySelectorAll("p")[i].innerHtml.toString();
      if (data.contains("img src")) {
        var image = document.querySelectorAll("p")[i];
        dom.Element? link = image.querySelector('img');
        String? imageLink = link != null ? link.attributes['src'] : "";
        log(imageLink.toString().replaceAll("data:image/png;base64,", ""));
      } else {
        log(document.querySelectorAll("p")[i].innerHtml.toString());
      }
    }
    super.initState();
  }

  Uint8List? asu;
  @override
  Widget build(BuildContext context) {
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
