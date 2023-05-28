import 'package:final_flutter/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/book_provider.dart';
import 'models/book_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BookHelper.bookHelper.initDb();
  runApp(ChangeNotifierProvider<BookProvider>(
      create: (context)=>BookProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: const MaterialColor(
      0xFF845DC5,
      <int, Color>{
        50: Color(0xFFEAE0F1),
        100: Color(0xFFD2B3E1),
        200: Color(0xFFB982D0),
        300: Color(0xFFA051BE),
        400: Color(0xFF8D2DAE),
        500: Color(0xFF845DC5),
        600: Color(0xFF7A4FB7),
        700: Color(0xFF6E43A9),
        800: Color(0xFF63379B),
        900: Color(0xFF4D1F82),
      },
    ),
    ),
      home:  HomeScreen(),
    );
  }
}

