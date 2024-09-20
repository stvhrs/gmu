import 'package:gmu/halaman_pdf.dart';
import 'package:gmu/input/input.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 40,left: 40,right: 30),
            child: 
                InputBab()
                // Row(
                //   children: [
                //     Flexible(
                //       child: Text(
                //           textAlign: TextAlign.justify,
                //           softWrap: true,
                //           "utate congue turpis ut cursus. Proin sollicitudin nulla vel nisi vulputate sagittis. Morbi neque mauris, auctor id posuere eu, egestas porttitor justo. Donec tempus egestas lorem in convallis. Quisque fermentum, augue ut facilisis pretium, risus dolor viverra est, ac consequat tellus risus vitae sapien.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed accumsan augue, ut tincidunt lectus. Vestibulum venenatis euismod eros suscipit rhoncus. Sed vulputate congue turpis ut cursus. Proin sollicitudin nulla vel nisi vulputate sagittis. Morbi neque mauris, auctor id posuere eu, egestas porttitor justo. Donec tempus egestas lorem in convallis. Quisque fermentum, augue ut facilisis pretium, risus dolor viverra est, ac consequat tellus risus vitae sapien.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed accumsan augue, ut tincidunt lectus. Vestibulum venenatis euismod eros suscipit rhoncus. Sed vulputate congue turpis ut cursus. Proin sollicitudin nulla vel nisi vulputate sagittis. Morbi neque mauris, auctor id posuere eu, egestas porttitor justo. Donec tempus egestas lorem in convallis. Quisque fermentum, augue ut facilisis pretium, risus dolor viverra est, ac consequat tellus risus vitae sapien.  "),
                //     ),
                //     Flexible(
                //       child: Image.asset(
                //         "asset/beli.png",
                //       ),
                //     )
                //   ],
                // ),
              
            
          ),
        ),
        const Expanded(child: HalamanPDFSoalState()),
      ],
    ));
  }
}
