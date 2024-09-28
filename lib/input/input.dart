import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_to_pdf/converter/configurator/converter_option/pdf_page_format.dart';
import 'package:flutter_quill_to_pdf/converter/pdf_converter.dart';
import 'package:gmu/helper/help.dart';
import 'package:gmu/input/component/input_materi.dart';
import 'package:gmu/input/component/rich_text_field.dart';
import 'package:gmu/input_provider.dart';
import 'package:flutter/material.dart';
import 'package:gmu/pdf_provider.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'component/textfield_caption.dart';

class InputBab extends StatefulWidget {
  InputBab({super.key});

  @override
  State<InputBab> createState() => _InputBabState();
}

class _InputBabState extends State<InputBab> {
  final TextEditingController _footerConttoler = TextEditingController();

  final TextEditingController _babConttoler = TextEditingController();

  final TextEditingController _judulBabConttoler = TextEditingController();

  final TextEditingController _tujuuanConttoler = TextEditingController();

  @override
  initState() {
    var prov = Provider.of<BooksProvider>(context, listen: false);
    _footerConttoler.text = prov.footer.judulFooter;
    _babConttoler.text = prov.bab.bab.toString();
    _judulBabConttoler.text = prov.bab.judulBab;
    _tujuuanConttoler.text = prov.tujuan.tujuan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(addAutomaticKeepAlives: false, children: [
        Row(
          children: [
            Flexible(
                flex: 3,
                child: InputCaption(
                    caption: "Bab",
                    child: TextFormField(
                      controller: _babConttoler,
                      maxLines: 1,
                    ))),
            Flexible(
                flex: 10,
                child: InputCaption(
                    caption: "Judul",
                    child: TextFormField(
                      controller: _judulBabConttoler,
                      maxLines: 1,
                    ))),
          ],
        ),
        InputCaption(
            caption: "Judul Footer",
            child: TextFormField(
              controller: _footerConttoler,
              onChanged: (value) {},
              maxLines: 1,
            )),
        InputCaption(
            caption: "Tujuan",
            child: TextFormField(
              controller: _tujuuanConttoler,
              textInputAction: TextInputAction.newline,
              onChanged: (value) {},
              maxLines: 100,minLines: 1,
            )),
        Consumer<BooksProvider>(builder: (context, book, c) {
          return InputCaption(
              caption: "PetaKonsep",
              child: book.selectedImage != null
                  ? GestureDetector(
                      onTap: () async {
                        book.pickImage();
                      },
                      child: Image.memory(
                        book.selectedImage!,
                      ))
                  : IconButton(
                      onPressed: () async {
                        book.pickImage();
                      },
                      icon: Icon(Icons.add_photo_alternate_rounded)));
        }),
        InputCaption(
            caption: "Materi",
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8)),
                child: InputMateri())),

    
        FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.refresh),
            onPressed: () async{
              var prov = Provider.of<BooksProvider>(context, listen: false);
              prov.inputJudulFooter = _footerConttoler.text;
              prov.inputJudulBab = _judulBabConttoler.text;
              prov.inputBab = _babConttoler.text;
              prov.inputTujuan = _tujuuanConttoler.text;
              Provider.of<PdfProvider>(context,listen: false).setPdf=await prov.generatePDF();
            }),
      ]);
    
  }
}
