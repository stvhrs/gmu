import 'package:Bupin/home.dart';
import 'package:Bupin/state_management.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//PodVideoPlayer.enableLogs = true;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  return runApp( ChangeNotifierProvider(
      create: (context) => BooksProvider(),
      child: const MyApp(),
    ),);
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
              prefixIconColor:
                  Colors.green.withOpacity(0.7),
              prefixStyle: const TextStyle(fontSize: 10),
              // ignore: prefer_const_constructors
              labelStyle: const TextStyle(
                fontSize: 13,
                color: Colors.green,
                letterSpacing: 0.7,
              ),
              contentPadding:
                   const EdgeInsets.all(10),
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
        home:  const Home()
               );
  }
}
