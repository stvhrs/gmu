import 'package:flutter_quill/flutter_quill.dart';
import 'package:gmu/input/component/rich_text_field.dart';
import 'package:gmu/state_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/textfield_caption.dart';

class InputBab extends StatelessWidget {
  final TextEditingController _footerConttoler = TextEditingController();
  final TextEditingController _babConttoler = TextEditingController();
  final TextEditingController _judulBabConttoler = TextEditingController();
    final TextEditingController _tujuuanConttoler = TextEditingController();


  InputBab({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
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
            child: TextFormField(controller: _tujuuanConttoler  ,
              maxLines: 10,
            )),
        InputCaption(caption: "Peta Konsep", child: TextFormField()),
           InputCaption(caption: "Rich Text", child: SizedBox(height: 500,child: RichTextField(controller: QuillController.basic(),))),
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
