import 'package:gmu/state_management.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/textfield_caption.dart';

class InputBab extends StatelessWidget {
  final TextEditingController _footerConttoler = TextEditingController();
  final TextEditingController _babConttoler = TextEditingController();
  final TextEditingController _judulBabConttoler = TextEditingController();

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
            child: TextFormField(
              maxLines: 10,
            )),
        InputCaption(caption: "Peta Konsep", child: TextFormField()),
        FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.refresh),
            onPressed: () {
              var prov = Provider.of<BooksProvider>(context, listen: false);
              prov.inputJudulFooter = _footerConttoler.text;
              prov.inputJudulBab = _judulBabConttoler.text;
              prov.inputBab = _babConttoler.text;
            }),
      ]),
    );
  }
}
