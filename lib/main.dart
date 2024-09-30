import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:gmu/home.dart';
import 'package:gmu/input_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmu/pdf_provider.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

void main() async {
 

  WidgetsFlutterBinding.ensureInitialized();

  return runApp(
    MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (context) => BooksProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PdfProvider(null),
        ),
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android:
                    CupertinoPageTransitionsBuilder(), // Apply this to every platforms you need.
              },
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(
                color: Colors.green.withOpacity(0.7),
              ),
              prefixIconColor: Colors.green.withOpacity(0.7),
              prefixStyle: const TextStyle(fontSize: 10),
              // ignore: prefer_const_constructors
              labelStyle: const TextStyle(
                fontSize: 13,
                color: Colors.green,
                letterSpacing: 0.7,
              ),
              contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor: Colors.grey.shade100,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade100, width: 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: 0,
                    style: BorderStyle.solid),
              ),
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.green,
                actionsIconTheme: IconThemeData(color: Colors.white)),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color.fromRGBO(236, 180, 84, 1),
              primary: Colors.green,
            )),
        home: const Home());
  }
}
