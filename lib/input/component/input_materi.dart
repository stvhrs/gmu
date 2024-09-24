import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill_to_pdf/converter/configurator/pdf/pdf_configurator.dart';
import 'package:gmu/models/models.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import '../../input_provider.dart';
import 'package:collection/collection.dart';

class InputMateri extends StatefulWidget {
  const InputMateri({super.key});

  @override
  State<InputMateri> createState() => _InputMateriState();
}

class _InputMateriState extends State<InputMateri> {
  List<TextEditingController> subMateriCon = [];
  @override
  initState() {
    var prov = Provider.of<BooksProvider>(context, listen: false);
    for (var j = 0; j < prov.materi.listText.length; j++) {
      if (prov.materi.listText[j].textType != TextType.imageBig ||
          prov.materi.listText[j].textType != TextType.imageSmall ||
          prov.materi.listText[j].textType != TextType.tabel) {
        subMateriCon
            .add(TextEditingController()..text = prov.materi.listText[j].text);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(builder: (context, book, c) {
      return Column(children: [
        ...book.materi.listText
            .mapIndexed(
              (index, text) => TextFormField(
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    contentPadding: text.textType == TextType.h4 ||
                            text.textType == TextType.h3
                        ? EdgeInsets.only(
                            left: text.textType == TextType.h4 ? 60 : 30)
                        : EdgeInsets.all(10),
                    suffixIcon: InkWell(
                        onTap: () {
                          subMateriCon.removeAt(index);
                          book.removeMateri(text);
                        },
                        child: Icon(Icons.delete)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.solid),
                    )),
                maxLines: 100,
                minLines: 1,
                style: TextStyle(
                    color: text.textType == TextType.h2
                        ? Colors.green
                        : Colors.black,
                    fontWeight: (text.textType != TextType.h4)
                        ? FontWeight.bold
                        : FontWeight.normal),
                controller: subMateriCon[index],
              ),
            )
            .toList(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                subMateriCon
                    .add(TextEditingController()..text = "Senyawa Hidrokarbon");
                book.addSubMateri(IsiMateri(
                    textType: TextType.h1, text: "Senyawa Hidrokarbon"));
              },
              child: Text("h1"),
            ),
            ElevatedButton(
              onPressed: () {
                subMateriCon.add(TextEditingController()..text = "1.  Alkana");
                book.addSubMateri(
                    IsiMateri(textType: TextType.h2, text: "1.  Alkana"));
              },
              child: Text("h2"),
            ),
            ElevatedButton(
              child: Text("h3"),
              onPressed: () {
                subMateriCon.add(TextEditingController()
                  ..text = "a.  Tata nama Alkohol (Alkanol)");
                book.addSubMateri(IsiMateri(
                    textType: TextType.h3,
                    text: "a.  Tata nama Alkohol (Alkanol)"));
              },
            ),
            ElevatedButton(
              onPressed: () {
                subMateriCon.add(TextEditingController()
                  ..text =
                      ".      Banyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berba");
                book.addSubMateri(IsiMateri(
                    textType: TextType.freeText,
                    text:
                        ".      Banyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berba"));
              },
              child: Text("h4"),
            ),
            ElevatedButton(
              onPressed: () {
                subMateriCon.add(TextEditingController()
                  ..text =
                      ".      Banyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berba");
                book.addSubMateri(IsiMateri(
                    textType: TextType.h4,
                    text:
                        ".      Banyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berbaBanyaknya jenis dan jumlah senyawa karbon tidak terlepas dari sifat khas atom karbonyang dapat membentuk senyawa dengan berba"));
              },
              child: Text("h4"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Tabel"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Drop Cap"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Image Small"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Image Big"),
            )
          ],
        ),
      ]);
    });
  }
}
