import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_to_pdf/converter/configurator/converter_option/pdf_page_format.dart';
import 'package:flutter_quill_to_pdf/converter/pdf_converter.dart';
import 'package:gmu/input/component/rich_text_field.dart';
import 'package:gmu/state_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'component/textfield_caption.dart';

class InputBab extends StatelessWidget {
  final TextEditingController _footerConttoler = TextEditingController();
  final TextEditingController _babConttoler = TextEditingController();
  final TextEditingController _judulBabConttoler = TextEditingController();
  final TextEditingController _tujuuanConttoler = TextEditingController();
  final QuillController _quillController = QuillController.basic();

  InputBab({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              maxLines: 10,
            )),
        Consumer<BooksProvider>(builder: (context, book, c) {
          return InputCaption(
              caption: "PetaKonsep",
              child: book.selectedImage != null
                  ? GestureDetector(onTap: ()async{
                     book.pickImage();
                  },child: Image.memory(book.selectedImage!, ))
                  : IconButton(
                      onPressed: () async {
                        book.pickImage();
                      },
                      icon: Icon(Icons.add_photo_alternate_rounded)));
        }),
        InputCaption(
            caption: "Rich Text",
            child: SizedBox(
                height: 500,
                child: RichTextField(controller: _quillController))),
        FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.refresh),
            onPressed: () {
              var prov = Provider.of<BooksProvider>(context, listen: false);
              prov.inputJudulFooter = _footerConttoler.text;
              prov.inputJudulBab = _judulBabConttoler.text;
              prov.inputBab = _babConttoler.text;
              prov.inputTujuan = _tujuuanConttoler.text;
              
            }),
      ]),
    );
  }
}
